import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/enums/media_source.dart';
import '../utils/enums/text_type.dart';
import 'message_model.dart';

class AppMedia extends Equatable {
  final String path;
  final String title;

  final MediaSource source;

  final TextType type;

  const AppMedia({
    required this.path,
    this.source = MediaSource.asset,
    this.type = TextType.image,
    this.title = '',
  });

  static const AppMedia empty = AppMedia(path: '', source: MediaSource.network);

  factory AppMedia.fromXfile(XFile xFile) {
    return AppMedia(path: xFile.path, source: MediaSource.local);
  }

  factory AppMedia.fromMessageModel(
    MessageModel message, {
    String Function(MessageModel)? titleBuilder,
  }) {
    return AppMedia(
      path: message.message,
      source: MediaSource.network,
      title: titleBuilder != null ? titleBuilder(message) : '',
    );
  }

  bool get isEmpty => this == empty;

  @override
  List<Object?> get props => [
        path,
        source,
        type,
      ];
}
