import 'package:flutter/material.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';

import '../colors/app_colors.dart';
import '../spacing/spacing.dart';

class PrimaryButton extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onPress;

  final String? label;
  final Color color;
  final Color labelColor;

  const PrimaryButton({
    Key? key,
    this.child,
    this.label,
    required this.onPress,
    this.color = AppColors.primColor,
    this.labelColor = Colors.white,
    Color? disabledButtonColor,
    Color? foregroundColor,
    Color? disabledForegroundColor,
    BorderSide? borderSide,
    double? elevation,
    TextStyle? textStyle,
    Size? maximumSize,
    Size? minimumSize,
    EdgeInsets? padding,
    OutlinedBorder? shape,
  })  : assert(child == null || label == null),
        _disabledButtonColor = disabledButtonColor ?? AppColors.disabledButton,
        _borderSide = borderSide,
        _foregroundColor = foregroundColor ?? Colors.black,
        _disabledForegroundColor =
            disabledForegroundColor ?? AppColors.disabledButton,
        _elevation = elevation ?? 0,
        _textStyle = textStyle,
        _maximumSize = maximumSize ?? _defaultMaximumSize,
        _minimumSize = minimumSize ?? _defaultMinimumSize,
        _padding = padding ?? _defaultPadding,
        _shape = shape,
        super(key: key);

  const PrimaryButton.rounded({
    VoidCallback? onPress,
    Widget? child,
    String? label,
    Size? minSize,
    Size? maxSize,
  }) : this(
          child: child,
          disabledForegroundColor: AppColors.disabledButton,
          disabledButtonColor: Colors.transparent,
          label: label,
          labelColor: AppColors.primColor,
          color: Colors.transparent,
          onPress: onPress,
          minimumSize: minSize ?? _defaultMinimumSize,
          maximumSize: maxSize ?? _defaultMaximumSize,
          borderSide: const BorderSide(color: AppColors.primColor),
        );

  const PrimaryButton.roundedAlert({
    VoidCallback? onPress,
    Widget? child,
    String? label,
  }) : this(
          child: child,
          disabledForegroundColor: AppColors.disabledButton,
          disabledButtonColor: Colors.transparent,
          label: label,
          labelColor: Colors.red,
          color: Colors.transparent,
          onPress: onPress,
          borderSide: const BorderSide(color: Colors.red),
        );

  const PrimaryButton.circle({
    Key? key,
    VoidCallback? onPress,
    Widget? child,
    String? label,
  }) : this(
            key: key,
            child: child,
            disabledForegroundColor: AppColors.disabledButton,
            disabledButtonColor: AppColors.disabledButton,
            label: label,
            labelColor: Colors.white,
            color: AppColors.primColor,
            onPress: onPress,
            shape: const CircleBorder());

  const PrimaryButton.circleRounded({
    Key? key,
    VoidCallback? onPress,
    Widget? child,
    String? label,
  }) : this(
            minimumSize: const Size(45, 45),
            maximumSize: const Size(45, 45),
            key: key,
            child: child,
            disabledForegroundColor: AppColors.disabledButton,
            disabledButtonColor: AppColors.disabledButton,
            label: label,
            labelColor: AppColors.primColor,
            color: Colors.transparent,
            onPress: onPress,
            shape: const CircleBorder(
                side: BorderSide(color: AppColors.primColor, width: 2)));

  @override
  Widget build(BuildContext context) {
    final btnChild = child ??
        Text(label!,
            style: context.button.copyWith(
                fontSize: child != null ? null : 16, color: labelColor));
    return ElevatedButton(
      onPressed: onPress,
      style: ButtonStyle(
        maximumSize: MaterialStateProperty.all(_maximumSize),
        padding: MaterialStateProperty.all(_padding),
        minimumSize: MaterialStateProperty.all(_minimumSize),
        textStyle: MaterialStateProperty.all(context.button),
        backgroundColor: onPress == null
            ? MaterialStateProperty.all(_disabledButtonColor)
            : MaterialStateProperty.all(color),
        elevation: MaterialStateProperty.all(_elevation),
        foregroundColor: onPress == null
            ? MaterialStateProperty.all(_disabledForegroundColor)
            : MaterialStateProperty.all(_foregroundColor),
        side: MaterialStateProperty.all(_borderSide),
        shape: MaterialStateProperty.all(_shape ?? defaultShape),
      ),
      child: btnChild,
    );
  }

  static const _defaultMaximumSize = Size(double.infinity, 45);

  static const _defaultMinimumSize = Size(double.infinity, 45);

  static const _defaultPadding =
      EdgeInsets.symmetric(vertical: AppSpacing.sm, horizontal: 12);

  final Color? _disabledButtonColor;

  final Color _foregroundColor;

  final Color _disabledForegroundColor;

  final BorderSide? _borderSide;

  final double _elevation;

  final TextStyle? _textStyle;

  final Size _maximumSize;

  final Size _minimumSize;

  final EdgeInsets _padding;
  final OutlinedBorder? _shape;

  static const defaultShape = StadiumBorder();
}
