import 'package:mofeed_shared/clients/autcomplete_client/autocomplete_client.dart';
import 'package:mofeed_shared/model/open_street.dart';

import '../api/api_client.dart';

abstract final class OpenStreetApis {
  static const autoCompleteApi =
      "https://nominatim.openstreetmap.org/search?format=json&q=";
}

class OpenStreetAutoCompleteClient implements AutoCompleteClient {
  final ApiClient _apiClient;

  const OpenStreetAutoCompleteClient({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  @override
  Future<List<AutoCompleteResponse>> getAddress(String query) async {
    try {
      final response = await _apiClient
          .get("${OpenStreetApis.autoCompleteApi}$query&countrycodes=eg");
      final address = (response as List)
          .map((e) => AutoCompleteResponse.fromJson(e))
          .toList();
      return address;
    } catch (e, st) {
      Error.throwWithStackTrace(GetAddressFailure(e), st);
    }
  }
}
