import 'package:mofeduserpp/features/university/cubit/university_cubit.dart';
import 'package:mofeed_shared/clients/univeristy_client/firebase_university_client.dart';
import 'package:mofeed_shared/clients/univeristy_client/university_client.dart';

import '../../../features/university/data/university_repository_impl.dart';
import '../../../features/university/data/university_storage.dart';
import '../service_lcoator.dart';

void initUniversity() {
  sl.registerLazySingleton<UniversityClient>(
      () => FirebaseUniversityClient(firestore: sl()));
  sl.registerLazySingleton(() => UniversityStorage(storage: sl()));
  sl.registerLazySingleton(() => UniversityRepository(
      univeristyClient: sl(), storage: sl(), netWorkInfo: sl()));
  sl.registerFactory(() => UniversityCubit(universityRepository: sl()));
}
