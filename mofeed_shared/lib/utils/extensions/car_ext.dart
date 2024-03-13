import 'package:flutter/services.dart';

extension CarPath on int {
  String get toCarPath {
    switch (this) {
      case 4289595608:
        return 'assets/cars/purple.png';
      case 4290454293:
        return 'assets/cars/red.png';
      case 4289374890:
        return 'assets/cars/silver.png';
      case 4292136368:
        return 'assets/cars/tan.png';
      case 4294967290:
        return 'assets/cars/white.png';
      case 4294888965:
        return 'assets/cars/yellow.png';
      case 4281611580:
        return 'assets/cars/grey.png';
      case 4278190080:
        return 'assets/cars/black.png';
      case 4279709272:
        return 'assets/cars/blue.png';
      case 4284627489:
        return 'assets/cars/brown.png';
      case 4291410286:
        return 'assets/cars/gold.png';
      case 4285970734:
        return 'assets/cars/green.png';
      case 4292694569:
        return 'assets/cars/orange.png';
      default:
        return 'assets/cars/black.png';
    }
  }

  String toColorName(String langCode) {
    switch (this) {
      case 4289595608:
        return langCode == 'ar' ? 'أرجواني' : 'Purple';
      case 4290454293:
        return langCode == 'ar' ? 'احمر' : 'Red';
      case 4289374890:
        return langCode == 'ar' ? 'فضي' : 'Silver';
      case 4292136368:
        return langCode == 'ar' ? 'تان' : 'Tan';
      case 4294967290:
        return langCode == 'ar' ? 'ابيض' : 'White';
      case 4294888965:
        return langCode == 'ar' ? 'صفراء' : 'Yellow';
      case 4281611580:
        return langCode == 'ar' ? 'رمادي' : 'Grey';
      case 4278190080:
        return langCode == 'ar' ? 'اسود' : 'Black';
      case 4279709272:
        return langCode == 'ar' ? 'ازرق' : 'Blue';
      case 4284627489:
        return langCode == 'ar' ? 'بُني' : 'Brown';
      case 4291410286:
        return langCode == 'ar' ? 'دهبي' : 'Gold';
      case 4285970734:
        return langCode == 'ar' ? 'اخضر' : 'Green';
      case 4292694569:
        return langCode == 'ar' ? 'برتقالي' : 'Orange';
      default:
        return langCode == 'ar' ? 'اسود' : 'Black';
    }
  }
}

const Map carColorsMap = {
  'grey': 4281611580,
  'black': 4278190080,
  'blue': 4279709272,
  'brown': 4284627489,
  'gold': 4291410286,
  'green': 4285970734,
  'orange': 4292694569,
  'purple': 4289595608,
  'red': 4290454293,
  'silver': 4289374890,
  'tan': 4292136368,
  'white': 4294967290,
  'yellow': 4294888965,
};
