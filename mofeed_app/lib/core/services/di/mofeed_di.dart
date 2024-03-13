import 'package:mofeduserpp/core/services/service_lcoator.dart';
import 'package:mofeduserpp/features/navigation/cubit/mofeed_nav_cubit.dart';
import 'package:mofeduserpp/features/navigation/data/startup_repository.dart';

import '../../../features/mofeed/cubit/mofeed_cubit.dart';

void initMofeed() {
  sl.registerLazySingleton(() => MofeedCubit(appStorage: sl()));
  sl.registerLazySingleton(() =>
      StartupRepository(appStorage: sl(), authClient: sl(), userStorage: sl()));
  sl.registerFactory(() => NavigationCubit(startupRepository: sl()));
}
