import 'package:mofeed_shared/utils/typdefs/typedefs.dart';
import 'package:mofeed_shared/model/open_street.dart';

class AppAddress {
  final double lat;

  final double lng;

  final String name;
  final String subName;

  const AppAddress({
    required this.name,
    required this.subName,
    required this.lat,
    required this.lng,
  });

  static const empty =
      AppAddress(name: "name", subName: "subName", lat: 1, lng: 1);

  factory AppAddress.fromMap(MapJson map) {
    return AppAddress(
      name: map["name"] ?? "",
      subName: map["subName"] ?? "",
      lat: (map["lat"].toDouble()) ?? 0.0,
      lng: (map["lng"].toDouble()) ?? 0.0,
    );
  }

  MapJson toMap() {
    return {
      "name": name,
      "subName": subName,
      "lat": lat,
      "lng": lng,
    };
  }

  factory AppAddress.fromAutoComplete(AutoCompleteResponse autoComplete) {
    return AppAddress(
        name: autoComplete.name,
        subName: autoComplete.displayName,
        lat: double.parse(autoComplete.lat),
        lng: double.parse(autoComplete.lon));
  }
}
