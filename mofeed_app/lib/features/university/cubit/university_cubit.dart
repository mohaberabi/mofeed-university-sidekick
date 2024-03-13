import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/university/cubit/university_state.dart';
import 'package:mofeed_shared/utils/enums/state_enum.dart';

import '../data/university_repository_impl.dart';

class UniversityCubit extends Cubit<UniversityState> {
  UniversityCubit({
    required UniversityRepository universityRepository,
  })  : _universityRepository = universityRepository,
        super(const UniversityState());

  final UniversityRepository _universityRepository;

  void getMyUni() async {
    try {
      emitLoading();
      final uni = await _universityRepository.getMyUniversity();
      emit(state.copyWith(myUniversity: uni, state: CubitState.done));
    } catch (e, st) {
      emitError(e.toString(), st: st);
    }
  }

  void getAllUniversites() async {
    try {
      emitLoading();
      final unis = await _universityRepository.getAllUniversities();
      emit(state.copyWith(unis: unis, state: CubitState.done));
    } catch (e, st) {
      emitError(e.toString(), st: st);
    }
  }

  void emitLoading() => emit(state.copyWith(state: CubitState.loading));

  void emitDone() => emit(state.copyWith(state: CubitState.done));

  void emitError(String erorr, {StackTrace? st}) =>
      emit(state.copyWith(state: CubitState.error, error: erorr));

  void emitInitial() => emit(state.copyWith(state: CubitState.initial));
}
