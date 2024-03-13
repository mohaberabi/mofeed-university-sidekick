import 'package:equatable/equatable.dart';
import 'package:mofeed_shared/model/app_media.dart';
import 'package:mofeed_shared/model/client_user_model.dart';

enum ProfileStatus {
  initial,
  loading,
  error,
  galleryDenied,
  updated;

  bool get isInitial => this == ProfileStatus.initial;

  bool get isLoading => this == ProfileStatus.loading;

  bool get isError => this == ProfileStatus.error;

  bool get isGalleryDenied => this == ProfileStatus.galleryDenied;

  bool get isUpdated => this == ProfileStatus.updated;
}

class ProfileState extends Equatable {
  final ClientUser user;
  final AppMedia profilePic;
  final ProfileStatus state;
  final String error;

  const ProfileState({
    this.user = ClientUser.anonymus,
    this.profilePic = AppMedia.empty,
    this.state = ProfileStatus.initial,
    this.error = '',
  });

  ProfileState copyWith({
    ClientUser? user,
    AppMedia? profilePic,
    ProfileStatus? state,
    String? error,
  }) {
    return ProfileState(
      error: error ?? this.error,
      profilePic: profilePic ?? this.profilePic,
      user: user ?? this.user,
      state: state ?? this.state,
    );
  }

  bool get canUpdateAccount =>
      user.image.isNotEmpty &&
      user.name.trim().isNotEmpty &&
      user.lastname.trim().isNotEmpty &&
      isMetaDataValid;

  bool get isMetaDataValid =>
      !user.religion.isNa && !user.gender.isNa && !user.pet.isNa;

  @override
  List<Object?> get props => [
        user,
        profilePic,
        state,
        error,
      ];

  @override
  String toString() => state.name;
}
