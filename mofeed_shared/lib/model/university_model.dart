import 'dart:convert';
import 'package:cloud_firestore_platform_interface/src/geo_point.dart';
import 'package:equatable/equatable.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';
import '../utils/enums/langauge_enum.dart';

class UniversityModel with Translatable, EquatableMixin {
  final String id;
  final GeoPoint location;
  final String abreviation;
  final double allowedRange;
  final String logo;
  final String domain;
  final List<FacultyModel> faculties;
  @override
  final Map<String, dynamic> name;
  final String city;
  final UniTopic topic;

  bool get isEmpty => this == empty;

  const UniversityModel({
    required this.domain,
    required this.location,
    required this.id,
    required this.logo,
    required this.allowedRange,
    required this.abreviation,
    required this.name,
    required this.faculties,
    this.city = 'cai',
    required this.topic,
  });

  static const UniversityModel empty = UniversityModel(
      domain: '',
      location: GeoPoint(0, 0),
      id: "",
      logo: '',
      allowedRange: 0,
      abreviation: "",
      name: {},
      faculties: [],
      topic: UniTopic.empty);

  factory UniversityModel.fromMap(MapJson map) {
    return UniversityModel(
      id: map['id'] ?? '',
      faculties: map['faculties'] != null
          ? (map['faculties'] as List)
              .map((e) => FacultyModel.fromMap(e))
              .toList()
          : [],
      domain: map['domain'] ?? "",
      name: map['name'],
      topic: UniTopic.fromMap(map['topic']),
      location: GeoPoint(map['latitude'] ?? 0.0, map['longitude'] ?? 0.0),
      abreviation: map['abreviation'],
      allowedRange: map['allowedRange'].toDouble(),
      logo: map['logo'] ?? "",
    );
  }

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'latitude': location.latitude,
      'longitude': location.longitude,
      'abreviation': abreviation,
      'allowedRange': allowedRange,
      'logo': logo,
      'name': name,
      'domain': domain,
      'faculties': faculties.map((e) => e.toMap()).toList(),
      'city': city,
      "topic": topic.toMap(),
    };
  }

  @override
  List<Object?> get props => [
        topic,
        city,
        faculties,
        domain,
        name,
        logo,
        allowedRange,
        abreviation,
        location,
        id,
      ];
}

class UniTopic {
  final String ar;

  final String en;

  const UniTopic({
    required this.ar,
    required this.en,
  });

  MapJson toMap() {
    return {
      "ar": ar,
      "en": en,
    };
  }

  static const UniTopic empty = UniTopic(ar: '', en: '');

  factory UniTopic.fromMap(MapJson map) {
    return UniTopic(
      ar: map['ar'],
      en: map['en'],
    );
  }

  @override
  int get hashCode => ar.hashCode ^ en.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UniTopic && other.ar == ar && other.en == en;
  }
}

class FacultyModel with Translatable {
  const FacultyModel({
    required this.id,
    required this.name,
  });

  final String id;
  @override
  final Map<String, dynamic> name;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory FacultyModel.fromMap(Map<String, dynamic> map) {
    return FacultyModel(
      id: map['id'],
      name: map['name'],
    );
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FacultyModel && other.id == id && other.name == name;
  }
}
