import 'car_attribute_entity.dart';
import 'car_brand_entity.dart';

class CarModelEntity extends CarAttributeEntity {
  final CarBrandEntity brand;

  const CarModelEntity({
    required super.id,                                   
    required super.name, 
    required this.brand,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    brand,
  ];
}