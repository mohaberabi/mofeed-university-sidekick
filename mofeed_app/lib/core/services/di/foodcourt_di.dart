import 'package:food_court/repository/food_repository.dart';
import 'package:food_court/repository/order_repository.dart';
import 'package:food_court/repository/rating_repository.dart';
import 'package:mofeduserpp/features/food_court/cubit/food_court_cubit/foodcourt_cubit.dart';
import 'package:mofeduserpp/features/food_court/data/mofeed_food_respository.dart';
import 'package:mofeduserpp/features/order/cubit/order_cubit/order_cubit.dart';
import 'package:mofeduserpp/features/order/data/mofeed_oredr_repository.dart';
import 'package:mofeduserpp/features/rating/cubit/rating_cubit.dart';
import 'package:mofeduserpp/features/rating/data/rating_repository_impl.dart';
import 'package:mofeed_shared/clients/foodcourt_client/firebase_food_cour_client.dart';
import 'package:mofeed_shared/clients/foodcourt_client/food_court_client.dart';
import 'package:mofeed_shared/clients/order_client/firebase_order_client.dart';
import 'package:mofeed_shared/clients/order_client/order_client.dart';
import 'package:mofeed_shared/clients/rating_client/firebase_rating_client.dart';
import 'package:mofeed_shared/clients/rating_client/rating_client.dart';
import '../../../features/checkout/cubit/checkout_cubit.dart';
import '../../../features/food_item/cubit/fooditem_cubit.dart';
import '../service_lcoator.dart';

void initFoodCourt() {
  sl.registerLazySingleton<OrderClient>(
      () => FirebaseOrderClient(firestore: sl()));
  sl.registerLazySingleton<FoodCourtClient>(
      () => FirebaseFoodCourtClient(firestore: sl()));
  sl.registerLazySingleton<UserFoodRepository>(() => MofeedFoodRepository(
      netWorkInfo: sl(), foodCourtClient: sl(), universityStorage: sl()));
  sl.registerFactory(() => FoodCourtCubit(foodRepository: sl()));
  sl.registerFactory(() => FoodItemCubit(foodRepository: sl()));
  sl.registerLazySingleton(() => FirebaseOrderClient(firestore: sl()));
  sl.registerLazySingleton<UserOrderRepository>(() => MofeedOrderRepository(
      netWorkInfo: sl(), userStorage: sl(), orderClient: sl()));
  sl.registerFactory(() => CheckoutCubit(
      authRepository: sl(),
      orderRepository: sl(),
      cartCubit: sl(),
      foodRepository: sl(),
      cartRepository: sl(),
      universityRepository: sl()));
  sl.registerLazySingleton<RatingClient>(
      () => FirebaseRatingClient(firestore: sl()));
  sl.registerLazySingleton<UserRatingRepository>(
      () => RatingRepositoryImpl(ratingClient: sl(), netWorkInfo: sl()));
  sl.registerFactory(() => OrderCubit(orderRepository: sl()));
  sl.registerFactory(
      () => RatingCubit(ratingRepository: sl(), authRepository: sl()));
}
