import 'package:equatable/equatable.dart';
import 'package:food_court/model/option_group.dart';

enum OptionStatus {
  initial,
  loading,
  error,
  add,
  delete,
  populated;
}

class OptionState extends Equatable {
  final String error;
  final OptionStatus status;
  final OptionGroup option;
  final List<OptionGroup> options;

  const OptionState({
    this.status = OptionStatus.initial,
    this.error = '',
    this.options = const [],
    this.option = OptionGroup.empty,
  });

  OptionState copyWith(
      {String? error,
      OptionStatus? status,
      List<OptionGroup>? options,
      OptionGroup? option}) {
    return OptionState(
      option: option ?? this.option,
      error: error ?? this.error,
      status: status ?? this.status,
      options: options ?? this.options,
    );
  }

  @override
  List<Object?> get props => [
        error,
        status,
        option,
        options,
      ];

  bool get readyToAdd =>
      option.name['ar'] != null &&
      option.name['en'] != null &&
      option.name.isNotEmpty &&
      option.children.isNotEmpty &&
      childReady;

  bool get childReady => option.children
      .every((element) => element.name.isNotEmpty && element.price > 0);
}
