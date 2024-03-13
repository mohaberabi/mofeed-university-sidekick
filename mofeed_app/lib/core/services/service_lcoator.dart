import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mofeduserpp/core/services/di/address_di.dart';
import 'package:mofeduserpp/core/services/di/auth_di.dart';
import 'package:mofeduserpp/core/services/di/cart_di.dart';
import 'package:mofeduserpp/core/services/di/echo_di.dart';
import 'package:mofeduserpp/core/services/di/foodcourt_di.dart';
import 'package:mofeduserpp/core/services/di/mofeed_di.dart';
import 'package:mofeduserpp/core/services/di/sakan_di.dart';
import 'package:mofeduserpp/core/services/di/university_di.dart';
import 'package:mofeduserpp/features/favorite/cubit/favorite_cubit.dart';
import 'package:mofeduserpp/features/favorite/data/favorite_repository.dart';
import 'package:mofeduserpp/features/favorite/data/favorite_storage.dart';
import 'package:mofeduserpp/features/localization/data/user_localization_repository.dart';
import 'package:mofeduserpp/features/navigation/cubit/mofeed_nav_cubit.dart';
import 'package:mofeduserpp/features/notifications/cubit/notifications_cubit.dart';
import 'package:mofeduserpp/features/notifications/data/notification_storage.dart';
import 'package:mofeduserpp/features/theme_changer/cubit/theme_changer_cubit.dart';
import 'package:mofeed_shared/clients/api/dio_client.dart';
import 'package:mofeed_shared/clients/api/dio_interceptors.dart';

import 'package:mofeed_shared/clients/favorite_client/favorite_client.dart';
import 'package:mofeed_shared/clients/favorite_client/firebase_favorite_client.dart';
import 'package:mofeed_shared/clients/image_picker_client/image_picker_client.dart';
import 'package:mofeed_shared/clients/local_notification_client/flutter_local_notifications_client.dart';
import 'package:mofeed_shared/clients/local_notification_client/local_notifications_client.dart';
import 'package:mofeed_shared/clients/notification_client/fcm_notification_client.dart';
import 'package:mofeed_shared/clients/notification_client/notification_client.dart';
import 'package:mofeed_shared/constants/fcm_const.dart';
import 'package:mofeed_shared/cubit/internet_cubit.dart';
import 'package:mofeed_shared/cubit/localization_cubit/local_cubit.dart';
import 'package:mofeed_shared/data/network_info.dart';
import 'package:mofeed_shared/data/storage_repository.dart';
import 'package:mofeed_shared/helper/shared_pref_sorage.dart';
import 'package:mofeed_shared/helper/storage_client.dart';
import 'package:mofeed_shared/localization/data/localization_repository.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../app/data/app_storage.dart';
import '../../features/notifications/data/notifications_repository.dart';
import 'di/chat_di.dart';

final GetIt sl = GetIt.instance;

abstract class ServiceLocator {
  static void init({
    required SharedPreferences prefs,
  }) async {
    sl.registerLazySingleton(() => AppSettings());
    sl.registerLazySingleton<SharedPreferences>(() => prefs);
    sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    sl.registerLazySingleton<FirebaseFirestore>(
        () => FirebaseFirestore.instance);
    sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
    sl.registerLazySingleton<FirebaseMessaging>(
        () => FirebaseMessaging.instance);

    sl.registerLazySingleton(() => AppStorage(storage: sl()));
    sl.registerLazySingleton<LocalizationRepository>(() =>
        UserLocalizationRepository(
            firestore: sl(), appStorage: sl(), userStorage: sl()));
    sl.registerLazySingleton(() => ThemeChangerCubit(appStorage: sl()));
    sl.registerLazySingleton<ImagePicker>(() => ImagePicker());
    sl.registerLazySingleton<StorageRepository>(
        () => StorageRepositoryImpl(storage: sl(), netWorkInfo: sl()));
    sl.registerLazySingleton<StorageClient>(
        () => SharedPrefStorage(prefs: sl()));
    sl.registerLazySingleton(() => InternetConnectionChecker());
    sl.registerLazySingleton<InternetCubit>(
        () => InternetCubit(connection: sl()));
    sl.registerLazySingleton<NetWorkInfo>(
        () => NetWorkInfoImpl(connectionChecker: sl()));
    sl.registerLazySingleton(
        () => LocalizationCubit(localizationRepository: sl()));
    sl.registerLazySingleton<ImagePickerClient>(
        () => ImagePickerClient(imagePicker: sl()));
    sl.registerLazySingleton(() => NotificationStorage(storage: sl()));

    sl.registerLazySingleton(() => FlutterLocalNotificationsPlugin());

    sl.registerLazySingleton<LocalNotificationClient>(
        () => FlutterLocalNotificationClient(noti: sl()));
    sl.registerLazySingleton<RemoteNotificationsClient>(
        () => FcmNotificationClient(messaging: sl(), firestore: sl()));
    sl.registerLazySingleton(() => NotificationsRepository(
          universityStorage: sl(),
          apiClient: DioClient(
              dio: Dio(),
              baseUrl: FcmConst.legacyApiBaseUrl,
              interceptor: FbMessagingInterceptor()),
          notificationStorage: sl(),
          storage: sl(),
          remoteNotificationsClient: sl(),
          localNotificationClient: sl(),
        ));
    sl.registerLazySingleton(() =>
        NotificationCubit(notificationsRepository: sl(), chatRepository: sl()));
    sl.registerLazySingleton<FavoriteClient>(
        () => FirebaseFavoriteClient(firestore: sl()));
    sl.registerLazySingleton(() => FavoriteStorage(storage: sl()));
    sl.registerLazySingleton<FavoriteRepository>(() => FavoriteRepository(
        storage: sl(),
        favoriteClient: sl(),
        netWorkInfo: sl(),
        userStorage: sl()));
    sl.registerLazySingleton(() => FavoriteCubit(favoriteRepository: sl()));
    initMofeed();
    initAuth();
    initCart();
    initChat();
    initEcho();
    initFoodCourt();
    initSakan();
    initUniversity();
    initAddrees();
  }
}
