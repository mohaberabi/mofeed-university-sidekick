import 'package:bloc/bloc.dart';
import 'package:food_court/model/food_option.dart';
import 'package:food_court/model/option_group.dart';
import 'package:food_court/repository/food_option_repository.dart';
import 'package:mofeed_owner/features/option/cubit/option_state.dart';
import 'package:uuid/uuid.dart';

class OptionCubit extends Cubit<OptionState> {
  OptionCubit({
    required FoodOptionRepository foodOptionRepository,
  })  : _foodOptionRepository = foodOptionRepository,
        super(const OptionState());
  final FoodOptionRepository _foodOptionRepository;

  void optionGroupChanged(OptionGroup optionGroup) =>
      emit(state.copyWith(option: optionGroup));

  void addOption() async {
    emitLoading();
    final id = state.option.id.isEmpty ? const Uuid().v1() : state.option.id;
    final res =
        await _foodOptionRepository.addOption(state.option.copyWith(id: id));

    res.fold((l) => emitError(l.error, l.stackTrace),
        (r) => emit(state.copyWith(status: OptionStatus.add)));
  }

  void clearForm() => emit(state.copyWith(option: OptionGroup.empty));

  void getOptions() async {
    emitLoading();
    final res = await _foodOptionRepository.getOptions();
    res.fold(
        (l) => emitError(l.error),
        (r) =>
            emit(state.copyWith(status: OptionStatus.populated, options: r)));
  }

  void deleteOption(String id) async {
    emitLoading();
    final res = await _foodOptionRepository.deleteOption(id);
    res.fold((l) => emitError(l.error, l.stackTrace),
        (r) => emit(state.copyWith(status: OptionStatus.delete)));
  }

  void formChanged({
    String? min,
    String? max,
    String? ar,
    String? en,
  }) {
    emit(
      state.copyWith(
        option: state.option.copyWith(
          name: {
            "ar": ar ?? state.option.name['ar'],
            "en": en ?? state.option.name['en'],
          },
          min: int.parse(min ?? state.option.min.toString()),
          max: int.parse(min ?? state.option.max.toString()),
        ),
      ),
    );
  }

  void childChanged(
    int index, {
    String? ar,
    String? en,
    String? price,
  }) {
    final List<FoodOption> current = state.option.children;
    current[index] = current[index].copyWith(name: {
      "ar": ar ?? current[index].name['ar'],
      "en": ar ?? current[index].name['en'],
    }, price: double.parse(price ?? current[index].price.toStringAsFixed(2)));
    emit(state.copyWith(option: state.option.copyWith(children: current)));
  }

  void addChild() {
    const optionChild = FoodOption(
      name: {"ar": "", "en": ""},
      price: 0,
    );

    final options = List<FoodOption>.from(state.option.children);
    options.add(optionChild);
    emit(state.copyWith(option: state.option.copyWith(children: options)));
  }

  void removeChild(int index) {
    final options = List<FoodOption>.from(state.option.children);
    options.removeAt(index);
    emit(state.copyWith(option: state.option.copyWith(children: options)));
  }

  void emitLoading() => emit(state.copyWith(status: OptionStatus.loading));

  void emitInitial() => emit(state.copyWith(status: OptionStatus.initial));

  void emitError(String error, [StackTrace? st]) {
    emit(state.copyWith(status: OptionStatus.error, error: error));
    addError(error, st);
  }
}
