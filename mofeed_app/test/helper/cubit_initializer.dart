import 'package:bloc_test/bloc_test.dart';

import 'package:flutter/material.dart';
import 'package:mofeduserpp/features/chat/cubit/chat_cubit.dart';
import 'package:mofeduserpp/features/chat/cubit/chat_states.dart';
import 'package:mofeduserpp/features/navigation/cubit/mofeed_nav_cubit.dart';
import 'package:mofeduserpp/features/notifications/cubit/notification_state.dart';
import 'package:mofeduserpp/features/notifications/cubit/notifications_cubit.dart';
import 'package:mofeduserpp/features/theme_changer/cubit/theme_changer_cubit.dart';
import 'package:mofeed_shared/cubit/internet_cubit.dart';
import 'package:mofeed_shared/cubit/navigation_cubit/navigation_cubit.dart';

class MockThemeChangerCubit extends MockBloc<ThemeChangerCubit, ThemeMode>
    implements ThemeChangerCubit {}

class MockChatCubit extends MockBloc<ChatCubit, ChatStates>
    implements ChatCubit {}

class MockInterentCheckerCubit extends MockBloc<InternetCubit, ConnectionStatus>
    implements InternetCubit {}

final class MockNavCubit extends MockBloc<NavigationCubit, NavState>
    implements NavigationCubit {}

class MockNotificationCubit
    extends MockBloc<NotificationCubit, NotificationState>
    implements NotificationCubit {}
