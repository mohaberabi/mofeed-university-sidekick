import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';

class RadioChoicer<T> extends StatelessWidget {
  final ValueChanged<T>? onChanged;
  final T value;
  final Widget? subtitle;
  final Widget title;
  final T? groupValue;
  final ShapeBorder? shape;
  final bool selected;
  final EdgeInsets? contentPadding;

  const RadioChoicer({
    Key? key,
    required this.onChanged,
    required this.value,
    required this.groupValue,
    required this.title,
    required this.selected,
    this.shape,
    this.contentPadding,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      contentPadding: contentPadding,
      dense: true,
      subtitle: subtitle,
      activeColor: AppColors.primColor,
      selected: selected,
      selectedTileColor: Colors.transparent,
      fillColor: const MaterialStatePropertyAll<Color>(AppColors.primColor),
      shape: RoundedRectangleBorder(
          borderRadius: 8.circle,
          side: BorderSide(
              color:
                  selected ? AppColors.primColor : Colors.grey.withOpacity(0.8),
              width: selected ? 2 : 0.75)),
      controlAffinity: ListTileControlAffinity.trailing,
      value: value,
      title: title,
      groupValue: groupValue,
      onChanged: onChanged != null ? (t) => onChanged!(t!) : null,
    );
  }
}
