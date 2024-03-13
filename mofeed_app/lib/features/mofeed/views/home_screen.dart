import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/core/widgets/mofeed_app_bar.dart';
import 'package:mofeduserpp/features/chat/cubit/chat_cubit.dart';
import 'package:mofeduserpp/features/chat/cubit/chat_states.dart';
import 'package:mofeduserpp/features/chat/views/contacts_screen.dart';
import 'package:mofeduserpp/features/favorite/cubit/favorite_cubit.dart';
import 'package:mofeduserpp/features/favorite/cubit/favorite_state.dart';
import 'package:mofeduserpp/features/food_court/views/food_court_screen.dart';
import 'package:mofeduserpp/features/mofeed/views/settings_screen.dart';
import 'package:mofeed_shared/constants/app_constants.dart';

import 'package:mofeed_shared/cubit/internet_cubit.dart';
import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/ui/icons/app_icons.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/utils/extensions/media_query_ext.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import '../../echo/widgets/echo_builder.dart';
import '../../sakan/widgets/sakan_builder.dart';
import '../cubit/mofeed_cubit.dart';
import '../cubit/mofeed_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = context.l10n;
    final internetState =
        context.select<InternetCubit, ConnectionStatus>((value) => value.state);
    return MultiBlocListener(
      listeners: [
        BlocListener<FavoriteCubit, FavoriteState>(
            listener: (context, state) {
              if (state.state.isLoading) {
                showLoader(context);
              } else if (state.state.isAddedRemovedFavorite) {
                Navigator.pop(context);
              } else if (state.state.isError) {
                context.showSnackBar(
                    doBefore: () => context.pop(),
                    message: local.localizeError(state.error));
              }
            },
            listenWhen: (prev, curr) => curr.state != prev.state),
      ],
      child: BlocBuilder<MofeedCubit, MofeedState>(builder: (context, state) {
        Color choosed(int index) =>
            state.index == index ? AppColors.primColor : Colors.grey;
        return Scaffold(
          appBar: MofeedAppbar(
            extraHeight: context.height * 0.03,
            index: state.index,
            isConnected: internetState == ConnectionStatus.connected,
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: context.read<MofeedCubit>().indexChanged,
            items: [
              BottomNavigationBarItem(
                  icon: AppIcon(AppIcons.group, color: choosed(0)),
                  label: local.echo),
              BottomNavigationBarItem(
                  icon: AppIcon(AppIcons.pizza, color: choosed(1)),
                  label: local.foodCourt),
              BottomNavigationBarItem(
                  icon: _ChatIcon(index: state.index), label: local.chats),
              BottomNavigationBarItem(
                  icon: AppIcon(AppIcons.room, color: choosed(3)),
                  label: local.sakan),
              BottomNavigationBarItem(
                  icon: AppIcon(AppIcons.more, color: choosed(4)),
                  label: local.more),
            ],
            currentIndex: state.index,
          ),
          body: screens[state.index],
        );
      }),
    );
  }
}

class _ChatIcon extends StatelessWidget {
  final int index;

  const _ChatIcon({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final color = index == 2 ? AppColors.primColor : Colors.grey;
    return BlocBuilder<ChatCubit, ChatStates>(builder: (context, state) {
      return Badge(
        smallSize: 14,
        largeSize: 16,
        isLabelVisible: index != 2 && state.hasUnread,
        alignment: Alignment.topLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: AppIcon(AppIcons.chat, color: color),
        ),
      );
    });
  }
}

const List<Widget> screens = [
  EchoBuilder(),
  FoodCourtScreen(),
  ContactsScreen(),
  SakanBuilder(),
  SettingsScreen()
];
