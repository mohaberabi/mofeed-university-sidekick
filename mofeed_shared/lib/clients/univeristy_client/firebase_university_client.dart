import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mofeed_shared/clients/univeristy_client/university_client.dart';
import 'package:mofeed_shared/model/university_model.dart';
import 'package:mofeed_shared/utils/error/error_codes.dart';

import '../../constants/fireabse_constants.dart';
import '../../utils/typdefs/typedefs.dart';

class FirebaseUniversityClient implements UniversityClient {
  final FirebaseFirestore _firestore;

  const FirebaseUniversityClient({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  @override
  Future<UniversityModel> getMYUniversity(String id) async {
    try {
      final myUniversity = await _universities
          .doc(id)
          .get()
          .then((value) => UniversityModel.fromMap(value.data()!));
      return myUniversity;
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(GetMyUniversityFailure(e.mapCodeToError), st);
    }
  }

  @override
  Future<List<UniversityModel>> getUniversities() async {
    try {
      final universities = await _universities.get().then((value) =>
          value.docs.map((e) => UniversityModel.fromMap(e.data())).toList());
      return universities;
    } on FirebaseException catch (e, st) {
      Error.throwWithStackTrace(GetAllUniversityFailure(e.mapCodeToError), st);
    }
  }

  CollectionReference<MapJson> get _universities =>
      _firestore.collection(FirebaseConst.universities);
}
