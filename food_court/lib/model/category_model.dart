import 'package:mofeed_shared/utils/enums/langauge_enum.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

class CategoryModel with Translatable {
  final String id;
  final int order;
  @override
  final MapJson name;

  const CategoryModel({
    required this.name,
    required this.id,
    required this.order,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> map) {
    return CategoryModel(name: map['name'], id: map['id'], order: map['order']);
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'id': id, 'order': order};
  }

  CategoryModel copyWith({
    String? id,
    int? order,
    MapJson? name,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      order: order ?? this.order,
      name: name ?? this.name,
    );
  }

  static const CategoryModel empty =
      CategoryModel(name: {"ar": "", "en": ""}, id: '', order: 0);
}
