import 'package:flutter/cupertino.dart';
import 'package:mofeduserpp/features/checkout/screens/checkout_screen.dart';
import 'package:mofeduserpp/features/checkout/widgets/checkout_recaper.dart';
import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';

import '../../../core/widgets/choicer.dart';

class OrderMethoder extends StatelessWidget {
  final OrderMethod currentMethod;
  final bool isEnabled;

  final void Function(OrderMethod) onChanged;

  const OrderMethoder({
    super.key,
    required this.currentMethod,
    required this.onChanged,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return CheckoutRecaper(
        title: context.l10n.howToPickup,
        child: Column(
          children: [
            ...OrderMethod.values.map((e) {
              final choosed = e == currentMethod;
              return Opacity(
                opacity: (isEnabled || e == OrderMethod.pickup) ? 1 : 0.33,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: RadioChoicer<OrderMethod>(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    onChanged: (isEnabled || e == OrderMethod.pickup)
                        ? onChanged
                        : null,
                    value: e,
                    groupValue: currentMethod,
                    title: Text(
                      e.tr(context.lang),
                      style: context.titleLarge.copyWith(
                          color: choosed ? AppColors.primColor : null,
                          fontWeight: choosed ? FontWeight.w900 : null),
                    ),
                    selected: choosed,
                  ),
                ),
              );
            }).toList(),
          ],
        ));
  }
}
