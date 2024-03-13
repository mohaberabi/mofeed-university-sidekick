import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';

class CustomTextField extends StatelessWidget {
  final String? hint;
  final bool filled;

  final InputBorder? border;
  final bool isReadOnly;
  final GestureTapCallback? onTap;
  final String? label;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType textInputType;
  final bool isPassword;
  final List<TextInputFormatter>? inputFomratters;
  final Widget? prefix;
  final Function? obsecureFunc;
  final String obsecureText;
  final ValueChanged<String>? onChanged;
  final Widget? suffix;
  final FocusNode? foucs;
  final bool? autoFoucs;
  final String? initialValue;
  final bool isOutlined;
  final double? height;
  final bool collapsed;
  final ValueChanged<String>? onSubmit;
  final Color color;
  final FloatingLabelBehavior floatingBehavior;
  final String? errorText;
  final EdgeInsets padding;
  final int? maxLength;
  final int? maxLines;
  final TextStyle? contentStyle;
  final TextStyle? labelStyle;
  final List<String>? autofills;
  final Color? curserColor;
  final TextInputAction? action;
  final VoidCallback? onEditComplete;
  final Widget? hintWidget;
  final EdgeInsets? fieldPadding;
  final bool alignHintWithLabel;
  final Color? contentColor;
  final TextStyle? hintStyle;
  final bool isColumed;
  final TextDirection? fieldDirection;
  final InputBorder? focusedBorder;

  const CustomTextField({
    Key? key,
    this.collapsed = false,
    this.isColumed = true,
    this.fieldDirection,
    this.focusedBorder,
    this.height,
    this.filled = true,
    this.fieldPadding,
    this.maxLength,
    this.hintStyle,
    this.alignHintWithLabel = true,
    this.curserColor,
    this.labelStyle,
    this.autofills,
    this.contentStyle,
    this.contentColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.floatingBehavior = FloatingLabelBehavior.auto,
    this.color = Colors.white,
    this.onSubmit,
    this.obsecureText = '',
    this.maxLines,
    this.errorText,
    this.isOutlined = true,
    this.initialValue,
    this.onChanged,
    this.foucs,
    this.obsecureFunc,
    this.suffix,
    this.autoFoucs,
    this.prefix,
    this.hintWidget,
    this.inputFomratters,
    this.isPassword = false,
    this.textInputType = TextInputType.text,
    this.validator,
    this.controller,
    this.label,
    this.isReadOnly = false,
    this.border,
    this.hint,
    this.onEditComplete,
    this.action,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: fieldPadding ?? EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isColumed)
            Text(label ?? "", style: labelStyle ?? context.bodyMedium),
          if (isColumed) const SizedBox(height: 8),
          Directionality(
            textDirection: fieldDirection ?? _defaultTextDir(context.lang),
            child: TextFormField(
                showCursor: !isReadOnly,
                textInputAction: action,
                onEditingComplete: onEditComplete,
                autofillHints: autofills,
                cursorColor: curserColor ?? AppColors.primColor,
                maxLength: maxLength,
                maxLines: maxLines,
                onFieldSubmitted: onSubmit,
                initialValue: initialValue,
                autofocus: autoFoucs ?? false,
                focusNode: foucs,
                onChanged: onChanged,
                cursorHeight: 20,
                onTap: onTap,
                readOnly: isReadOnly,
                keyboardType: textInputType,
                inputFormatters: inputFomratters,
                obscureText: isPassword,
                style: contentStyle ??
                    context.bodyLarge
                        .copyWith(color: contentColor, fontSize: 16),
                decoration: InputDecoration(
                  isDense: collapsed,
                  isCollapsed: collapsed,
                  errorText: errorText,
                  focusedErrorBorder: _primaryBorder.copyWith(
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                  ),
                  errorBorder: _errorBorder,
                  contentPadding: padding,
                  hintText: hint,
                  enabledBorder: border ??
                      _primaryBorder.copyWith(
                          borderSide: const BorderSide(color: Colors.grey)),
                  prefixIcon: prefix,
                  suffixIcon: suffix,
                  labelText: isColumed ? null : label,
                  suffix: InkWell(
                    onTap: () {
                      obsecureFunc!();
                    },
                    child: Text(obsecureText),
                  ),
                  floatingLabelBehavior: floatingBehavior,
                  floatingLabelStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  labelStyle: labelStyle ??
                      context.bodyLarge.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                  alignLabelWithHint: alignHintWithLabel,
                  focusedBorder: focusedBorder ?? _primaryBorder,
                  fillColor: isReadOnly ? Colors.grey.withOpacity(0.45) : color,
                  filled: filled,
                  hintStyle: hintStyle ??
                      context.bodyMedium.copyWith(color: Colors.grey),
                ),
                validator: validator,
                controller: controller),
          ),
        ],
      ),
    );
  }

  InputBorder get _primaryBorder {
    return isOutlined == false
        ? const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primColor, width: 0.7))
        : OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppColors.primColor, width: 1.5),
            borderRadius: 4.circle);
  }

  InputBorder get _errorBorder {
    return isOutlined == false
        ? UnderlineInputBorder(
            borderSide:
                BorderSide(color: Colors.red.withOpacity(0.9), width: 0.5),
          )
        : OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.withOpacity(0.9)),
            borderRadius: 4.circle);
  }

  CustomTextField copyWith({
    String? hint,
    InputBorder? border,
    bool? isColumed,
    bool? isReadOnly,
    GestureTapCallback? onTap,
    String? label,
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
    TextInputType? textInputType,
    bool? isPassword,
    List<TextInputFormatter>? inputFomratters,
    Widget? prefix,
    bool? filled,
    Function? obsecureFunc,
    String? obsecureText,
    ValueChanged<String>? onChanged,
    Widget? suffix,
    FocusNode? foucs,
    bool? autoFoucs,
    bool? isUnderLine,
    String? initialValue,
    bool? isOutlined,
    double? height,
    bool? collapsed,
    ValueChanged<String>? onSubmit,
    Color? color,
    FloatingLabelBehavior? floatingBehavior,
    String? errorText,
    EdgeInsets? padding,
    int? maxLength,
    int? maxLines,
    TextStyle? contentStyle,
    TextStyle? labelStyle,
    List<String>? autofills,
    Color? curserColor,
    TextInputAction? action,
    VoidCallback? onEditComplete,
    Widget? hintWidget,
    EdgeInsets? fieldPadding,
    bool? alignHintWithLabel,
    Color? contentColor,
    TextStyle? hintStyle,
  }) {
    return CustomTextField(
      filled: filled ?? this.filled,
      isColumed: isColumed ?? this.isColumed,
      hint: hint ?? this.hint,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      onTap: onTap ?? this.onTap,
      label: label ?? this.label,
      controller: controller ?? this.controller,
      validator: validator ?? this.validator,
      textInputType: textInputType ?? this.textInputType,
      isPassword: isPassword ?? this.isPassword,
      inputFomratters: inputFomratters ?? this.inputFomratters,
      prefix: prefix ?? this.prefix,
      obsecureFunc: obsecureFunc ?? this.obsecureFunc,
      obsecureText: obsecureText ?? this.obsecureText,
      onChanged: onChanged ?? this.onChanged,
      suffix: suffix ?? this.suffix,
      foucs: foucs ?? this.foucs,
      autoFoucs: autoFoucs ?? this.autoFoucs,
      initialValue: initialValue ?? this.initialValue,
      isOutlined: isOutlined ?? this.isOutlined,
      height: height ?? this.height,
      collapsed: collapsed ?? this.collapsed,
      onSubmit: onSubmit ?? this.onSubmit,
      color: color ?? this.color,
      floatingBehavior: floatingBehavior ?? this.floatingBehavior,
      errorText: errorText ?? this.errorText,
      padding: padding ?? this.padding,
      maxLength: maxLength ?? this.maxLength,
      maxLines: maxLines ?? this.maxLines,
      contentStyle: contentStyle ?? this.contentStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      autofills: autofills ?? this.autofills,
      curserColor: curserColor ?? this.curserColor,
      action: action ?? this.action,
      onEditComplete: onEditComplete ?? this.onEditComplete,
      hintWidget: hintWidget ?? this.hintWidget,
      fieldPadding: fieldPadding ?? this.fieldPadding,
      alignHintWithLabel: alignHintWithLabel ?? this.alignHintWithLabel,
      contentColor: contentColor ?? this.contentColor,
      hintStyle: hintStyle ?? this.hintStyle,
    );
  }

  TextDirection _defaultTextDir(String? lang) {
    if (lang == null) {
      return TextDirection.ltr;
    } else {
      if (lang == 'ar') {
        return TextDirection.rtl;
      } else {
        return TextDirection.ltr;
      }
    }
  }
}
