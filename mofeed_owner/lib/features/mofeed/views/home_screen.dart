import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeed_owner/features/mofeed/cubit/mofeed_cubit.dart';
import 'package:mofeed_owner/features/mofeed/cubit/mofeed_state.dart';
import 'package:mofeed_shared/constants/app_icons.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';

import '../../order/views/active_orders.dart';
import 'more_screen.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MofeedCubit, MofeedState>(builder: (context, state) {
      return Scaffold(
        body: subScreens[state.index],
        appBar: AppBar(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: state.index,
          onTap: (index) => context.read<MofeedCubit>().indexChanged(index),
          items: const [
            BottomNavigationBarItem(
                icon: AppIcon(AppIcons.recipt), label: "Orders"),
            BottomNavigationBarItem(
                icon: AppIcon(AppIcons.more), label: "More"),
          ],
        ),
      );
    });
  }
}

const List<Widget> subScreens = [
  ActiveOrders(),
  MoreScreen(),
];
