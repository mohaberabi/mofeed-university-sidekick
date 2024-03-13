import 'package:equatable/equatable.dart';
import 'package:food_court/model/food_option.dart';
import 'package:mofeed_shared/utils/enums/langauge_enum.dart';
import 'package:mofeed_shared/utils/typdefs/typedefs.dart';

class OptionGroup with Translatable, EquatableMixin {
  @override
  final MapJson name;
  final List<FoodOption> children;
  final String id;
  final int min;
  final int max;

  const OptionGroup({
    required this.name,
    required this.id,
    required this.min,
    required this.children,
    required this.max,
  });

  bool get isRequired => min > 0;

  bool get multiChoice => min > 1 || min == 0;

  factory OptionGroup.fromJson(Map<String, dynamic> map) {
    return OptionGroup(
      name: map['name'],
      min: map['min'] ?? 0,
      max: map['max'] ?? 0,
      id: map['id'],
      children:
          (map['children'] as List).map((e) => FoodOption.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'min': min,
      'max': max,
      'children': children.map((e) => e.toMap()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        name,
        id,
        min,
        max,
        children,
      ];

  OptionGroup copyWith({
    MapJson? name,
    List<FoodOption>? children,
    String? id,
    int? min,
    int? max,
  }) {
    return OptionGroup(
      name: name ?? this.name,
      children: children ?? this.children,
      id: id ?? this.id,
      min: min ?? this.min,
      max: max ?? this.max,
    );
  }

  static const OptionGroup empty =
      OptionGroup(name: {}, id: '', min: 0, children: [], max: 0);
}
