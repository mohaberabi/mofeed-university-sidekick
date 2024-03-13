import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/order/cubit/order_cubit/order_cubit.dart';
import 'package:mofeduserpp/features/rating/cubit/rating_cubit.dart';
import 'package:mofeduserpp/features/rating/cubit/rating_state.dart';
import 'package:mofeed_shared/constants/const_methods.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/custom_texfield.dart';
import 'package:mofeed_shared/ui/widgets/loader.dart';
import 'package:mofeed_shared/ui/widgets/primary_button.dart';
import 'package:mofeed_shared/ui/widgets/rating_builder.dart';
import 'package:mofeed_shared/utils/extensions/media_query_ext.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/status_builder.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';

class OrderRater extends StatelessWidget {
  final String title;
  final String restaurantId;
  final String orderId;

  const OrderRater({
    super.key,
    required this.title,
    required this.restaurantId,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<RatingCubit, RatingState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.sm),
            children: [
              SizedBox(
                width: context.width * 0.8,
                child: Text(
                  title,
                  style: context.headLineLarge,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              RatingBuilder(
                value: state.value,
                length: 5,
                onTap: (index) =>
                    context.read<RatingCubit>().ratingValueChange(index),
              ),
              const SizedBox(height: AppSpacing.lg),
              CustomTextField(
                filled: false,
                label: l10n.writeSomeReview,
                isColumed: false,
                isOutlined: false,
                maxLength: 200,
                onChanged: (v) =>
                    context.read<RatingCubit>().ratingTextChanged(v),
              ),
              const SizedBox(height: AppSpacing.lg),
              state.status.builder({RatingStatus.loading: () => const Loader()},
                  placeHolder: PrimaryButton(
                    onPress: state.value > -1
                        ? () => context
                            .read<RatingCubit>()
                            .rate(restaurantId: restaurantId, orderId: orderId)
                        : null,
                    label: l10n.leaveReview,
                  )),
            ],
          ),
        );
      },
      listener: (context, state) {
        state.status.when({
          RatingStatus.error: () => context.showSnackBar(
              message: l10n.localizeError(state.error),
              state: FlushBarState.error),
          RatingStatus.rated: () => context.showSnackBar(
              message: l10n.yourFeedBackPosted,
              doBefore: () {
                context.read<OrderCubit>().getOrders();

                context.pop();
              }),
        });
      },
      listenWhen: (prev, curr) => prev.status != curr.status,
    );
  }
}
