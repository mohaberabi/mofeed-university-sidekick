import 'package:mofeed_shared/utils/enums/langauge_enum.dart';

enum TextType with CustomEnum {
  gif("Gif", ""),
  text("", ""),
  video("video 📹", "📹فيديو"),
  image("Photo 🖼", " 🖼 صورة"),
  audio("Audio 🎤️", "🎤️ رسالة صوتية"),
  link("Link", "");

  bool get isGif => this == TextType.gif;

  bool get isText => this == TextType.text;

  bool get isVideo => this == TextType.video;

  bool get isImage => this == TextType.image;

  bool get isAudio => this == TextType.audio;

  bool get isLink => this == TextType.link;

  @override
  final String ar;

  @override
  final String en;

  const TextType(this.en, this.ar);
}
