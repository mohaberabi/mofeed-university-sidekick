import 'package:bloc/bloc.dart';
import 'package:mofeduserpp/features/sakan/cubit/sakan_cubit/sakan_state.dart';
import 'package:mofeduserpp/features/university/data/university_repository_impl.dart';
import 'package:mofeed_shared/constants/app_constants.dart';
import 'package:sakan/model/sakan_model.dart';
import 'package:sakan/utils/enums/common_enums.dart';
import 'package:sakan/utils/enums/room_enums.dart';

import '../../../signup/data/mofeed_auth_repository.dart';
import '../../data/sakan_repository_impl.dart';

class SakanCubit extends Cubit<SakanState> {
  SakanCubit({
    required SakanRepository sakanRepository,
    required AuthRepository authRepository,
    required UniversityRepository universityRepository,
  })  : _sakanRepository = sakanRepository,
        _authRepository = authRepository,
        _universityRepository = universityRepository,
        super(const SakanState()) {
    _loadMyUniversity();
  }

  final AuthRepository _authRepository;
  final UniversityRepository _universityRepository;
  final SakanRepository _sakanRepository;

  void emitLoading() => emit(state.copyWith(state: SakanStatus.loading));

  void emitError(String error, {StackTrace? st}) {
    emit(state.copyWith(state: SakanStatus.error, error: error));
    addError(error, st);
    testPrint(error, st);
  }

  void typeChanged(
    SakanType type, {
    bool getMine = false,
  }) {
    if (type == state.sakanType) {
      return;
    }
    emit(state.copyWith(sakanType: type, sakans: const {}));
    getSakans(
      type: type,
      getMine: getMine,
    );
  }

  void addAmenity(RoomAmenity amenity) {
    final updated = List<RoomAmenity>.from(state.amenities ?? <RoomAmenity>[]);
    if (updated.contains(amenity)) {
      updated.remove(amenity);
    } else {
      updated.add(amenity);
    }
    emit(state.copyWith(amenities: updated));
  }

  void clearFilters() {
    final Map<String, Sakan> sakans = state.sakans;
    final type = state.sakanType;
    emit(
      SakanState(
        sakanType: type,
        sakans: sakans,
        state: SakanStatus.populated,
      ),
    );
  }

  void _loadMyUniversity() async {
    try {
      final uni = await _universityRepository.getMyUniversity();
      emit(state.copyWith(myUniversity: uni));
    } catch (e, st) {
      addError(e, st);
    }
  }

  void getSakans({
    bool loadBefore = true,
    bool clearBefore = true,
    SakanType type = SakanType.roomWanted,
    bool getMine = false,
  }) async {
    if (loadBefore) {
      emitLoading();
    }
    if (clearBefore) {
      emit(state.copyWith(sakans: const {}));
    }

    final user = await _authRepository.user.first;
    final res = await _sakanRepository.getSakans(
        uid: getMine ? user.uId : null,
        type: type,
        amenities: state.amenities?.map((e) => e.name).toList(),
        isSingle: state.isSingle,
        billIncluded: state.billIncluded,
        privateBathRoom: state.privateBathRoom,
        currentMates: state.currentMates,
        billingPeriod: state.period?.name,
        floor: state.floor,
        lastDocId: state.sakans.isEmpty ? null : state.sakans.values.last.id);
    res.fold(
        (l) => emitError(l.error, st: l.stackTrace),
        (sakans) => emit(state.copyWith(sakans: {
              ...state.sakans,
              for (final sakan in sakans) sakan.id: sakan
            }, state: SakanStatus.populated)));
  }

  void formChanged({
    bool? billIncluded,
    bool? isSingle,
    bool? privateBathRoom,
    BillingPeriod? period,
  }) {
    emit(
      state.copyWith(
        privateBathRoom: privateBathRoom,
        isSingle: isSingle,
        billIncluded: billIncluded,
        period: period,
      ),
    );
  }

  void deleteSakan(Sakan sakan) async {
    emitLoading();
    final res = await _sakanRepository.deleteSakan(sakan.id);
    res.fold(
      (l) => emitError(l.error),
      (r) {
        emit(state.copyWith(
            state: SakanStatus.deleted,
            sakans: {...state.sakans}..remove(sakan.id)));
      },
    );
  }

  void addBuildedSakanToCurrentSakans(Sakan sakan) {
    emit(state.copyWith(
        sakans: {...state.sakans}..putIfAbsent(sakan.id, () => sakan)));
  }

  void emitInitial() => emit(state.copyWith(state: SakanStatus.initial));
}
