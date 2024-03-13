import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeed_shared/model/university_model.dart';
import 'package:mofeed_shared/utils/mixins/validation_mixin.dart';
import '../data/mofeed_auth_repository.dart';
import 'auth_state.dart';

class SignUpCubit extends Cubit<SignUpState> with ValidationMixin {
  SignUpCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const SignUpState());

  final AuthRepository _authRepository;

  void universityInfoChanged(UniversityModel university) =>
      emit(state.copyWith(choosedUniversity: university));

  void changeVisibillity() =>
      emit(state.copyWith(isPassword: !state.isPassword));

  void formChanged({
    String? email,
    String? name,
    String? lastname,
    String? password,
  }) =>
      emit(state.copyWith(
        email: email,
        password: password,
        name: name,
        lastName: lastname,
      ));

  void createUser() async {
    emitLoading();

    final res = await _authRepository.createUserWithEmailAndPassword(
      email: state.uniEmail,
      password: state.password,
      uniId: state.choosedUniversity.id,
      lastName: state.lastName,
      phone: '',
      name: state.name,
    );
    res.fold(
      (l) {
        emit(state.copyWith(error: l.error, state: SignUpStatus.error));
      },
      (uid) {
        sendEmailVerification();
      },
    );
  }

  void sendEmailVerification() async {
    final res = await _authRepository.sendEmailVerfication();
    res.fold((l) => emitError(l.error), (r) {
      emit(state.copyWith(state: SignUpStatus.emailVerificationSent));
    });
  }

  void checkEmailverification() async {
    try {
      emitLoading();
      final vefi = await _authRepository.checkEmailVerified();
      if (vefi) {
        emit(state.copyWith(state: SignUpStatus.emailVerified));
      } else {
        emit(state.copyWith(state: SignUpStatus.emailNotVerified));
      }
    } catch (e, st) {
      emitError(e.toString(), st: st);
    }
  }

  emitLoading() => emit(state.copyWith(state: SignUpStatus.loading));

  emitError(String error, {StackTrace? st}) =>
      emit(state.copyWith(state: SignUpStatus.error, error: error));

  emitInitial() => emit(state.copyWith(state: SignUpStatus.initial));
}
