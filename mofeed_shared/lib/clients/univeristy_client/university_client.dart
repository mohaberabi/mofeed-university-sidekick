import 'package:equatable/equatable.dart';

import '../../model/university_model.dart';

abstract class UniversityClient {
  Future<List<UniversityModel>> getUniversities();

  Future<UniversityModel> getMYUniversity(String id);
}

abstract class UniversityException with EquatableMixin implements Exception {
  final Object? error;

  const UniversityException(this.error);

  @override
  List<Object?> get props => [error];

  @override
  String toString() => error.toString();
}

class GetMyUniversityFailure extends UniversityException {
  const GetMyUniversityFailure(super.error);
}

class GetAllUniversityFailure extends UniversityException {
  const GetAllUniversityFailure(super.error);
}
