import 'package:mofeduserpp/features/sakan/cubit/sakan_cubit/sakan_cubit.dart';
import 'package:mofeduserpp/features/sakan/data/sakan_builder_storage.dart';
import 'package:mofeduserpp/features/sakan/data/sakan_repository_impl.dart';
import 'package:mofeed_shared/clients/sakan_client/firebase_sakan_client.dart';
import 'package:mofeed_shared/clients/sakan_client/sakan_client.dart';

import '../../../features/sakan_builder/cubit/sakan_builder_cubit.dart';
import '../service_lcoator.dart';

void initSakan() {
  sl.registerLazySingleton<SakanClient>(
      () => FirebaseSakanCleint(firestore: sl()));
  sl.registerLazySingleton<SakanRepository>(() =>
      SakanRepository(storage: sl(), sakanClient: sl(), netWorkInfo: sl()));
  sl.registerLazySingleton(() => SakanBuilderStorage(storage: sl()));
  sl.registerLazySingleton(() => SakanBuilderCubit(
      sakanRepository: sl(),
      sakanBuilderStorage: sl(),
      authRepository: sl(),
      storageRepository: sl()));

  sl.registerFactory(() => SakanCubit(
      sakanRepository: sl(), authRepository: sl(), universityRepository: sl()));
}
