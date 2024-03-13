import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_court/utils/enums/cuisine.dart';
import 'package:mofeed_owner/features/restraurant/cubit/restarant_cubit.dart';
import 'package:mofeed_owner/features/restraurant/cubit/restarant_state.dart';
import 'package:mofeed_shared/constants/app_icons.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/widgets/chip_builder.dart';
import 'package:mofeed_shared/widgets/cta.dart';
import 'package:mofeed_shared/widgets/custom_texfield.dart';
import 'package:mofeed_shared/widgets/loader.dart';
import 'package:mofeed_shared/widgets/my_place_holder.dart';
import 'package:mofeed_shared/widgets/primary_button.dart';

import '../../../shared/sl/service_locator.dart';

class RestuarantInfoScreen extends StatefulWidget {
  const RestuarantInfoScreen({super.key});

  @override
  State<RestuarantInfoScreen> createState() => _RestuarantInfoScreenState();
}

class _RestuarantInfoScreenState extends State<RestuarantInfoScreen> {
  late RestarantCubit restarantCubit;

  @override
  void initState() {
    restarantCubit = sl<RestarantCubit>()..getRestuanrt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Information"),
      ),
      body: BlocBuilder<RestarantCubit, RestarantState>(
        builder: (context, state) {
          return state.state.builder(
            onLoading: () => const Loader(),
            onError: () => AppPlaceHolder.error(
              onTap: () {},
            ),
            onDone: () {
              final rest = state.restarant;
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  CustomTextField(
                    label: "Arabic name",
                    initialValue: rest.name['ar'],
                    onChanged: (v) => restarantCubit.formChanged(ar: v),
                  ),
                  CustomTextField(
                    label: "English name",
                    initialValue: rest.name['en'],
                    onChanged: (v) => restarantCubit.formChanged(en: v),
                  ),
                  CustomTextField(
                    label: "Minimum Pickup Time",
                    initialValue: rest.name['ar'],
                  ),
                  SwitchListTile.adaptive(
                      title: Text(
                          "Delivering to faculties & university buildings"),
                      value: rest.offersDelivery,
                      onChanged: (v) =>
                          restarantCubit.formChanged(facultyHandover: v)),
                  CallToAction.custom(
                    title: "Cuisines",
                    leading: const AppIcon(AppIcons.pizza),
                    action: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return _CuisinePicker();
                          });
                    },
                  ),
                  PrimaryButton(
                    onPress: state.readyUpdate
                        ? () => restarantCubit.updateRestarant()
                        : null,
                    label: "Save",
                  ),
                ]
                    .map((e) => Padding(
                          padding: EdgeInsets.all(8),
                          child: e,
                        ))
                    .toList(),
              );
            },
          );
        },
      ),
    );
  }
}

class _CuisinePicker extends StatelessWidget {
  const _CuisinePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestarantCubit, RestarantState>(
        builder: (context, state) {
      return ChipBuilder<Cuisine>(
          items: Cuisine.values,
          selected: (c) => state.restarant.cuisines.contains(c),
          title: (c) => c.tr(context.lang),
          onTap: (c) => context.read<RestarantCubit>().formChanged(cuisine: c));
    });
  }
}
