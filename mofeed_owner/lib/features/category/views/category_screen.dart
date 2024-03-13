import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_court/model/category_model.dart';
import 'package:mofeed_owner/features/category/cubit/category_cubit.dart';
import 'package:mofeed_owner/features/category/cubit/category_state.dart';
import 'package:mofeed_owner/features/category/widget/category_widget.dart';
import 'package:mofeed_shared/constants/app_icons.dart';
import 'package:mofeed_shared/utils/const_methods.dart';
import 'package:mofeed_shared/utils/extensions/status_builder.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/input_formatters.dart';
import 'package:mofeed_shared/widgets/app_view_builder.dart';
import 'package:mofeed_shared/widgets/custom_texfield.dart';
import 'package:mofeed_shared/widgets/loader.dart';
import 'package:mofeed_shared/widgets/my_place_holder.dart';
import 'package:mofeed_shared/widgets/primary_button.dart';

import '../../../shared/sl/service_locator.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Categories"),
          actions: [
            IconButton(
                onPressed: () {
                  showAppSheet(context,
                      scrollable: true,
                      child: const _CategoryAdder(),
                      title: "Add Category",
                      titleStyle: context.headLineLarge);
                },
                icon: const AppIcon(AppIcons.edit)),
          ],
        ),
        body: const CategoryBuilder());
  }
}

class _CategoryAdder extends StatelessWidget {
  const _CategoryAdder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      builder: (context, state) {
        return ListView(
          children: [
            CustomTextField(
              onChanged: (v) =>
                  context.read<CategoryCubit>().formChanged(ar: v),
              label: "Name Arabic ",
            ),
            const SizedBox(height: 16),
            CustomTextField(
              onChanged: (v) =>
                  context.read<CategoryCubit>().formChanged(en: v),
              label: "Name English  ",
            ),
            const SizedBox(height: 16),
            CustomTextField(
              textInputType: TextInputType.number,
              inputFomratters: [
                InputFormaters.onlyNumbers,
              ],
              onChanged: (v) =>
                  context.read<CategoryCubit>().formChanged(en: v),
              label: "Order in menu",
              hint:
                  "order means when user shall see this category when exploring ",
            ),
            const SizedBox(height: 16),
            state.status.builder({
              CategoryStatus.loading: () => const Loader(),
            },
                placeHolder: PrimaryButton(
                  onPress: state.readyToAdd
                      ? () => context.read<CategoryCubit>().addCategory()
                      : null,
                  label: "Add Category",
                ))
          ],
        );
      },
      listener: (context, state) {
        state.status.when({
          CategoryStatus.error: () => showSnackBar(context,
              message: state.error, state: FlushBarState.error),
          CategoryStatus.added: () =>
              showSnackBar(context, message: "Category Added", doBefore: () {
                Navigator.pop(context);
                context.read<CategoryCubit>().clearCategory();
              }),
        });
      },
      listenWhen: (prev, curr) => prev.status != curr.status,
    );
  }
}

class CategoryBuilder extends StatefulWidget {
  final void Function(CategoryModel)? onTap;

  const CategoryBuilder({
    super.key,
    this.onTap,
  });

  @override
  State<CategoryBuilder> createState() => _CategoryBuilderState();
}

class _CategoryBuilderState extends State<CategoryBuilder> {
  late CategoryCubit categoryCubit;

  @override
  void initState() {
    categoryCubit = sl<CategoryCubit>()..getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        final view = AppViewBuilder.list(
            onRefresh: () async => categoryCubit.getCategories(),
            builder: (context, index) {
              final category = state.categories[index];
              return CategoryWidget(
                category: category,
                onTap: widget.onTap,
              );
            },
            count: state.categories.length,
            placeHolder: AppPlaceHolder.empty(
              subtitle:
                  "Start adding your categories to start accepting orders",
              title: "No Categories added yet ",
            ));
        return state.status.builder({
          CategoryStatus.loading: () => const Loader(),
          CategoryStatus.error: () =>
              AppPlaceHolder.error(onTap: () => categoryCubit.getCategories()),
          CategoryStatus.populated: () => view,
        });
      },
    );
  }
}
