import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/cart/cubit/cart_cubit.dart';
import 'package:mofeduserpp/features/chat/cubit/chat_cubit.dart';
import 'package:mofeduserpp/features/echo/cubit/echo_cubit.dart';
import 'package:mofeduserpp/features/favorite/cubit/favorite_cubit.dart';
import 'package:mofeduserpp/features/login/cubit/login_cubit.dart';
import 'package:mofeduserpp/features/notifications/cubit/notifications_cubit.dart';
import 'package:mofeduserpp/features/profile/cubit/profile_cubit.dart';
import 'package:mofeduserpp/features/sakan/cubit/sakan_cubit/sakan_cubit.dart';
import 'package:mofeduserpp/features/signup/cubit/signup_cubit.dart';
import 'package:mofeduserpp/features/theme_changer/cubit/theme_changer_cubit.dart';
import 'package:mofeed_shared/cubit/internet_cubit.dart';
import 'package:mofeed_shared/cubit/localization_cubit/local_cubit.dart';

import '../../core/services/service_lcoator.dart';

import '../../features/mofeed/cubit/mofeed_cubit.dart';
import '../../features/sakan_builder/cubit/sakan_builder_cubit.dart';

class AppBlocProviders extends StatelessWidget {
  final Widget child;

  const AppBlocProviders({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => sl<ThemeChangerCubit>()..getFavoriteTheme()),
        BlocProvider(create: (_) => sl<NotificationCubit>()..getAndSaveToken()),
        BlocProvider(
            create: (_) => sl<FavoriteCubit>()..getFavoriteData(), lazy: false),
        BlocProvider(create: (_) => sl<ProfileCubit>()),
        BlocProvider(create: (_) => sl<SakanCubit>()),
        BlocProvider(create: (_) => sl<EchoCubit>()),
        BlocProvider(create: (_) => sl<LoginCubit>()),
        BlocProvider(create: (_) => sl<SignUpCubit>()),
        BlocProvider(
            create: (_) => sl<SakanBuilderCubit>()..getLastCheckpoint(),
            lazy: false),
        BlocProvider(create: (_) => sl<MofeedCubit>()),
        BlocProvider(create: (_) => sl<CartCubit>()..init(), lazy: false),
        BlocProvider(create: (_) => sl<ChatCubit>(), lazy: false),
        BlocProvider(create: (_) => sl<MofeedCubit>()),
        BlocProvider(
            create: (_) => sl<InternetCubit>()..onConnectivityChanged(),
            lazy: false),
        BlocProvider(
            lazy: false,
            create: (_) => sl<LocalizationCubit>()..getSavedLanguage()),
      ],
      child: child,
    );
  }
}
