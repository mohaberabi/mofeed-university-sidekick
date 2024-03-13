import 'package:bloc/bloc.dart';
import 'package:mofeduserpp/app/data/app_storage.dart';

import 'mofeed_state.dart';

class MofeedCubit extends Cubit<MofeedState> {
  final AppStorage _appStorage;

  MofeedCubit({required AppStorage appStorage})
      : _appStorage = appStorage,
        super(const MofeedState());

  void seeOnBoarding() async {
    try {
      await _appStorage.saveOnBoarding();
    } catch (e, st) {
      addError(e, st);
    }
  }

  void indexChanged(int index) => emit(state.copyWith(index: index));
}
