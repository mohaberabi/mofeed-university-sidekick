import 'dart:convert';

import 'package:mofeed_shared/model/favorite_model.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

class FavoriteData {
  final FavoriteType type;

  final List ids;

  const FavoriteData({
    required this.type,
    required this.ids,
  });

  factory FavoriteData.fromMap(MapJson map) {
    return FavoriteData(
        type: map['type'].toString().toFavoriteType,
        ids: map['ids'] == null
            ? []
            : (map['ids'] as List).map((e) => e.toString()).toList());
  }

  MapJson toMap() {
    return {"type": type.name, "ids": ids};
  }

  factory FavoriteData.fromJson(String json) {
    return FavoriteData.fromJson(jsonDecode(json));
  }

  FavoriteData copyWith({
    FavoriteType? type,
    List<String>? ids,
  }) {
    return FavoriteData(
      type: type ?? this.type,
      ids: ids ?? this.ids,
    );
  }
}

extension FavoriteStringer on String {
  FavoriteType get toFavoriteType {
    switch (this) {
      case "mateWanted":
        return FavoriteType.mateWanted;
      case "roomWanted":
        return FavoriteType.roomWanted;
      default:
        return FavoriteType.restarant;
    }
  }
}
