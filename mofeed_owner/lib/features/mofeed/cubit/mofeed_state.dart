import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class MofeedState extends Equatable {
  final int index;

  const MofeedState({this.index = 0});

  @override
  List<Object?> get props => [index];

  MofeedState copyWith({int? index}) {
    return MofeedState(index: index ?? this.index);
  }
}
