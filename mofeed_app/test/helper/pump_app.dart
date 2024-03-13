import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mofeduserpp/features/chat/cubit/chat_cubit.dart';
import 'package:mofeduserpp/features/notifications/cubit/notifications_cubit.dart';
import 'package:mofeduserpp/features/theme_changer/cubit/theme_changer_cubit.dart';
import 'package:mofeed_shared/cubit/internet_cubit.dart';
import 'package:mofeed_shared/localization/app_local.dart';
import 'package:mofeed_shared/ui/theme/theme.dart';
import 'cubit_initializer.dart';
import 'mock_test.dart';

class MockLocalizations extends Mock implements AppLocalizations {}

extension AppTester on WidgetTester {
  Future<void> pumpApp(
    Widget widgetUnderTest, {
    TargetPlatform? platform,
    ChatCubit? chatCubit,
    NotificationCubit? notificationCubit,
    ThemeMode? mode,
    ThemeChangerCubit? themeChangerCubit,
  }) async {
    await pumpWidget(
      MultiRepositoryProvider(
        providers: [],
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: chatCubit ?? MockChatCubit()),
            BlocProvider.value(value: MockNavCubit()),
            BlocProvider.value(
                value: notificationCubit ?? MockNotificationCubit()),
            BlocProvider.value(value: MockInterentCheckerCubit()),
            BlocProvider.value(value: MockInterentCheckerCubit()),
            BlocProvider.value(
                value: themeChangerCubit ?? MockThemeChangerCubit()),
          ],
          child: MaterialApp(
            themeMode: mode ?? ThemeMode.light,
            locale: const Locale("en"),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            title: 'mofeed',
            home: Theme(
              data: const AppTheme("en").themeData,
              child: Scaffold(body: widgetUnderTest),
            ),
          ),
        ),
      ),
    );
    await pump();
  }
}
