import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

extension UniLator on BuildContext {
  double distanceInKm({
    required double startLat,
    required startLng,
    required double endLat,
    required double endLng,
  }) {
    final meteres =
        Geolocator.distanceBetween(startLat, startLng, endLat, endLng);

    return (meteres / 1000);
  }
}
