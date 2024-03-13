import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/app/views/onborading_screen.dart';
import 'package:mofeduserpp/core/widgets/gallery_viewer.dart';
import 'package:mofeduserpp/features/address/cubit/address_cubit.dart';
import 'package:mofeduserpp/features/address/screens/search_address_screen.dart';
import 'package:mofeduserpp/features/navigation/cubit/mofeed_nav_cubit.dart';
import 'package:mofeduserpp/features/profile/views/complete_profile.dart';
import 'package:mofeduserpp/features/profile/views/personal_info_screen.dart';
import 'package:mofeduserpp/features/chat/views/chat_screen.dart';
import 'package:mofeduserpp/features/chat/views/contacts_screen.dart';
import 'package:mofeduserpp/features/echo/screens/echo_reply_screen.dart';
import 'package:mofeduserpp/features/echo/screens/my_echos_screen.dart';
import 'package:mofeduserpp/features/favorite/screen/favorite_screen.dart';
import 'package:mofeduserpp/features/notifications/screens/notification_screen.dart';
import 'package:mofeduserpp/features/signup/cubit/signup_cubit.dart';
import 'package:mofeduserpp/features/university/cubit/university_cubit.dart';
import 'package:mofeduserpp/features/university/screens/university_info_screen.dart';
import 'package:mofeed_shared/model/echo_model.dart';
import 'package:mofeed_shared/utils/app_routes.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';
import '../../app/views/splash_screen.dart';
import '../../features/login/screen/login_screen.dart';
import '../../features/mofeed/views/home_screen.dart';
import '../../features/mofeed/views/settings_screen.dart';
import '../../features/navigation/widget/route_animation.dart';
import '../../features/profile/views/profile_screen.dart';
import '../../features/signup/screens/choose_university_screen.dart';
import '../../features/signup/screens/create_account_screen.dart';
import '../../features/signup/screens/email_sent_screen.dart';
import '../services/service_lcoator.dart';
import 'main_app_router.dart';

class AppRouter extends MainAppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    final name = settings.name!;
    for (var prefix in routesMap.keys) {
      if (name.startsWith(prefix)) {
        return routesMap[prefix]!.onGeneratedRoute(settings);
      }
    }
    return const ChooseUniversityScreen().toMaterialRoute;
  }

  @override
  Route onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.personalInfoScreen:
        return const PersonalInfoScreen().toMaterialRoute;
      case AppRoutes.completeProfile:
        return const CompleteProfileScreen().toMaterialRoute;
      case AppRoutes.echoRepliesScreen:
        final echo = settings.arguments as EchoModel;
        return EchoReplyScreen(echo: echo).toMaterialRoute;
      case AppRoutes.imageViewer:
        final images = settings.arguments as List<String>;
        return GalleryViewer(images: images).toMaterialRoute;
      case AppRoutes.chatScreen:
        final String recieverId = settings.arguments as String;
        return ChatScreen(recieverId: recieverId).toMaterialRoute;
      case AppRoutes.infoScreen:
        return const SettingsScreen().toMaterialRoute;
      case AppRoutes.favoritescreen:
        return const FavoriteScreen().toMaterialRoute;
      case AppRoutes.homeScreen:
        return const HomeScreen().toMaterialRoute;
      case AppRoutes.contactsScreen:
        return const ContactsScreen().toMaterialRoute;
      case AppRoutes.chooseUniversityScreen:
        return BlocProvider(
          create: (_) => sl<UniversityCubit>()..getAllUniversites(),
          child: const ChooseUniversityScreen(),
        ).toMaterialRoute;

      case AppRoutes.profileScreen:
        return AnimatedPageRoute(
            child: const AccountInfoScreen(), direction: AxisDirection.up);
      case AppRoutes.univeristyInfo:
        return BlocProvider(
          create: (_) => sl<UniversityCubit>()..getMyUni(),
          child: const UnivresityInfoScreen(),
        ).toMaterialRoute;
      case AppRoutes.splashScreen:
        return BlocProvider(
          create: (context) => sl<NavigationCubit>()..navigateOnStartUp(),
          child: const SplashScreen(),
        ).toMaterialRoute;

      case AppRoutes.createAccountScreen:
        return const CreateAccountScreen().toMaterialRoute;
      case AppRoutes.emailSentScreen:
        return const EmailSentScreen().toMaterialRoute;
      case AppRoutes.loginScreen:
        return const LoginScreen().toMaterialRoute;
      case AppRoutes.onBoarding:
        return const OnBoardingScreen().toMaterialRoute;
      case AppRoutes.echoScreen:
        return const MyEchosScreen().toMaterialRoute;
      case AppRoutes.searchPlacesScreen:
        return BlocProvider(
          create: (_) => sl<AddressCubit>(),
          child: const SearchAddressScreen(),
        ).toMaterialRoute;

      case AppRoutes.notificationScreen:
        return const NotificationScreen().toMaterialRoute;
      default:
        return undefinedRoute();
    }
  }
}
