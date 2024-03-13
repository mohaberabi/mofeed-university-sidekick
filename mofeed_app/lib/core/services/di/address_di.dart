import 'package:dio/dio.dart';
import 'package:mofeduserpp/core/services/service_lcoator.dart';
import 'package:mofeduserpp/features/address/cubit/address_cubit.dart';
import 'package:mofeduserpp/features/address/repository/adddress_repository.dart';
import 'package:mofeed_shared/clients/api/dio_client.dart';
import 'package:mofeed_shared/clients/autcomplete_client/autocomplete_client.dart';
import 'package:mofeed_shared/clients/autcomplete_client/open_street_autocomplete_client.dart';

void initAddrees() {
  sl.registerLazySingleton<AutoCompleteClient>(() =>
      OpenStreetAutoCompleteClient(
          apiClient: DioClient(dio: Dio(), baseUrl: "")));
  sl.registerLazySingleton(() => AddressRepository(client: sl()));
  sl.registerFactory(() => AddressCubit(addressRepository: sl()));
}
