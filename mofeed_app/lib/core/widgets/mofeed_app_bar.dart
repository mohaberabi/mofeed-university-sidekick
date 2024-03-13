import 'package:flutter/material.dart';
import 'package:mofeduserpp/core/widgets/no_network_widget.dart';
import 'package:mofeduserpp/features/address/repository/adddress_repository.dart';
import 'package:mofeduserpp/features/cart/views/cart_screen.dart';
import 'package:mofeduserpp/features/echo/widgets/echo_widget.dart';

import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';

import '../../features/sakan/widgets/sakan_builder.dart';
import '../services/service_lcoator.dart';

class MofeedAppbar extends StatelessWidget implements PreferredSizeWidget {
  final int index;
  final bool isConnected;
  final double extraHeight;

  const MofeedAppbar({
    super.key,
    required this.index,
    this.extraHeight = 75,
    required this.isConnected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!isConnected) const NoNetWorkWidget(),
        Container(
          margin: EdgeInsets.only(top: isConnected ? 0 : 22),
          child: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: false,
            title: Text(title(context), style: context.displayMedium),
            actions: [
              _Action(index: index),
            ],
          ),
        ),
      ],
    );
  }

  String title(BuildContext context) {
    final l10n = context.l10n;
    switch (index) {
      case 0:
        return l10n.echo;
      case 1:
        return l10n.foodCourt;
      case 2:
        return l10n.chats;
      case 3:
        return l10n.sakan;
      default:
        return l10n.more;
    }
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (isConnected ? 0 : extraHeight));
}

class _Action extends StatelessWidget {
  final int index;

  const _Action({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return EchoWidget.add;
      case 1:
        return CartScreen.cart;
      case 3:
        return SakanBuilder.add;
      default:
        return const SizedBox();
    }
  }
}
