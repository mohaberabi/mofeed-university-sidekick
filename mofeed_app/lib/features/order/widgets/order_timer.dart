import 'package:flutter/material.dart';
import 'package:mofeduserpp/core/widgets/custom_time_picker.dart';
import 'package:mofeduserpp/features/checkout/widgets/checkout_recaper.dart';
import 'package:mofeed_shared/ui/icons/app_icons.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/utils/extensions/date_time_extension.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

class OrderTimer extends StatelessWidget {
  final DateTime? choosedTime;
  final void Function(DateTime?)? onTimeChoosed;

  const OrderTimer({
    super.key,
    this.choosedTime,
    this.onTimeChoosed,
  });

  @override
  Widget build(BuildContext context) {
    return CheckoutRecaper(
      title: context.l10n.whenWantOrder,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            trailing: TextButton(
                child: Text(context.l10n.choose),
                onPressed: () async {
                  final picked = await _showTimePicker(context);
                  if (onTimeChoosed != null) {
                    onTimeChoosed!(picked);
                  }
                }),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            shape: context.theme.primaryOutlineBorder,
            leading: const AppIcon(AppIcons.clock),
            horizontalTitleGap: 0,
            title: Text(choosedTime == null
                ? context.l10n.chooseTime
                : choosedTime!.amPM),
          ),
        ],
      ),
    );
  }

  Future<DateTime?> _showTimePicker(
    BuildContext context,
  ) async {
    final pickedTime = await showDialog<DateTime>(
        context: context,
        builder: (context) {
          return const SimpleDialog(
            children: [
              CustomTimePicker(),
            ],
          );
        });

    return pickedTime;
  }
}
