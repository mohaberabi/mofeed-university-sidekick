import 'package:flutter/material.dart';
import 'package:food_court/model/category_model.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel category;
  final void Function(CategoryModel)? onTap;

  const CategoryWidget({
    super.key,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      // trailing: const Icon(Icons.delete, color: Colors.red),
      horizontalTitleGap: 4,
      subtitleTextStyle: context.bodyLarge,
      titleTextStyle: context.bodyLarge,
      leadingAndTrailingTextStyle: context.titleLarge,
      leading: Text(category.order.toString()),
      onTap: () {
        if (onTap != null) {
          onTap!(category);
        }
      },
      title: Text(category.name['ar']),
      subtitle: Text(category.name['en']),
    );
  }
}
