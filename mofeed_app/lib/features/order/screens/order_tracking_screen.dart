import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/order/cubit/order_cubit/order_cubit.dart';
import 'package:mofeduserpp/features/order/widgets/order_tracking_widget.dart';
import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/ui/theme/theme_ext.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

class OrderTrackingScreen extends StatelessWidget {
  final String orderID;

  const OrderTrackingScreen({
    super.key,
    required this.orderID,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      backgroundColor:
          theme.isDark ? AppColors.lightDark : AppColors.primMaterial.shade50,
      body: OrderTrackingWidget(orderId: orderID),
    );
  }
}
