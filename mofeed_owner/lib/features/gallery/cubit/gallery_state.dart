import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mofeed_owner/features/gallery/model/gallery_model.dart';
import 'package:mofeed_shared/utils/enums/state_enum.dart';

class GalleryState extends Equatable {
  final String error;

  final List<GalleryModel> gallery;

  final CubitState state;
  final List<XFile> files;

  const GalleryState({
    this.error = '',
    this.state = CubitState.initial,
    this.gallery = const [],
    this.files = const [],
  });

  @override
  List<Object?> get props => [
        error,
        gallery,
        state,
        files,
      ];

  GalleryState copyWith({
    String? error,
    List<GalleryModel>? gallery,
    CubitState? state,
    List<XFile>? files,
  }) {
    return GalleryState(
      error: error ?? this.error,
      gallery: gallery ?? this.gallery,
      state: state ?? this.state,
      files: files ?? this.files,
    );
  }

  bool get readyUpload => files.isNotEmpty;
}
