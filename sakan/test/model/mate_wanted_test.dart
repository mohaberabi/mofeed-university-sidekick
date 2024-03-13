import 'package:flutter_test/flutter_test.dart';
import 'package:mofeed_shared/model/app_address.dart';
import 'package:mofeed_shared/utils/enums/user_prefs.dart';
import 'package:sakan/model/mate_wanted.dart';
import 'package:sakan/utils/enums/common_enums.dart';

void main() {
  group("mate wanted ", () {
    test("supports equality", () {
      expect(
          MateWanted(
              price: 1,
              title: "title",
              description: "description",
              amenties: [],
              createdAt: DateTime.now(),
              isBillIncluded: true,
              isSingle: true,
              currentMates: 1,
              nearestServices: 1,
              metres: 1,
              floor: 1,
              privateBathRoom: true,
              anyUniversity: true,
              billingPeriod: BillingPeriod.monthly,
              minStay: 1,
              maxStay: 1,
              roomImages: [],
              availableFrom: DateTime.now(),
              id: "id",
              uniId: "uniId",
              uid: "uid",
              pet: Pet.na,
              religion: Religion.na,
              gender: Gender.male,
              username: "username",
              profilePic: "",
              smoking: Smoking.nonSmoker,
              address: AppAddress.empty,
              universityName: {},
              universityLogo: '',
              uniLat: 1,
              uniLng: 1),
          MateWanted(
              price: 1,
              title: "title",
              description: "description",
              amenties: [],
              createdAt: DateTime.now(),
              isBillIncluded: true,
              isSingle: true,
              currentMates: 1,
              nearestServices: 1,
              metres: 1,
              floor: 1,
              privateBathRoom: true,
              anyUniversity: true,
              billingPeriod: BillingPeriod.monthly,
              minStay: 1,
              maxStay: 1,
              roomImages: [],
              availableFrom: DateTime.now(),
              id: "id",
              uniId: "uniId",
              uid: "uid",
              pet: Pet.na,
              religion: Religion.na,
              gender: Gender.male,
              username: "username",
              profilePic: "",
              smoking: Smoking.nonSmoker,
              address: AppAddress.empty,
              universityName: {},
              universityLogo: '',
              uniLat: 1,
              uniLng: 1));
    });
  });
}
