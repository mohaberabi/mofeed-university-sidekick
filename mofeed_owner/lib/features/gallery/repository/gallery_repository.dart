import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:mofeed_owner/features/auth/data/user_storage.dart';
import 'package:mofeed_owner/features/gallery/model/gallery_model.dart';
import 'package:mofeed_shared/constants/fireabse_constants.dart';
import 'package:mofeed_shared/data/network_info.dart';
import 'package:mofeed_shared/error/error_codes.dart';
import 'package:mofeed_shared/error/failure.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

abstract class GalleryRepository {
  FutureVoid addGallery(List<GalleryModel> galleries);

  FutureVoid removeGallery(String id);

  FutureEither<List<GalleryModel>> getGallery();
}

class GalleryReposiotryImpl implements GalleryRepository {
  final FirebaseFirestore _firestore;
  final NetWorkInfo _netWorkInfo;

  final AuthStorage _storage;

  const GalleryReposiotryImpl({
    required FirebaseFirestore firestore,
    required NetWorkInfo netWorkInfo,
    required AuthStorage storage,
  })  : _storage = storage,
        _netWorkInfo = netWorkInfo,
        _firestore = firestore;

  @override
  FutureVoid addGallery(List<GalleryModel> galleries) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final batch = _firestore.batch();
        final uid = await _storage.getUid();

        for (final gallery in galleries) {
          batch.set(
              _restruants
                  .doc(uid)
                  .collection(FirebaseConst.galelry)
                  .doc(gallery.id),
              gallery.toMap());
        }

        await batch.commit();
        return const Right(unit);
      }
    } on FirebaseException catch (e, st) {
      return Left(Failure(e.mapCodeToError, st));
    }
  }

  @override
  FutureEither<List<GalleryModel>> getGallery() async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final uid = await _storage.getUid();
        final gallery = await _restruants
            .doc(uid)
            .collection(FirebaseConst.galelry)
            .get()
            .then((value) =>
                value.docs.map((e) => GalleryModel.fromMap(e.data())).toList());
        return Right(gallery);
      }
    } on FirebaseException catch (e, st) {
      return Left(Failure(e.mapCodeToError, st));
    }
  }

  @override
  FutureVoid removeGallery(String id) async {
    try {
      if (!await _netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final uid = await _storage.getUid();
        await _restruants
            .doc(uid)
            .collection(FirebaseConst.galelry)
            .doc(id)
            .delete();
        return const Right(unit);
      }
    } on FirebaseException catch (e, st) {
      return Left(Failure(e.mapCodeToError, st));
    }
  }

  CollectionReference<MapJson> get _restruants =>
      _firestore.collection(FirebaseConst.restaurants);
}
