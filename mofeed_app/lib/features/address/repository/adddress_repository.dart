import 'package:mofeed_shared/clients/autcomplete_client/autocomplete_client.dart';
import 'package:mofeed_shared/model/open_street.dart';

class AddressRepository {
  final AutoCompleteClient _client;

  const AddressRepository({
    required AutoCompleteClient client,
  }) : _client = client;

  Future<List<AutoCompleteResponse>> getAddress(String q) async {
    try {
      final res = await _client.getAddress(q);
      return res;
    } catch (e, st) {
      Error.throwWithStackTrace(e, st);
    }
  }
}
