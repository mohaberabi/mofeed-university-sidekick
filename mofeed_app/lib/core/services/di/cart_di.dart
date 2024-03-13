import 'package:mofeduserpp/features/cart/cubit/cart_cubit.dart';
import 'package:mofeduserpp/features/cart/data/cart_repository.dart';
import 'package:mofeduserpp/features/cart/data/cart_storage.dart';

import '../service_lcoator.dart';

void initCart() {
  sl.registerLazySingleton(() => CartStorage(storage: sl()));
  sl.registerLazySingleton<CartRepository>(
      () => CartRepository(firestore: sl(), storage: sl()));
  sl.registerLazySingleton(() => CartCubit(cartRepository: sl()));
}
