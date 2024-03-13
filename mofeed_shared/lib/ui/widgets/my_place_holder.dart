import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/icons/app_icons.dart';
import 'package:mofeed_shared/ui/icons/assets_manager.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/ui/widgets/primary_button.dart';

class AppPlaceHolder extends StatelessWidget {
  final String _title;
  final TextStyle? _titleStyle;

  final TextStyle? _subtitleStyle;

  final Color? _subTitleColor;

  final Color? _titleColor;

  final String _subTitle;
  final double _size;
  final Widget _placer;

  final Widget? _cta;

  final VoidCallback? _onTap;

  const AppPlaceHolder._({
    super.key,
    required String title,
    required String subTitle,
    double size = 175,
    required Widget placer,
    VoidCallback? onTap,
    Widget? cta,
    Color? titleColor,
    Color? subtitleColor,
    TextStyle? titleStyle,
    TextStyle? subTitleStyle,
  })  : _title = title,
        _titleStyle = titleStyle,
        _subtitleStyle = subTitleStyle,
        _titleColor = titleColor,
        _subTitleColor = subtitleColor,
        _placer = placer,
        _onTap = onTap,
        _cta = cta,
        _size = size,
        _subTitle = subTitle;

  AppPlaceHolder.empty(
      {Key? key,
      String title = "Nothing found try again later ",
      String subtitle = '',
      double size = 200})
      : this._(
          placer: AppIcon(
            AssetManager.desertPath,
            size: size,
            custom: true,
          ),
          key: key,
          title: title,
          subTitle: subtitle,
        );

  AppPlaceHolder.error({
    Key? key,
    String title = "Something went wrong...",
    String subtitle = 'Please Try Again',
    double size = 200,
    Widget? cta,
    required VoidCallback onTap,
    Color buttonColor = Colors.red,
    String buttonLabel = "Try again",
  }) : this._(
          titleColor: buttonColor,
          subtitleColor: buttonColor,
          cta: cta ??
              PrimaryButton(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  onPress: onTap,
                  label: buttonLabel,
                  color: buttonColor),
          placer: AppIcon(
            AssetManager.error,
            size: size,
            color: Colors.red,
          ),
          key: key,
          title: title,
          subTitle: subtitle,
        );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _placer,
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _title,
              textAlign: TextAlign.center,
              style: _titleStyle ??
                  context.headlineMedium.copyWith(
                    color: _titleColor,
                  ),
            ),
          ),
          Text(_subTitle,
              textAlign: TextAlign.center,
              style: _subtitleStyle ??
                  context.bodyLarge.copyWith(color: _subTitleColor)),
          if (_cta != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _cta!,
            ),
        ],
      ),
    );
  }
}
