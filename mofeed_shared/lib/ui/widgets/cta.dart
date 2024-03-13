import 'package:flutter/material.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

import '../spacing/spacing.dart';

class CallToAction extends StatelessWidget {
  final String _title;
  final VoidCallback? _action;
  final Widget? _leading;
  final Widget? _trailing;
  final bool _isSimple;
  final Key? _key;

  const CallToAction._({
    Key? key,
    required String title,
    VoidCallback? action,
    Widget? leading,
    Widget? trailing,
    bool isSimple = true,
  })  : _title = title,
        _action = action,
        _isSimple = isSimple,
        _leading = leading,
        _key = key,
        _trailing = trailing;

  CallToAction.simple({
    required String title,
    required IconData icon,
    VoidCallback? action,
    Key? key,
  }) : this._(
            title: title,
            leading: Icon(icon),
            action: action,
            isSimple: true,
            key: key);

  const CallToAction.custom({
    required String title,
    required Widget leading,
    VoidCallback? action,
    Widget? trailing,
    Key? key,
  }) : this._(
          key: key,
          title: title,
          leading: leading,
          isSimple: false,
          trailing: trailing,
          action: action,
        );

  EdgeInsets get _padding =>
      const EdgeInsets.symmetric(horizontal: 20, vertical: 8);

  @override
  Widget build(BuildContext context) {
    if (_isSimple) {
      return ListTile(
        iconColor: context.theme.iconTheme.color,
        splashColor: Colors.grey,
        enabled: true,
        contentPadding: _padding,
        horizontalTitleGap: 0,
        onTap: _action,
        leading: _leading,
        trailing: _trailing ??
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
        title: Text(_title),
        titleTextStyle: context.bodyMedium,
      );
    }

    return InkWell(
      onTap: _action,
      child: Padding(
        padding: _padding,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _leading ?? const SizedBox(),
              const SizedBox(width: AppSpacing.sm),
              Text(_title, style: context.bodyMedium),
              const Spacer(),
              _trailing ??
                  const Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.grey)
            ],
          ),
        ),
      ),
    );
  }
}
