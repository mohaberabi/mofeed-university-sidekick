import 'package:equatable/equatable.dart';
import 'package:sakan/model/sakan_model.dart';
import 'package:sakan/utils/enums/common_enums.dart';

abstract class SakanClient {
  Future<void> addSakan(Sakan sakan);

  Future<void> deleteSakan(String id);

  Future<List<Sakan>> getSakans({
    SakanType type = SakanType.roomWanted,
    int limit = 10,
    String? lastDocId,
    bool? privateBathRoom,
    List<String>? amenities,
    int? minStay,
    int? maxStay,
    String? billingPeriod,
    int? availableFrom,
    bool? billIncluded,
    bool? isSingle,
    int? floor,
    int? currentMates,
    double? nearestServices,
    String? uid,
  });
}

abstract class SakanException with EquatableMixin implements Exception {
  final Object? error;

  const SakanException(this.error);

  @override
  List<Object?> get props => [error];

  @override
  String toString() => error.toString();
}

class GetSakansFailure extends SakanException {
  const GetSakansFailure(super.error);
}

class AddSakanFailure extends SakanException {
  const AddSakanFailure(super.error);
}

class DeleteSakanFailure extends SakanException {
  const DeleteSakanFailure(super.error);
}
