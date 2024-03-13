import 'package:food_court/utils/extensions/cuisine_ext.dart';
import 'package:food_court/utils/extensions/restarant_ext.dart';
import 'package:mofeed_shared/model/favorite_model.dart';
import 'package:mofeed_shared/utils/enums/langauge_enum.dart';
import 'package:mofeed_shared/utils/enums/restarant.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';
import '../../utils/enums/cuisine.dart';

class RestarantModel with Translatable implements Favorite {
  @override
  final MapJson name;
  final String id;
  final String uniId;
  final String logo;
  final DateTime? createdAt;
  final RestarantStateEnum state;
  final int minPickupTime;
  final List<Cuisine> cuisines;
  final String token;
  final bool offersDelivery;
  final int ratingCount;
  final int ratings;
  final double fees;

  const RestarantModel({
    required this.name,
    required this.offersDelivery,
    required this.id,
    required this.state,
    this.createdAt,
    required this.cuisines,
    required this.logo,
    required this.minPickupTime,
    required this.uniId,
    required this.token,
    this.ratings = 0,
    this.ratingCount = 0,
    this.fees = 15.0,
  });

  RestarantModel copyWith({
    MapJson? name,
    double? averageRating,
    String? id,
    String? uniId,
    String? logo,
    DateTime? createdAt,
    RestarantStateEnum? state,
    int? minPickupTime,
    List<Cuisine>? cuisines,
    String? token,
    bool? offersDelivery,
    double? fees,
  }) {
    return RestarantModel(
      fees: fees ?? this.fees,
      name: name ?? this.name,
      id: id ?? this.id,
      uniId: uniId ?? this.uniId,
      logo: logo ?? this.logo,
      createdAt: createdAt ?? this.createdAt,
      state: state ?? this.state,
      minPickupTime: minPickupTime ?? this.minPickupTime,
      cuisines: cuisines ?? this.cuisines,
      token: token ?? this.token,
      offersDelivery: offersDelivery ?? this.offersDelivery,
    );
  }

  factory RestarantModel.fromMap(Map<String, dynamic> map) {
    return RestarantModel(
        fees: map['fees'] != null ? map['fees'].toDouble() : 15,
        name: map['name'] ?? {"ar": "", "en": ""},
        ratings: map['ratings'] ?? 0,
        ratingCount: map['ratingCount'] ?? 0,
        offersDelivery: map['offersDelivery'] ?? false,
        id: map['id'] ?? "",
        state: map['state'] != null
            ? (map['state'] as String).toRestarantState
            : RestarantStateEnum.closed,
        cuisines: map['cuisines'] != null
            ? (map['cuisines'] as List)
                .map((e) => e.toString().toCuisine())
                .toList()
            : <Cuisine>[],
        logo: map['logo'] ?? "",
        minPickupTime: map['minPickupTime'] ?? 30,
        uniId: map['uniId'] ?? "",
        token: map['token'] ?? "");
  }

  Map<String, dynamic> toMap() {
    return {
      'offersDelivery': offersDelivery,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'cuisines': cuisines.map((e) => e.name).toList(),
      'logo': logo,
      'minPickupTime': minPickupTime,
      'uniId': uniId,
      'token': token,
      'state': state.name,
      'id': id,
      'name': name,
      'ratingCount': ratingCount,
      'ratings': ratings,
      "fees": fees
    };
  }

  double get averageRating => ratings / (ratingCount == 0 ? 1 : ratingCount);

  String cusinesRecap(String langCode) {
    return cuisines.fold('',
        (previousValue, element) => '$previousValue${element.tr(langCode)} , ');
  }

  static const empty = RestarantModel(
      name: {"ar": "", "en": ""},
      offersDelivery: false,
      id: '',
      state: RestarantStateEnum.closed,
      cuisines: [],
      logo: '',
      minPickupTime: 0,
      uniId: '',
      fees: 0,
      token: '');

  @override
  FavoriteType get favoriteType => FavoriteType.restarant;
}
