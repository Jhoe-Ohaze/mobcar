import '../../../core/utils/typedefs.dart';
import 'car_brand_mapper.dart';

import '../../../core/entities/car_model_entity.dart';
import '../interfaces/entity_mapper.dart';

class CarModelMapper extends EntityMapper<CarModelEntity> {
  final _brandMapper = CarBrandMapper();

  @override
  CarModelEntity fromMap(DataMap map) {
    return CarModelEntity(
      id: map['code'],
      name: map['name'],
      brand: _brandMapper.fromMap(map['brand']),
    );
  }

  @override
  DataMap toMap(CarModelEntity entity) {
    return {
      'code': entity.id,
      'name': entity.name,
      'brand': _brandMapper.toMap(entity.brand),
    };
  }

  @override
  CarModelEntity fake() {
    throw UnimplementedError();
  }
}
