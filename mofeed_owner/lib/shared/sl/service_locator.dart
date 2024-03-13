import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_court/repository/category_repository.dart';
import 'package:food_court/repository/food_option_repository.dart';
import 'package:food_court/repository/item_repository.dart';
import 'package:food_court/repository/order_repository.dart';
import 'package:food_court/repository/rating_repository.dart';
import 'package:food_court/repository/restaurant_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mofeed_owner/features/category/cubit/category_cubit.dart';
import 'package:mofeed_owner/features/category/data/category_reposiotry_impl.dart';
import 'package:mofeed_owner/features/gallery/cubit/gallery_cubit.dart';
import 'package:mofeed_owner/features/gallery/repository/gallery_repository.dart';
import 'package:mofeed_owner/features/item/cubit/item_cubit.dart';
import 'package:mofeed_owner/features/item/data/item_repository_impl.dart';
import 'package:mofeed_owner/features/mofeed/cubit/mofeed_cubit.dart';
import 'package:mofeed_owner/features/navigation/cubit/navigation_cubit.dart';
import 'package:mofeed_owner/features/notifications/cubit/notifications_cubit.dart';
import 'package:mofeed_owner/features/notifications/data/fcm_repository_impl.dart';
import 'package:mofeed_owner/features/option/cubit/option_cubit.dart';
import 'package:mofeed_owner/features/option/data/food_option_repository_impl.dart';
import 'package:mofeed_owner/features/order/cubit/order_cubit.dart';
import 'package:mofeed_owner/features/order/data/order_repository_impl.dart';
import 'package:mofeed_owner/features/rating/cubit/rating_cubit.dart';
import 'package:mofeed_owner/features/rating/data/rating_repository_impl.dart';
import 'package:mofeed_owner/features/restraurant/cubit/restarant_cubit.dart';
import 'package:mofeed_shared/api/api_client.dart';
import 'package:mofeed_shared/api/dio_client.dart';
import 'package:mofeed_shared/api/dio_interceptors.dart';
import 'package:mofeed_shared/constants/fcm_const.dart';
import 'package:mofeed_shared/cubit/localization_cubit/local_cubit.dart';
import 'package:mofeed_shared/data/app_storage.dart';
import 'package:mofeed_shared/data/auth_repository.dart';
import 'package:mofeed_shared/data/fcm_repository.dart';
import 'package:mofeed_shared/data/network_info.dart';
import 'package:mofeed_shared/data/storage_repository.dart';
import 'package:mofeed_shared/helper/shared_pref_sorage.dart';
import 'package:mofeed_shared/helper/storage_client.dart';
import 'package:mofeed_shared/localization/data/localization_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/cubit/auth_cubit.dart';
import '../../features/auth/data/mofeed_auth_repository.dart';
import '../../features/auth/data/user_storage.dart';
import '../../features/restraurant/data/restaurant_repository_impl.dart';

final sl = GetIt.instance;

Future<void> initSl() async {
  final sharedPrefrences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => LocalizationRepository(storage: sl()));
  sl.registerLazySingleton(() => AppStorage(storage: sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetWorkInfo>(
      () => NetWorkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<SharedPreferences>(() => sharedPrefrences);
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  sl.registerLazySingleton<FirebaseMessaging>(() => FirebaseMessaging.instance);
  sl.registerLazySingleton<StorageClient>(() => SharedPrefStorage(prefs: sl()));
  sl.registerLazySingleton(() => AuthStorage(storage: sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      firestore: sl(), auth: sl(), userStorage: sl(), netWorkInfo: sl()));
  sl.registerLazySingleton(() => AuthCubit(authRepository: sl()));
  sl.registerLazySingleton(
      () => LocalizationCubit(localizationRepository: sl()));
  sl.registerLazySingleton(() => AcceptNavCubit(auth: sl(), storage: sl()));
  sl.registerLazySingleton(() => MofeedCubit());
  sl.registerLazySingleton<GalleryRepository>(() =>
      GalleryReposiotryImpl(firestore: sl(), netWorkInfo: sl(), storage: sl()));
  sl.registerLazySingleton<StorageRepository>(
      () => StorageRepositoryImpl(storage: sl(), netWorkInfo: sl()));
  sl.registerLazySingleton(
      () => GalleryCubit(galleryRepository: sl(), storageRepository: sl()));
  sl.registerLazySingleton<RestaurntRepository>(() => RestaurantRepositoryImpl(
      firestore: sl(), storage: sl(), netWorkInfo: sl()));
  sl.registerLazySingleton(() => RestarantCubit(restaurntRepository: sl()));
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl(
      storage: sl(), firestore: sl(), netWorkInfo: sl()));
  sl.registerLazySingleton(() => CategoryCubit(categoryRepository: sl()));

  sl.registerLazySingleton<RatingRepository>(() =>
      RatingRepositoryImpl(firestore: sl(), storage: sl(), netWorkInfo: sl()));

  sl.registerLazySingleton(() => RatingCubit(ratingRepository: sl()));

  sl.registerLazySingleton<ItemRepository>(() =>
      ItemRepositoryImpl(firestore: sl(), netWorkInfo: sl(), storage: sl()));
  sl.registerLazySingleton(() => ItemCubit(itemRepository: sl()));
  sl.registerLazySingleton<OwnerOrderRepository>(
      () => OrderRepositoryImpl(firestore: sl(), auth: sl()));
  sl.registerLazySingleton(() => OptionCubit(foodOptionRepository: sl()));
  sl.registerLazySingleton(
      () => OrderCubit(orderRepository: sl(), fcmRepository: sl()));
  sl.registerLazySingleton<FoodOptionRepository>(() => FoodOptionRepositoryImpl(
      firestore: sl(), netWorkInfo: sl(), storage: sl()));

  sl.registerLazySingleton<ApiClient>(() => DioClient(
      dio: Dio(),
      baseUrl: FcmConst.legacyApiBaseUrl,
      interceptor: FbMessagingInterceptor()));
  sl.registerLazySingleton<FcmRepository>(() => OwnerFcmRecpositoryImpl(
      storage: sl(), client: sl(), messaging: sl(), firestore: sl()));
  sl.registerLazySingleton(() => NotificationCubit(fcmRepository: sl()));
}
