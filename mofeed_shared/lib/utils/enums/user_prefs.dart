import 'package:mofeed_shared/ui/icons/app_icons.dart';
import 'package:mofeed_shared/utils/enums/langauge_enum.dart';

enum Pet with CustomEnum {
  dontHaveButLove("Okay with pets", "اقبل الحيوانات ", AppIcons.noPet),
  na(
    "Choose Pet Opinion",
    "اختار رأيك في الحيوانات الأليفة",
    AppIcons.noPet,
  ),
  hate("I Hate Pets", "اكره الحيوانات", AppIcons.noPet);

  @override
  final String ar;
  @override
  final String en;
  final String icon;

  const Pet(this.en, this.ar, this.icon);

  bool get isNa => this == Pet.na;
}

extension PetSting on String {
  Pet get toPet {
    switch (this) {
      case "dontHaveButLove":
        return Pet.dontHaveButLove;
      case "hate":
        return Pet.hate;
      case "na":
        return Pet.na;
      default:
        return Pet.na;
    }
  }
}

enum Smoking with CustomEnum {
  smoker("Smoker", "مدخن", AppIcons.smoke),
  nonSmoker("Non-Smoker ,I Hate Smoking", "غير مدخن", AppIcons.noSmoking),
  nonSmokerButOkay(
    "Non Smoker but okay with smoking",
    "غير مدخن ولكن لا مانع",
    AppIcons.smoke,
  );

  @override
  final String ar;
  @override
  final String en;
  final String icon;

  const Smoking(this.en, this.ar, this.icon);
}

extension Smokinting on String {
  Smoking get toSmoking {
    switch (this) {
      case "smoker":
        return Smoking.smoker;
      case "nonSmoker":
        return Smoking.nonSmoker;
      case "nonSmokerButOkay":
        return Smoking.nonSmokerButOkay;
      default:
        return Smoking.nonSmokerButOkay;
    }
  }
}

enum Gender with CustomEnum {
  male("Male", "ذكر", AppIcons.male),
  na("Choose Gender", "اختار التوع", AppIcons.male),
  female("Female", "انثي", AppIcons.female);

  @override
  final String ar;
  @override
  final String en;
  final String icon;

  bool get isNa => this == Gender.na;

  const Gender(this.en, this.ar, this.icon);
}

extension Genderting on String {
  Gender get toGender {
    switch (this) {
      case "female":
        return Gender.female;
      case "male":
        return Gender.male;
      default:
        return Gender.na;
    }
  }
}

enum Religion with CustomEnum {
  muslim("Muslim", "مسلم", AppIcons.muslim),
  christian("Christian", "مسيحي", AppIcons.chris),
  na("Choose religion", "اختار الديانة", AppIcons.muslim);

  @override
  final String ar;
  @override
  final String en;
  final String icon;

  bool get isNa => this == Gender.na;

  const Religion(this.en, this.ar, this.icon);
}

extension Religoner on String {
  Religion get toReligion {
    switch (this) {
      case "muslim":
        return Religion.muslim;
      case "christian":
        return Religion.christian;
      default:
        return Religion.na;
    }
  }
}

enum UserType {
  client,
  admin,
  owner;
}

extension UserTyper on String {
  UserType get toUserType {
    switch (this) {
      case 'owner':
        return UserType.owner;
      case 'admin':
        return UserType.admin;
      default:
        return UserType.client;
    }
  }
}
