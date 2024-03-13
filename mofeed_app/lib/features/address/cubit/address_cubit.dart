import 'package:bloc/bloc.dart';
import 'package:mofeduserpp/features/address/cubit/address_state.dart';
import 'package:mofeduserpp/features/address/repository/adddress_repository.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit({
    required AddressRepository addressRepository,
  })
      : _addressRepository = addressRepository,
        super(const AddressState());

  final AddressRepository _addressRepository;


  void clear() => emit(const AddressState());

  void queryChanged(String q) => emit(state.copyWith(query: q));

  void getAddresess() async {
    try {
      emit(state.copyWith(state: AddressStatus.loading));
      final address = await _addressRepository.getAddress(state.query);
      emit(state.copyWith(addresses: address, state: AddressStatus.populated));
    } catch (e, st) {
      emit(state.copyWith(state: AddressStatus.error, error: e.toString()));
    }
  }
}
