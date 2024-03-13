import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeed_owner/features/item/cubit/item_cubit.dart';
import 'package:mofeed_owner/features/item/cubit/item_state.dart';
import 'package:mofeed_owner/shared/router/app_routes.dart';
import 'package:mofeed_shared/utils/const_methods.dart';
import 'package:mofeed_shared/utils/extensions/num_extension.dart';
import 'package:mofeed_shared/utils/extensions/status_builder.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';
import 'package:mofeed_shared/widgets/app_view_builder.dart';
import 'package:mofeed_shared/widgets/cached_image.dart';
import 'package:mofeed_shared/widgets/loader.dart';
import 'package:mofeed_shared/widgets/my_place_holder.dart';

import '../../../shared/sl/service_locator.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  late ItemCubit itemCubit;

  @override
  void initState() {
    itemCubit = sl<ItemCubit>()..getItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                navigateTo(context, routeName: Routes.addItemScreen);
              },
              icon: Icon(Icons.add))
        ],
        title: Text("Items"),
      ),
      body: BlocBuilder<ItemCubit, ItemState>(builder: (context, state) {
        final view = AppViewBuilder.list(
            onRefresh: () async => itemCubit.getItems(),
            builder: (context, index) {
              final item = state.items[index];
              return Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () => navigateTo(context,
                      routeName: Routes.addItemScreen,
                      doBefore: () => itemCubit.itemChanged(item)),
                  child: Row(
                    children: [
                      CachedImage(
                          imageUrl: item.image,
                          decorated: true,
                          w: 75,
                          h: 75,
                          radius: 8,
                          boxFit: BoxFit.cover),
                      8.width,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name[context.lang],
                            style: context.bodyLarge,
                          ),
                          Text(
                            item.price.toPrice(context.lang),
                            style: context.bodyLarge,
                          ),
                        ],
                      ),
                      Expanded(
                        child: SwitchListTile.adaptive(
                            value: item.inStock,
                            onChanged: (v) => itemCubit.addItem(
                                item: item.copyWith(inStock: v))),
                      ),
                    ],
                  ),
                ),
              );
            },
            count: state.items.length,
            placeHolder: AppPlaceHolder.empty(
              title: "No items added yet ",
              subtitle: "Start adding items to accpet orders now ",
            ));
        return state.status.builder({
          ItemStatus.loading: () => const Loader(),
          ItemStatus.error: () => AppPlaceHolder.error(onTap: () {}),
          ItemStatus.populated: () => view
        }, placeHolder: view);
      }),
    );
  }
}
