import 'package:mofeed_shared/utils/enums/langauge_enum.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

class ItemModel with Translatable {
  final String id;
  final List<String> variationsIds;
  @override
  final MapJson name;
  final double price;
  final String image;
  final String categoryId;
  final MapJson describtion;
  final bool inStock;
  final String restaurantId;

  const ItemModel({
    required this.price,
    required this.variationsIds,
    required this.image,
    required this.name,
    required this.id,
    required this.categoryId,
    required this.describtion,
    required this.inStock,
    required this.restaurantId,
  });

  factory ItemModel.fromJson(Map<String, dynamic> map) {
    return ItemModel(
      restaurantId: map['restaurantId'] ?? '3',
      id: map['id'],
      variationsIds: map["variationsIds"] != null
          ? (map['variationsIds'] as List).map((e) => e.toString()).toList()
          : [],
      name: map['name'],
      price: map['price'] != null ? map['price'].toDouble() : 0.0,
      image: map['image'],
      categoryId: map['categoryId'],
      describtion: map['describtion'],
      inStock: map['inStock'] ?? true,
    );
  }

  ItemModel copyWith({
    String? id,
    List<String>? variationsIds,
    MapJson? name,
    double? price,
    String? image,
    String? categoryId,
    MapJson? describtion,
    bool? inStock,
    String? restaurantId,
  }) {
    return ItemModel(
      id: id ?? this.id,
      variationsIds: variationsIds ?? this.variationsIds,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      categoryId: categoryId ?? this.categoryId,
      describtion: describtion ?? this.describtion,
      inStock: inStock ?? this.inStock,
      restaurantId: restaurantId ?? this.restaurantId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'name': name,
      'price': price,
      'image': image,
      'categoryId': categoryId,
      'describtion': describtion,
      'inStock': inStock,
      'variationsIds': variationsIds,
    };
  }

  static const ItemModel empty = ItemModel(
      price: 0,
      variationsIds: [],
      image: '',
      name: {},
      id: '',
      categoryId: '',
      describtion: {},
      inStock: true,
      restaurantId: '');

  bool get isVariable => variationsIds.isNotEmpty;
}
