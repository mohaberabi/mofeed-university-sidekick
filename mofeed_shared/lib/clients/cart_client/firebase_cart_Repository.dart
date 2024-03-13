import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_court/model/cart_item.dart';
import 'package:mofeed_shared/clients/cart_client/cart_client.dart';

class FirebaseCartClient implements CartClient {
  final FirebaseFirestore _firestore;

  const FirebaseCartClient({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  @override
  Future<List<CartItem>> reOrder({
    required List<CartItem> currentItems,
  }) {
    // TODO: implement reOrder
    throw UnimplementedError();
  }
}
