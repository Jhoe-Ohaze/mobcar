import '../../../../core/utils/datamap_typedef.dart';
import 'car_model_mapper.dart';

import '../../../../core/entities/car_year_entity.dart';
import '../interfaces/entity_mapper.dart';

class CarYearMapper extends EntityMapper<CarYearEntity> {
  final _modelMapper = CarModelMapper();

  @override
  CarYearEntity fromMap(DataMap map) {
    return CarYearEntity(
      id: map['code'],
      name: map['name'],
      model: _modelMapper.fromMap(map['model']),
    );
  }

  @override
  DataMap toMap(CarYearEntity entity) {
    return {
      'code': entity.id,
      'name': entity.name,
      'model': _modelMapper.toMap(entity.model),
    };
  }

  @override
  CarYearEntity fake() {
    throw UnimplementedError();
  }
}
