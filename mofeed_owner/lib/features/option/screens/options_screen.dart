import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_court/model/food_option.dart';
import 'package:food_court/model/option_group.dart';
import 'package:mofeed_owner/features/option/cubit/option_cubit.dart';
import 'package:mofeed_owner/features/option/cubit/option_state.dart';
import 'package:mofeed_owner/features/option/widget/group_option_widget.dart';
import 'package:mofeed_owner/shared/router/app_routes.dart';
import 'package:mofeed_shared/utils/const_methods.dart';
import 'package:mofeed_shared/utils/extensions/status_builder.dart';
import 'package:mofeed_shared/widgets/app_view_builder.dart';
import 'package:mofeed_shared/widgets/loader.dart';
import 'package:mofeed_shared/widgets/my_place_holder.dart';

import '../../../shared/sl/service_locator.dart';

class FoodOptionScreen extends StatelessWidget {
  const FoodOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              navigateTo(context, routeName: Routes.addFoodOption);
            },
            icon: const Icon(Icons.add),
          ),
        ],
        title: Text("Options"),
      ),
      body: const OptionsBuilder(),
    );
  }
}

class OptionsBuilder extends StatefulWidget {
  final void Function(OptionGroup)? onTap;
  final bool selectable;
  final bool Function(OptionGroup)? selected;

  const OptionsBuilder({
    super.key,
    this.onTap,
    this.selectable = false,
    this.selected,
  });

  @override
  State<OptionsBuilder> createState() => _OptionsBuilderState();
}

class _OptionsBuilderState extends State<OptionsBuilder> {
  late OptionCubit optionCubit;

  @override
  void initState() {
    optionCubit = sl<OptionCubit>()..getOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OptionCubit, OptionState>(
        builder: (context, state) {
          final view = AppViewBuilder.list(
              onRefresh: () async => optionCubit.getOptions(),
              builder: (context, index) {
                final option = state.options[index];
                return GroupOptionWidget(
                  selected: widget.selected,
                  selectable: widget.selectable,
                  option: option,
                  onTap: widget.onTap ??
                      (option) => navigateTo(context,
                          routeName: Routes.addFoodOption,
                          doBefore: () => context
                              .read<OptionCubit>()
                              .optionGroupChanged(option)),
                );
              },
              count: state.options.length,
              placeHolder:
                  AppPlaceHolder.empty(title: "No Food Options added yet "));
          return state.status.builder({
            OptionStatus.loading: () => const Loader(),
            OptionStatus.error: () =>
                AppPlaceHolder.error(onTap: () => optionCubit.getOptions()),
            OptionStatus.populated: () => view,
          }, placeHolder: view);
        },
        listener: (context, state) {});
  }
}
