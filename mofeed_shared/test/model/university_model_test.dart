import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mofeed_shared/model/university_model.dart';

void main() {
  group("university model", () {
    test("supports equality", () {
      expect(
        const UniversityModel(
            domain: "domain",
            location: GeoPoint(1, 1),
            id: "id",
            logo: "logo",
            allowedRange: 1,
            abreviation: "",
            name: {},
            faculties: [],
            topic: UniTopic(ar: "ar", en: "en")),
        const UniversityModel(
            domain: "domain",
            location: GeoPoint(1, 1),
            id: "id",
            logo: "logo",
            allowedRange: 1,
            abreviation: "",
            name: {},
            faculties: [],
            topic: UniTopic(ar: "ar", en: "en")),
      );
    });

    group("isEmpty", () {
      test("should be wqual to empty instance", () {
        const uni = UniversityModel(
            domain: "",
            location: GeoPoint(0, 0),
            id: "",
            logo: "",
            allowedRange: 0,
            abreviation: "",
            name: {},
            faculties: [],
            topic: UniTopic.empty);
        expect(
          uni,
          UniversityModel.empty,
        );
        expect(uni.isEmpty, true);
      });
    });
  });
}
