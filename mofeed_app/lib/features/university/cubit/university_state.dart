import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mofeed_shared/model/university_model.dart';
import 'package:mofeed_shared/utils/enums/state_enum.dart';

class UniversityState extends Equatable {
  final UniversityModel? myUniversity;
  final String error;
  final CubitState state;
  final List<UniversityModel> unis;

  const UniversityState({
    this.myUniversity,
    this.state = CubitState.initial,
    this.error = '',
    this.unis = const [],
  });

  @override
  List<Object?> get props => [
        myUniversity,
        error,
        myUniversity,
        state,
        unis,
      ];

  UniversityState copyWith({
    UniversityModel? myUniversity,
    String? error,
    CubitState? state,
    List<UniversityModel>? unis,
  }) =>
      UniversityState(
        myUniversity: myUniversity ?? this.myUniversity,
        error: error ?? this.error,
        state: state ?? this.state,
        unis: unis ?? this.unis,
      );

  @override
  String toString() => state.name;
}
