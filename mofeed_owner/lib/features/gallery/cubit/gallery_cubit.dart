import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mofeed_owner/features/gallery/cubit/gallery_state.dart';
import 'package:mofeed_owner/features/gallery/model/gallery_model.dart';
import 'package:mofeed_shared/constants/fireabse_constants.dart';
import 'package:mofeed_shared/data/storage_repository.dart';
import 'package:mofeed_shared/utils/const_methods.dart';
import 'package:mofeed_shared/utils/enums/state_enum.dart';
import 'package:mofeed_shared/utils/extensions/media_query_ext.dart';
import 'package:mofeed_shared/utils/mixins/cubitEmitter.dart';

import '../repository/gallery_repository.dart';

class GalleryCubit extends Cubit<GalleryState> with CubitEmiiter {
  final GalleryRepository _galleryRepository;
  final StorageRepository _storageReposiotry;

  GalleryCubit({
    required GalleryRepository galleryRepository,
    required StorageRepository storageRepository,
  })  : _galleryRepository = galleryRepository,
        _storageReposiotry = storageRepository,
        super(const GalleryState());

  void pickImages() async {
    final picked = await pickMultiImages();
    emit(state.copyWith(files: [...state.files, ...picked]));
  }

  void clearImages() => emit(state.copyWith(files: []));

  void getGallery() async {
    emitLoading();
    final res = await _galleryRepository.getGallery();
    res.fold((l) => emitError(l.error, st: l.stackTrace),
        (r) => emit(state.copyWith(gallery: r, state: CubitState.done)));
  }

  void uploadImages() async {
    emitLoading();
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final path = "${FirebaseConst.restaurants}/$uid/${FirebaseConst.galelry}";
    final storageRes = await _storageReposiotry.uploadMultiFiles(
        files: state.files.map((e) => e.toFile).toList(), path: path);
    storageRes.fold((l) => emitError(l.error, st: l.stackTrace), (urls) async {
      final galleries = urls
          .map((e) => GalleryModel(
              name: '',
              url: e,
              id: DateTime.now().millisecondsSinceEpoch.toString()))
          .toList();
      final galRes = await _galleryRepository.addGallery(galleries);
      galRes.fold(
          (l) => emitError(l.error, st: l.stackTrace), (r) => emitDone());
    });
  }

  @override
  void emitDone() => emit(state.copyWith(state: CubitState.done));

  @override
  void emitError(String error, {StackTrace? st}) {
    emit(state.copyWith(state: CubitState.done));
    addError(error, st);
  }

  @override
  void emitInitial() => emit(state.copyWith(state: CubitState.initial));

  @override
  void emitLoading() => emit(state.copyWith(state: CubitState.loading));
}
