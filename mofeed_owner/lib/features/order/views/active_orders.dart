import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeed_owner/features/order/cubit/order_cubit.dart';
import 'package:mofeed_owner/features/restraurant/cubit/restarant_cubit.dart';
import 'package:mofeed_owner/features/restraurant/cubit/restarant_state.dart';
import 'package:mofeed_owner/shared/router/app_routes.dart';
import 'package:mofeed_shared/constants/app_constants.dart';
import 'package:mofeed_shared/utils/const_methods.dart';
import 'package:mofeed_shared/utils/enums/restarant.dart';
import 'package:mofeed_shared/utils/extensions/status_builder.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';
import 'package:mofeed_shared/utils/style/shapes.dart';

import '../../../shared/sl/service_locator.dart';
import '../cubit/order_state.dart';
import '../widget/active_orders_builder.dart';

class ActiveOrders extends StatelessWidget {
  const ActiveOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      child: CustomScrollView(
        slivers: [
          const ActiveOrdersBuilder().toSliver,
        ],
      ),
      listeners: [
        BlocListener<OrderCubit, OrderState>(
          listener: (context, state) {
            state.status.when({
              CubitOrderStatus.loading: () => showLoader(context),
              CubitOrderStatus.error: () => showSnackBar(context,
                  message: state.error, doBefore: () => Navigator.pop(context)),
              CubitOrderStatus.orderUpdated: () {
                navigateTo(context,
                    routeName: Routes.orderTracking,
                    args: state.recentOrder!,
                    doBefore: () => Navigator.pop(context));
              },
            });
          },
          listenWhen: (prev, curr) => prev.status != curr.status,
        ),
      ],
    );
  }
}

class _RestarantStatus extends StatefulWidget {
  const _RestarantStatus({super.key});

  @override
  State<_RestarantStatus> createState() => _RestarantStatusState();
}

class _RestarantStatusState extends State<_RestarantStatus> {
  late RestarantCubit restarantCubit;

  @override
  void initState() {
    restarantCubit = sl<RestarantCubit>()..getRestuanrt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestarantCubit, RestarantState>(
        builder: (context, state) {
      final rest = state.restarant;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(rest.name[context.lang], style: context.displaySmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: RestarantStateEnum.values
                  .map(
                    (e) => GestureDetector(
                      onTap: () =>
                          context.read<RestarantCubit>().changeAvailabilty(e),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: rest.state == e ? e.color : Colors.transparent,
                          borderRadius: 8.circle,
                        ),
                        child: Text(
                          e.tr(context.lang),
                          style: context.titleLarge.copyWith(
                            color: rest.state == e ? Colors.white : e.color,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      );
    });
  }
}
