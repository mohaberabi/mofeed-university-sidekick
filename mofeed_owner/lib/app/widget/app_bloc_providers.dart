import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeed_owner/features/category/cubit/category_cubit.dart';
import 'package:mofeed_owner/features/gallery/cubit/gallery_cubit.dart';
import 'package:mofeed_owner/features/item/cubit/item_cubit.dart';
import 'package:mofeed_owner/features/mofeed/cubit/mofeed_cubit.dart';
import 'package:mofeed_owner/features/navigation/cubit/navigation_cubit.dart';
import 'package:mofeed_owner/features/notifications/cubit/notifications_cubit.dart';
import 'package:mofeed_owner/features/option/cubit/option_cubit.dart';
import 'package:mofeed_owner/features/order/cubit/order_cubit.dart';
import 'package:mofeed_owner/features/rating/cubit/rating_cubit.dart';
import 'package:mofeed_owner/features/restraurant/cubit/restarant_cubit.dart';
import 'package:mofeed_shared/cubit/localization_cubit/local_cubit.dart';

import '../../features/auth/cubit/auth_cubit.dart';
import '../../shared/sl/service_locator.dart';

class AppBlocProviders extends StatelessWidget {
  final Widget child;

  const AppBlocProviders({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => sl<NotificationCubit>()
          ..getAndSaveToken()
          ..onForegroundMessageRecieved()
          ..onMessageOpenedApp(),
        lazy: false,
      ),
      BlocProvider(create: (_) => sl<OrderCubit>()),
      BlocProvider(create: (_) => sl<OptionCubit>()),
      BlocProvider(create: (_) => sl<ItemCubit>()),
      BlocProvider(create: (_) => sl<RatingCubit>()),
      BlocProvider(create: (_) => sl<CategoryCubit>()),
      BlocProvider(create: (_) => sl<RestarantCubit>()),
      BlocProvider(create: (_) => sl<GalleryCubit>()),
      BlocProvider(create: (_) => sl<AcceptNavCubit>()),
      BlocProvider(create: (_) => sl<MofeedCubit>()),
      BlocProvider(create: (_) => sl<AuthCubit>()),
      BlocProvider(create: (_) => sl<LocalizationCubit>()..getSavedLanguage()),
    ], child: child);
  }
}
