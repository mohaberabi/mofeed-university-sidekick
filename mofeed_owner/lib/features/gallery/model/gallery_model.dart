import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

class GalleryModel {
  final String url;

  final String name;
  final String id;

  const GalleryModel({
    required this.name,
    required this.url,
    required this.id,
  });

  factory GalleryModel.fromMap(MapJson map) {
    return GalleryModel(
      url: map["url"],
      name: map["name"],
      id: map["id"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'name': name,
      'id': id,
    };
  }

  GalleryModel copyWith({
    String? url,
    String? name,
    String? id,
  }) {
    return GalleryModel(
      url: url ?? this.url,
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }
}
