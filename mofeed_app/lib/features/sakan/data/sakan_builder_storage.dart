import 'dart:convert';

import 'package:mofeduserpp/features/sakan_builder/cubit/skan_builder_ext.dart';
import 'package:mofeed_shared/helper/storage_client.dart';

import '../../sakan_builder/cubit/sakan_builder_state.dart';

class SakanBuilderStorage {
  final StorageClient _storage;

  const SakanBuilderStorage({
    required StorageClient storage,
  }) : _storage = storage;

  static const String _key = "sakanStorageKey";

  Future<void> delete() async => await _storage.delete(key: _key);

  Future<void> saveSakanState(SakanBuilderState state) async {
    await _storage.write(key: _key, value: jsonEncode(state.toMap()));
  }

  Future<SakanBuilderState?> getSakanState() async {
    final stateString = await _storage.read(key: _key);

    if (stateString != null) {
      return SakanBuilderState.fromMap(jsonDecode(stateString));
    } else {
      return null;
    }
  }
}
