import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/utils/extensions/num_extension.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';

class PaymentBuilder extends StatelessWidget {
  final double cartTotal;
  final double deliveryFees;
  final double taxes;
  final double discount;
  final double paymentAmount;
  final bool needsDelivery;
  final Color? color;

  const PaymentBuilder({
    Key? key,
    required this.discount,
    required this.paymentAmount,
    required this.deliveryFees,
    required this.cartTotal,
    required this.taxes,
    required this.needsDelivery,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = context.lang;
    final local = context.l10n;
    return Container(
      color: color ?? Colors.transparent,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Details',
            style: context.headLineLarge.copyWith(color: AppColors.primColor),
          ),
          _PaymentRow(
            label: 'Total',
            amount: cartTotal.toPrice(lang),
          ),
          if (deliveryFees > 0 && needsDelivery == true)
            _PaymentRow(
              label: "Faculty handover",
              amount: deliveryFees.toPrice(lang),
            ),
          if (needsDelivery && deliveryFees <= 0)
            _PaymentRow(
              label: 'Faculty handover',
              amount: deliveryFees.toPrice(lang),
            ),
          if (discount > 0)
            _PaymentRow(
              label: 'Discount',
              amount: discount.toPrice(lang),
            ),
          _PaymentRow(
            label: "Grand total",
            amount: paymentAmount.toPrice(lang),
          ),
        ],
      ),
    );
  }
}

class _PaymentRow extends StatelessWidget {
  final String label;

  final String amount;

  const _PaymentRow({Key? key, required this.label, required this.amount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = context.bodyLarge;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(amount, style: style),
        ],
      ),
    );
  }
}
