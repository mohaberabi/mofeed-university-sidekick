import 'package:equatable/equatable.dart';
import 'package:food_court/model/restaurant_model.dart';
import 'package:mofeduserpp/features/checkout/screens/checkout_screen.dart';
import 'package:mofeed_shared/model/university_model.dart';

enum CheckoutStatus {
  initial,
  loading,
  error,
  populated,
  orderCreated;
}

class CheckoutState extends Equatable {
  final String error;
  final CheckoutStatus state;
  final RestarantModel? restarant;
  final double cartTotal;
  final UniversityModel? university;
  final OrderMethod method;
  final String floor;
  final FacultyModel? faculty;
  final String room;
  final DateTime? time;
  final String recentOrderId;

  const CheckoutState({
    this.error = '',
    this.cartTotal = 0.0,
    this.state = CheckoutStatus.initial,
    this.restarant,
    this.university,
    this.method = OrderMethod.pickup,
    this.floor = '',
    this.room = '',
    this.faculty,
    this.time,
    this.recentOrderId = '',
  });

  CheckoutState copyWith({
    String? error,
    CheckoutStatus? state,
    RestarantModel? restarant,
    double? cartTotal,
    UniversityModel? university,
    OrderMethod? method,
    String? floor,
    String? room,
    FacultyModel? faculty,
    DateTime? time,
    String? recentOrderId,
  }) {
    return CheckoutState(
      recentOrderId: recentOrderId ?? this.recentOrderId,
      time: time ?? this.time,
      faculty: faculty ?? this.faculty,
      floor: floor ?? this.floor,
      room: room ?? this.room,
      method: method ?? this.method,
      university: university ?? this.university,
      error: error ?? this.error,
      state: state ?? this.state,
      restarant: restarant ?? this.restarant,
      cartTotal: cartTotal ?? this.cartTotal,
    );
  }

  @override
  List<Object?> get props => [
        error,
        state,
        restarant,
        cartTotal,
        university,
        method,
        room,
        floor,
        faculty,
        time,
        recentOrderId,
      ];

  @override
  String toString() => state.name;

  bool get readyToOrder =>
      restarant != null &&
      university != null &&
      time != null &&
      facultyFormValid;

  bool get facultyFormValid {
    if (method == OrderMethod.pickup) {
      return true;
    }
    return faculty != null && floor.isNotEmpty && room.isNotEmpty;
  }

  double get deliveryFees {
    if (method == OrderMethod.pickup) {
      return 0.0;
    }
    if (restarant == null) {
      return 0;
    }
    return restarant!.fees;
  }

  double get grandTotal => cartTotal + deliveryFees;
}
