import 'package:mobcar/core/entities/car_brand_entity.dart';
import 'package:mobcar/core/entities/car_model_entity.dart';

import 'car_attribute_entity.dart';

class CarYearEntity extends CarAttributeEntity {
  final CarModelEntity model;

  const CarYearEntity({
    required super.id,
    required super.name,
    required this.model,
  });

  CarBrandEntity get brand => model.brand;

  @override
  List<Object?> get props => [
        ...super.props,
        model,
      ];
}
