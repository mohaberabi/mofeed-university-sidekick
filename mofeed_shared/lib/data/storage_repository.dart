import 'dart:io';
import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mofeed_shared/utils/error/error_codes.dart';
import '../utils/error/failure.dart';
import '../utils/typdefs/typedefs.dart';
import 'network_info.dart';

abstract class StorageRepository {
  FutureEither<List<String>> uploadMultiFiles({
    required List<File> files,
    required String path,
  });

  FutureEither<String> uploadFile({
    required File file,
    required String path,
  });

  FutureEither<Uint8List?> getAndDonwloadFile(String filePath);

  FutureVoid delete(String ref, {bool isSingleFile = false});

  FutureEither<String> getFileUrl(String path);
}

class StorageRepositoryImpl implements StorageRepository {
  final FirebaseStorage storage;
  final NetWorkInfo netWorkInfo;

  const StorageRepositoryImpl({
    required this.storage,
    required this.netWorkInfo,
  });

  @override
  FutureEither<String> uploadFile(
      {required File file, required String path}) async {
    try {
      if (!await netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final refrence = storage.ref("$path/$fileName");
        final uploadTask = await refrence.putFile(file);
        final url = await uploadTask.ref.getDownloadURL();
        return Right(url);
      }
    } on FirebaseException catch (e, st) {
      return Left(Failure(e.mapCodeToError, st));
    }
  }

  @override
  FutureEither<List<String>> uploadMultiFiles({
    required List<File> files,
    required String path,
  }) async {
    try {
      if (!await netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final List<String> uploadedImageUrls = [];
        for (final file in files) {
          var fileName = DateTime.now().millisecondsSinceEpoch.toString();
          final reference = storage.ref("$path/$fileName");
          final uploadTask = reference.putFile(file);
          final snapshot = await uploadTask;
          if (snapshot.state == TaskState.success) {
            final downloadUrl = await snapshot.ref.getDownloadURL();
            uploadedImageUrls.add(downloadUrl);
          }
        }
        return Right(uploadedImageUrls);
      }
    } on FirebaseException catch (e, st) {
      return Left(Failure(e.mapCodeToError, st));
    }
  }

  @override
  FutureVoid delete(String ref, {bool isSingleFile = false}) async {
    try {
      if (!await netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final folderRef = storage.ref(ref);
        if (isSingleFile) {
          await folderRef.delete();
        } else {
          final result = await folderRef.listAll();
          for (final item in result.items) {
            await item.delete();
          }
        }
      }
      return const Right(unit);
    } on FirebaseException catch (e, st) {
      return Left(Failure(e.mapCodeToError, st));
    }
  }

  @override
  FutureEither<String> getFileUrl(String path) async {
    try {
      final url = await storage.ref(path).getDownloadURL();
      return Right(url);
    } on FirebaseException catch (e, st) {
      return Left(Failure(e.mapCodeToError, st));
    }
  }

  @override
  FutureEither<Uint8List?> getAndDonwloadFile(String filePath) async {
    try {
      if (!await netWorkInfo.isConnected) {
        return const Left(netWorkFailure);
      } else {
        final downloadedFile = await storage.ref(filePath).getData();
        if (downloadedFile != null) {
          return Right(downloadedFile);
        } else {
          return const Left(Failure(ErrorCodes.unKnownError));
        }
      }
    } on FirebaseException catch (e, st) {
      return Left(Failure(e.mapCodeToError, st));
    } catch (e, st) {
      return Left(Failure("No object found at this refrence", st));
    }
  }
}
