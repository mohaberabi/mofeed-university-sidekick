import 'package:bloc/bloc.dart';
import 'package:mofeed_owner/features/mofeed/cubit/mofeed_state.dart';

class MofeedCubit extends Cubit<MofeedState> {
  MofeedCubit() : super(const MofeedState());

  void indexChanged(int index) => emit(state.copyWith(index: index));
}
