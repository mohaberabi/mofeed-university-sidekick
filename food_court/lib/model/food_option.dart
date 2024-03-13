import 'package:equatable/equatable.dart';
import 'package:mofeed_shared/utils/enums/langauge_enum.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

class FoodOption with Translatable, EquatableMixin {
  @override
  final MapJson name;
  final double price;

  const FoodOption({
    required this.name,
    required this.price,
  });

  factory FoodOption.fromJson(Map<String, dynamic> map) {
    return FoodOption(
      name: map['name'],
      price: map['price'].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
    };
  }

  FoodOption copyWith({
    MapJson? name,
    double? price,
  }) {
    return FoodOption(
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  @override
  List<Object?> get props => [price, name];
}
