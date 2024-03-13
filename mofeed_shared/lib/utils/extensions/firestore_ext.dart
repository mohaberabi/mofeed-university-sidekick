import 'package:cloud_firestore/cloud_firestore.dart';

import '../typdefs/typedefs.dart';

extension PAginator on FirebaseFirestore {
  Future<List<T>> paginate<T>({
    required Query<MapJson> query,
    required CollectionReference<MapJson> lastDocColl,
    String? lastDocId,
    required Future<List<T>> Function(List<MapJson>) mapList,
  }) async {
    try {
      late final List<T> items;
      if (lastDocId == null) {
        final itemsMap = await query
            .get()
            .then((value) => value.docs.map((e) => e.data()).toList());
        items = await mapList(itemsMap);
      } else {
        final doc = await lastDocColl.doc(lastDocId).get();
        final itemsMap = await query
            .startAfterDocument(doc)
            .get()
            .then((value) => value.docs.map((e) => e.data()).toList());
        items = await mapList(itemsMap);
      }
      return items;
    } on FirebaseException {
      rethrow;
    }
  }
}
