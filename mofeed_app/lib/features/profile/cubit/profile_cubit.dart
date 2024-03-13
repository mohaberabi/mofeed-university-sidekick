import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:mofeduserpp/features/profile/cubit/profile_state.dart';
import 'package:mofeed_shared/clients/image_picker_client/image_picker_client.dart';
import 'package:mofeed_shared/data/storage_repository.dart';
import 'package:mofeed_shared/model/app_media.dart';
import 'package:mofeed_shared/model/client_user_model.dart';
import 'package:mofeed_shared/utils/enums/media_source.dart';
import 'package:mofeed_shared/utils/enums/user_prefs.dart';

import '../../signup/data/mofeed_auth_repository.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthRepository _authRepository;
  final StorageRepository _storageRepository;
  final ImagePickerClient _imagePickerClient;

  ProfileCubit({
    required AuthRepository authRepository,
    required StorageRepository storageRepository,
    required ImagePickerClient imagePickerClient,
  })  : _authRepository = authRepository,
        _imagePickerClient = imagePickerClient,
        _storageRepository = storageRepository,
        super(const ProfileState()) {
    listenYoUserUpdates();
  }

  void listenYoUserUpdates() =>
      _userStream = _authRepository.user.handleError((e, st) {
        addError((e, st) {
          addError((e, st));
        });
      }).listen((client) {
        emit(state.copyWith(user: client));
      });

  void pickupImage() async {
    try {
      emit(state.copyWith(state: ProfileStatus.loading));
      final picked = await _imagePickerClient.pickUpImage();
      if (picked != null) {
        emit(state.copyWith(
            profilePic: AppMedia(path: picked.path, source: MediaSource.local),
            state: ProfileStatus.initial));
      }
    } catch (e, st) {
      emit(state.copyWith(state: ProfileStatus.galleryDenied));
    }
  }

  void changeProfilePic() async {
    emit(state.copyWith(state: ProfileStatus.loading));
    final res = await _storageRepository.uploadFile(
        file: File(state.profilePic.path), path: '${state.user.uId}/profile');
    res.fold((l) => emit(state.copyWith(state: ProfileStatus.error)),
        (url) async {
      final updateRes =
          await _authRepository.updateUser(state.user.copyWith(image: url));
      updateRes.fold(
          (l) => emit(state.copyWith(
              state: ProfileStatus.error,
              error: l.error,
              user: state.user.copyWith(image: url))),
          (r) => emit(state.copyWith(state: ProfileStatus.updated)));
    });
  }

  void updateProfile() async {
    emit(state.copyWith(state: ProfileStatus.loading));
    final res = await _authRepository.updateUser(state.user);
    res.fold((l) {
      emit(state.copyWith(state: ProfileStatus.error, error: l.error));
    }, (r) => emit(state.copyWith(state: ProfileStatus.updated)));
  }

  void formChanged({
    Pet? pet,
    Religion? religion,
    Gender? gender,
    Smoking? smoking,
    String? bio,
    String? name,
    String? lastname,
    String? phone,
  }) {
    emit(
      state.copyWith(
        user: state.user.copyWith(
          pet: pet,
          bio: bio,
          religion: religion,
          name: name,
          lastname: lastname,
          phone: phone,
          gender: gender,
          smoking: smoking,
        ),
      ),
    );
  }

  late StreamSubscription<ClientUser> _userStream;

  @override
  Future<void> close() {
    _userStream.cancel();
    return super.close();
  }
}
