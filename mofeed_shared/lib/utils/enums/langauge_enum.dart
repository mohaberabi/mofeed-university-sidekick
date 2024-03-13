import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

enum AppLangsEnum with CustomEnum {
  english("English", "English", "A", "en", "Lota"),
  arabic("عربي", "عربي", "ع", "ar", "Almarai");

  @override
  final String ar;
  @override
  final String en;
  final String id;
  final String code;
  final String fontFamily;

  const AppLangsEnum(this.en, this.ar, this.id, this.code, this.fontFamily);

  AppLangsEnum get next => this == english ? arabic : english;
}
extension SupportedLangEnumStringer on String {
  AppLangsEnum get toAppLang {
    switch (this) {
      case "ar":
        return AppLangsEnum.arabic;
      default:
        return AppLangsEnum.english;
    }
  }
}
mixin Translatable {
  MapJson get name;
}

mixin CustomEnum {
  String tr(String langCode) => langCode == 'ar' ? ar : en;

  String get en;

  String? get logo => null;

  MapJson get description => {'ar': "", "en": ""};

  String get ar;
}
