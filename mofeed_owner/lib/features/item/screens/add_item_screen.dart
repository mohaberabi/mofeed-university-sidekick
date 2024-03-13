import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeed_owner/features/category/views/category_screen.dart';
import 'package:mofeed_owner/features/gallery/views/gallery_screen.dart';
import 'package:mofeed_owner/features/item/cubit/item_cubit.dart';
import 'package:mofeed_owner/features/item/cubit/item_state.dart';
import 'package:mofeed_owner/features/option/cubit/option_cubit.dart';
import 'package:mofeed_owner/features/option/screens/options_screen.dart';
import 'package:mofeed_owner/features/option/widget/group_option_widget.dart';
import 'package:mofeed_owner/shared/router/app_routes.dart';
import 'package:mofeed_shared/utils/const_methods.dart';
import 'package:mofeed_shared/utils/extensions/status_builder.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';
import 'package:mofeed_shared/utils/input_formatters.dart';
import 'package:mofeed_shared/utils/style/shapes.dart';
import 'package:mofeed_shared/widgets/cached_image.dart';
import 'package:mofeed_shared/widgets/custom_texfield.dart';
import 'package:mofeed_shared/widgets/loader.dart';
import 'package:mofeed_shared/widgets/my_place_holder.dart';
import 'package:mofeed_shared/widgets/primary_button.dart';

import '../../../shared/sl/service_locator.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  late ItemCubit itemCubit;

  @override
  void initState() {
    itemCubit = sl<ItemCubit>()..getItemVariants();
    super.initState();
  }

  @override
  void dispose() {
    itemCubit.clearForm();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageChanger = TextButton.icon(
        onPressed: () {
          showAppSheet(context, child: GalleryBuilder(
            onTap: (url) {
              context.read<ItemCubit>().formChanged(url: url);
              Navigator.pop(context);
            },
          ), title: "Choose image", titleStyle: context.displaySmall);
        },
        icon: const Icon(Icons.camera_alt_outlined),
        label: Text("Add image"));

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item"),
      ),
      body: BlocConsumer<ItemCubit, ItemState>(
        builder: (context, state) {
          return state.status.builder({
            ItemStatus.loading: () => const Loader(),
            ItemStatus.error: () =>
                AppPlaceHolder.error(onTap: () => itemCubit.getItemVariants()),
            ItemStatus.populated: () => ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CachedImage(
                          w: double.infinity,
                          errorHolder: Container(
                              decoration: BoxDecoration(
                                borderRadius: 8.circle,
                                color: Colors.grey.shade300,
                              ),
                              child: imageChanger),
                          imageUrl: state.item.image,
                          decorated: true,
                          boxFit: BoxFit.cover,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.75)),
                          child: imageChanger,
                        )
                      ],
                    ),
                    16.height,
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            initialValue: state.item.name['ar'] ?? "",
                            label: "Name arabic",
                            onChanged: (v) => itemCubit.formChanged(ar: v),
                          ),
                        ),
                        8.width,
                        Expanded(
                          child: CustomTextField(
                            initialValue: state.item.name['en'] ?? "",
                            label: "Name english",
                            onChanged: (v) => itemCubit.formChanged(en: v),
                          ),
                        ),
                      ],
                    ),
                    8.height,
                    CustomTextField(
                      initialValue: state.item.price.toStringAsFixed(1),
                      label: "Price",
                      onChanged: (v) => itemCubit.formChanged(price: v),
                      textInputType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFomratters: [
                        InputFormaters.decimalNumber,
                      ],
                    ),
                    ExpansionTile(
                      leading: IconButton(
                          onPressed: () {
                            showAppSheet(context,
                                child: const _OptionPicker(),
                                title: "Add options",
                                titleStyle: context.headLineLarge);
                          },
                          icon: const Icon(Icons.add)),
                      title: Text("Options"),
                      children: List.generate(state.optionsMap.length, (index) {
                        final groups = state.optionsMap.values.toList()[index];
                        return GroupOptionWidget(
                          option: groups,
                          onTap: (group) => navigateTo(context,
                              routeName: Routes.addFoodOption,
                              doBefore: () => context
                                  .read<OptionCubit>()
                                  .optionGroupChanged(group)),
                        );
                      }),
                    ),
                    ExpansionTile(
                      leading: IconButton(
                          onPressed: () {
                            showAppSheet(context,
                                child: CategoryBuilder(onTap: (cat) {
                              context.read<ItemCubit>().categoryChanged(cat);
                              Navigator.pop(context);
                            }),
                                title: "Choose category",
                                titleStyle: context.displaySmall);
                          },
                          icon: const Icon(Icons.edit)),
                      title: Text("Category"),
                      children: [
                        Text(
                          state.category.name[context.lang],
                          style: context.titleLarge,
                        )
                      ],
                    ),
                    20.height,
                    state.status == ItemStatus.loading
                        ? const Loader()
                        : PrimaryButton(
                            onPress: state.readyToAdd
                                ? () => itemCubit.addItem()
                                : null,
                            label: "Save item",
                          )
                  ],
                ),
          });
        },
        listener: (context, state) {},
      ),
    );
  }
}

class _OptionPicker extends StatelessWidget {
  const _OptionPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemCubit, ItemState>(builder: (context, state) {
      return OptionsBuilder(
        onTap: (group) => context.read<ItemCubit>().pickupOption(group),
        selectable: true,
        selected: (group) => state.optionsMap.containsKey(group.id),
      );
    });
  }
}
