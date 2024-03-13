import 'package:bloc/bloc.dart';
import 'package:food_court/model/order_model.dart';
import 'package:food_court/repository/food_repository.dart';
import 'package:food_court/repository/order_repository.dart';
import 'package:mofeduserpp/features/cart/cubit/cart_cubit.dart';
import 'package:mofeduserpp/features/checkout/screens/checkout_screen.dart';
import 'package:mofeed_shared/model/university_model.dart';
import 'package:mofeed_shared/utils/enums/restarant.dart';
import 'package:mofeed_shared/utils/error/error_codes.dart';
import '../../cart/data/cart_repository.dart';
import '../../signup/data/mofeed_auth_repository.dart';
import '../../university/data/university_repository_impl.dart';
import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final UserOrderRepository _orderRepository;
  final UserFoodRepository _foodRepository;
  final CartCubit _cartCubit;
  final CartRepository _cartRepository;
  final UniversityRepository _universityRepository;
  final AuthRepository _authRepository;

  CheckoutCubit({
    required UserOrderRepository orderRepository,
    required UserFoodRepository foodRepository,
    required CartCubit cartCubit,
    required CartRepository cartRepository,
    required UniversityRepository universityRepository,
    required AuthRepository authRepository,
  })  : _cartCubit = cartCubit,
        _cartRepository = cartRepository,
        _foodRepository = foodRepository,
        _orderRepository = orderRepository,
        _authRepository = authRepository,
        _universityRepository = universityRepository,
        super(const CheckoutState());

  void init() async {
    try {
      emitLoading();
      final uni = await _universityRepository.getMyUniversity();
      emit(state.copyWith(university: uni));
      _collectCartData();
      _getRestaurant();
    } catch (e, st) {
      addError(e, st);
      emitError(e.toString());
    }
  }

  void _collectCartData() {
    emit(state.copyWith(cartTotal: _cartCubit.state.cart.cartTotal));
  }

  void _getRestaurant() async {
    try {
      final restaurantId = await _cartRepository.getTemporaryRestaurantId();
      if (restaurantId.isEmpty) {
        emitError(ErrorCodes.unKnownError);
        return;
      }
      final restaurantRes = await _foodRepository.getRestaurant(restaurantId);
      restaurantRes.fold(
          (l) => emitError(l.error),
          (rest) => emit(state.copyWith(
              restarant: rest, state: CheckoutStatus.populated)));
    } catch (e, st) {
      emitError(e.toString());
      addError(e, st);
    }
  }

  void timeChanged(DateTime? time) => emit(state.copyWith(time: time));

  void changeOrderMethod(OrderMethod method) =>
      emit(state.copyWith(method: method));

  void createOrder() async {
    emitLoading();
    final user = await _authRepository.user.first;
    final restaurant = state.restarant!;
    final items = _cartCubit.state.cart.items.values.toList();
    var id = DateTime.now().millisecondsSinceEpoch;
    final order = OrderModel(
      floor: state.floor,
      room: state.room,
      id: id.toString(),
      isDelivery: state.method == OrderMethod.handover,
      restaurantId: restaurant.id,
      universityId: state.university!.id,
      userId: user.uId,
      items: items,
      status: OrderStatus.sent,
      username: '${user.name} ${user.lastname}',
      phone: user.phone,
      orderTime: DateTime.now(),
      faculty: state.faculty,
      pickupTime: state.time!,
      cartTotal: state.cartTotal,
      discount: 0,
      lang: user.local.isEmpty ? 'en' : user.local,
      userToken: user.token,
      restaurantToken: restaurant.token,
      restaurantName: restaurant.name,
    );
    final res = await _orderRepository.createOrder(order: order);
    res.fold((l) => emitError(l.error, st: l.stackTrace), (orderNo) {
      emit(state.copyWith(
          state: CheckoutStatus.orderCreated, recentOrderId: orderNo));
      _cartCubit.clear();
    });
  }

  void chooseFaculty(FacultyModel faculty) =>
      emit(state.copyWith(faculty: faculty));

  void facultyFormChanged({String? floor, String? room}) =>
      emit(state.copyWith(floor: floor, room: room));

  void emitError(String error, {StackTrace? st}) =>
      emit(state.copyWith(state: CheckoutStatus.error, error: error));

  void emitInitial() => emit(state.copyWith(state: CheckoutStatus.initial));

  void emitLoading() => emit(state.copyWith(state: CheckoutStatus.loading));
}
