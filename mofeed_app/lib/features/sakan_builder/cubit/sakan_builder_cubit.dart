import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mofeduserpp/features/sakan/data/sakan_builder_storage.dart';
import 'package:mofeduserpp/features/sakan_builder/cubit/sakan_builder_state.dart';
import 'package:mofeduserpp/features/sakan_builder/cubit/sakan_builder_status.dart';
import 'package:mofeed_shared/constants/app_constants.dart';
import 'package:mofeed_shared/constants/const_methods.dart';
import 'package:mofeed_shared/constants/storage_const.dart';
import 'package:mofeed_shared/data/storage_repository.dart';
import 'package:mofeed_shared/model/app_address.dart';
import 'package:mofeed_shared/model/client_user_model.dart';
import 'package:mofeed_shared/utils/extensions/media_query_ext.dart';
import 'package:mofeed_shared/utils/mixins/validation_mixin.dart';
import 'package:sakan/model/mate_wanted.dart';
import 'package:sakan/model/room_wanted.dart';
import 'package:sakan/model/sakan_model.dart';
import 'package:sakan/utils/enums/common_enums.dart';
import 'package:sakan/utils/enums/room_enums.dart';
import 'package:uuid/uuid.dart';

import '../../sakan/data/sakan_repository_impl.dart';
import '../../signup/data/mofeed_auth_repository.dart';

class SakanBuilderCubit extends Cubit<SakanBuilderState> with ValidationMixin {
  SakanBuilderCubit({
    required StorageRepository storageRepository,
    required SakanRepository sakanRepository,
    required SakanBuilderStorage sakanBuilderStorage,
    required AuthRepository authRepository,
  })  : _storageRepository = storageRepository,
        _sakanRepository = sakanRepository,
        _sakanBuilderStorage = sakanBuilderStorage,
        _authRepository = authRepository,
        super(const SakanBuilderState());
  final SakanRepository _sakanRepository;
  final StorageRepository _storageRepository;
  final SakanBuilderStorage _sakanBuilderStorage;
  final AuthRepository _authRepository;

  void pikcupImages() async {
    final picked = await pickMultiImages();
    emit(state.copyWith(roomImages: picked));
  }

  void removeImage(int index) {
    final List<XFile> images = List.from(state.roomImages);
    images.removeAt(index);
    emit(state.copyWith(roomImages: images));
  }

  void formChanged({
    String? error,
    SakanType? sakanType,
    String? price,
    bool? privateBathRoom,
    bool? anyUniversity,
    BillingPeriod? billingPeriod,
    String? maxStay,
    String? minStay,
    double? budget,
    RoomRequestType? roomRequestType,
    List<RoomAmenity>? amenties,
    String? title,
    String? description,
    DateTime? availableFrom,
    String? phone,
    bool? isSingle,
    bool? inCompound,
    bool? isBillIncluded,
    int? floor,
    bool? showPhoneNumber,
    double? nearestServices,
    String? compound,
    double? meteres,
    int? currentRoomMates,
  }) {
    String? titleE;
    String? descE;

    if (title != null) {
      titleE = validateMinLength(25, title);
    }
    if (description != null) {
      descE = validateMinLength(50, description);
    }
    emit(
      state.copyWith(
        titleErorr: titleE,
        describitionError: descE,
        currentRoomMates: currentRoomMates,
        sakanType: sakanType,
        price: price,
        privateBathRoom: privateBathRoom,
        anyUniversity: anyUniversity,
        billingPeriod: billingPeriod,
        maxStay: maxStay,
        minStay: minStay,
        budget: budget,
        roomRequestType: roomRequestType,
        amenties: amenties,
        title: title,
        description: description,
        availableFrom: availableFrom,
        phone: phone,
        isSingle: isSingle,
        inCompound: inCompound,
        isBillIncluded: isBillIncluded,
        floor: floor,
        showPhoneNumber: showPhoneNumber,
        nearestServices: nearestServices,
        compound: compound,
        meteres: meteres,
      ),
    );
  }

  void pageChanged(int index) {
    emit(state.copyWith(pageIndex: index));
    saveCurrentState();
  }

  void addSakan() async {
    emitLoading();
    final user = await _authRepository.user.first;
    var id = const Uuid().v1();
    late final List<String> urls;
    if (state.mateWanted) {
      final imagesUrls = await _storageRepository.uploadMultiFiles(
          files: state.roomImages.map((e) => e.toFile).toList(),
          path: '${StorageConst.listings}/${user.uId}');
      imagesUrls.fold((l) => emitError(l.error), (r) => urls = r);
    } else {
      urls = [];
    }
    final sakan =
        buildSakan(user: user, id: id, roomImages: urls, cover: user.image);
    final addSakanRes = await _sakanRepository.addSakan(sakan);
    addSakanRes.fold((l) => emitError(l.error), (r) {
      emit(state.copyWith(state: SakanBuilderStatus.added, tempSakan: sakan));
    });
  }

  void addressChanged(AppAddress address) =>
      emit(state.copyWith(address: address));

  //TODO Add logic for builder design pattern for building the sakan class easily ,
  Sakan buildSakan({
    List<String> roomImages = const [],
    required String id,
    String cover = '',
    required ClientUser user,
  }) {
    final mateWanted = MateWanted(
      uniLng: 0,
      uniLat: 0,
      address: state.address ?? tempAddress,
      universityLogo: "",
      profilePic: user.image,
      universityName: const {},
      username: user.userName,
      pet: user.pet,
      religion: user.religion,
      gender: user.gender,
      smoking: user.smoking,
      amenties: state.amenties,
      privateBathRoom: state.privateBathRoom,
      anyUniversity: state.anyUniversity,
      price: double.parse(state.price),
      minStay: int.parse(state.minStay),
      maxStay: int.parse(state.maxStay),
      state: PostState.inReview,
      billingPeriod: state.billingPeriod,
      id: id,
      uniId: user.uniId,
      uid: user.uId,
      createdAt: DateTime.now(),
      title: state.title,
      description: state.description,
      availableFrom: DateTime.now(),
      roomImages: roomImages,
      showPhoneNo: state.showPhoneNumber,
      isBillIncluded: state.isBillIncluded,
      isSingle: state.isSingle,
      currentMates: state.currentRoomMates,
      phone: state.phone,
      nearestServices: state.nearestServices,
      metres: state.meteres,
      floor: state.floor,
    );

    final roomWanted = RoomWanted.fromMateWanted(
      mateWanted,
      cover: cover,
      requestType: state.roomRequestType,
    );

    if (state.sakanType == SakanType.mateWanted) {
      return mateWanted;
    }
    return roomWanted;
  }

  void pickAmenity(RoomAmenity amenity) {
    final List<RoomAmenity> currentAmenties = List.from(state.amenties);
    if (currentAmenties.contains(amenity)) {
      currentAmenties.remove(amenity);
    } else {
      currentAmenties.add(amenity);
    }
    emit(state.copyWith(amenties: currentAmenties));
  }

  void getLastCheckpoint() async {
    try {
      final state = await _sakanBuilderStorage.getSakanState();
      if (state == null) {
        return;
      }
      emit(state);
    } catch (e, st) {
      addError(e, st);
    }
  }

  void saveCurrentState() async {
    try {
      await _sakanBuilderStorage.saveSakanState(state);
    } catch (e, st) {
      addError(e, st);
    }
  }

  void emitInitial() => emit(state.copyWith(state: SakanBuilderStatus.initial));

  void emitLoading() => emit(state.copyWith(state: SakanBuilderStatus.loading));

  void emitError(String error, {StackTrace? st}) =>
      emit(state.copyWith(state: SakanBuilderStatus.error, error: error));

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    super.addError(error, stackTrace);
    testPrint(error, stackTrace);
  }
}
