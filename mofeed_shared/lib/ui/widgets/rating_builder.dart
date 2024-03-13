import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class RatingBuilder extends StatelessWidget {
  final void Function(int)? onTap;
  final int length;
  final int value;
  final double size;
  final bool expand;

  const RatingBuilder({
    super.key,
    this.length = 5,
    required this.value,
    this.onTap,
    this.size = 50,
    this.expand = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(length, (index) {
        if (expand) {
          return Expanded(child: _star(index));
        } else {
          return _star(index);
        }
      }),
    );
  }

  Widget _star(int index) => GestureDetector(
        onTap: onTap != null
            ? () {
                onTap!(index);
              }
            : null,
        child: Icon(
          value >= index ? Icons.star : Icons.star_border_outlined,
          size: size,
          color: value >= index ? AppColors.primColor : Colors.grey,
        ),
      );
}
