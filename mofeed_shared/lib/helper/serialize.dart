import 'dart:convert';

abstract class StorageHelper {
  static List<T> listFromString<T>({
    required T Function(Map<String, dynamic>) fromJson,
    required String? encodedList,
  }) {
    if (encodedList == null) {
      return [];
    }
    final list = (json.decode(encodedList) as List)
        .map((item) => fromJson(jsonDecode(item)))
        .toList();
    return list;
  }

  static String stringFromList<T>({
    required List<T> list,
    required String Function(T) toJson,
  }) {
    final jsonList = json.encode(list.map((item) => toJson(item)).toList());

    return jsonList;
  }
}
