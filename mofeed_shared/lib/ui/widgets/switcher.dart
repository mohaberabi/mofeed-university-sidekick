import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';

import '../colors/app_colors.dart';

class Switcher<T> extends StatelessWidget {
  final List<T> items;

  final void Function(T) onSwitch;

  final T current;
  final String Function(T) label;

  const Switcher({
    super.key,
    required this.items,
    required this.current,
    required this.onSwitch,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: items.map((item) {
        final selected = item == current;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: 4.circle,
                color: selected ? AppColors.primColor : Colors.transparent),
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () {
                onSwitch(item);
              },
              child: Text(label(item),
                  style: context.bodyLarge.copyWith(
                      fontWeight: selected ? FontWeight.bold : null,
                      color: selected ? Colors.white : null)),
            ),
          ),
        );
      }).toList(),
    );
  }
}
