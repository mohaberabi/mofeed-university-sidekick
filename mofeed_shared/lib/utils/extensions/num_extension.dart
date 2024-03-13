extension Clocker on num {
  String get clock {
    return this > 9 ? toInt().toString() : "0${toInt().toString()}";
  }

  String get recap {
    if (this >= 10) {
      return "+10";
    } else {
      return toString();
    }
  }
}

extension PriceConvertor on num {
  String toPrice(String langCode) {
    return langCode == 'ar'
        ? 'ج.م ${toStringAsFixed(2)}'
        : 'EGP ${toStringAsFixed(2)}';
  }
}
