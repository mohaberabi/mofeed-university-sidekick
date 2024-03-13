import 'package:mofeduserpp/core/services/service_lcoator.dart';
import 'package:mofeduserpp/features/echo/cubit/echo_cubit.dart';
import 'package:mofeduserpp/features/echo/data/repository/echo_repository.dart';
import 'package:mofeed_shared/clients/echo_client/echo_client.dart';
import 'package:mofeed_shared/clients/echo_client/firebase_echo_client.dart';

void initEcho() {
  sl.registerLazySingleton<EchoClient>(
      () => FirebaseEchoClient(firestore: sl()));
  sl.registerLazySingleton<EchoRepository>(
    () => EchoRepository(
      echoClient: sl(),
      universityStorage: sl(),
      netWorkInfo: sl(),
    ),
  );
  sl.registerFactory(() => EchoCubit(
      authRepository: sl(),
      echoRepository: sl(),
      storageRepository: sl(),
      fcmRepository: sl()));
}
