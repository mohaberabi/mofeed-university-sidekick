import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mofeed_shared/model/echo_model.dart';

enum EchoStatus {
  initial,
  loading,
  deleted,
  replied,
  populated,
  posted,
  error,
}

class EchoState extends Equatable {
  final Map<String, EchoModel> echos;
  final String error;
  final EchoStatus status;
  final String echo;
  final Map<String, EchoModel> replies;
  final bool allowChats;

  const EchoState({
    this.echos = const {},
    this.error = '',
    this.status = EchoStatus.initial,
    this.echo = '',
    this.replies = const {},
    this.allowChats = false,
  });

  @override
  List<Object?> get props => [
        status,
        error,
        echos,
        echo,
        replies,
        allowChats,
      ];

  factory EchoState.clear() => const EchoState();

  EchoState copyWith({
    Map<String, EchoModel>? echos,
    String? error,
    List<XFile>? images,
    EchoStatus? state,
    String? echo,
    Map<String, EchoModel>? replies,
    bool? allowChats,
  }) {
    return EchoState(
      replies: replies ?? this.replies,
      echo: echo ?? this.echo,
      echos: echos ?? this.echos,
      error: error ?? this.error,
      status: state ?? this.status,
      allowChats: allowChats ?? this.allowChats,
    );
  }

  bool get formValid => echo.trim().isNotEmpty;

  @override
  String toString() => status.name;
}
