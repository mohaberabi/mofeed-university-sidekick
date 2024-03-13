import 'package:mofeduserpp/core/services/service_lcoator.dart';
import 'package:mofeduserpp/features/login/cubit/login_cubit.dart';
import 'package:mofeduserpp/features/profile/cubit/profile_cubit.dart';
import 'package:mofeduserpp/features/signup/cubit/signup_cubit.dart';
import 'package:mofeed_shared/clients/auth_client/auth_client.dart';
import 'package:mofeed_shared/clients/auth_client/firebase_auth_client.dart';

import '../../../features/signup/data/mofeed_auth_repository.dart';
import '../../../features/signup/data/user_storage.dart';

void initAuth() {
  sl.registerLazySingleton<AuthClient>(
      () => FirebaseAuthClient(firestore: sl(), auth: sl()));
  sl.registerLazySingleton(() => AuthRepository(
      userStorage: sl(),
      netWorkInfo: sl(),
      universityStorage: sl(),
      authClient: sl(),
      universityClient: sl()));
  sl.registerLazySingleton(() => UserStorage(storage: sl()));
  sl.registerFactory<SignUpCubit>(() => SignUpCubit(authRepository: sl()));
  sl.registerFactory<LoginCubit>(() => LoginCubit(authRepository: sl()));
  sl.registerFactory(() => ProfileCubit(
      authRepository: sl(), imagePickerClient: sl(), storageRepository: sl()));
}
