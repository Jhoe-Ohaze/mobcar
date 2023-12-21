import '../../../core/entities/car_brand_entity.dart';
import '../../../core/utils/datamap_typedef.dart';
import '../interfaces/entity_mapper.dart';

class CarBrandMapper extends EntityMapper<CarBrandEntity> {
  @override
  CarBrandEntity fromMap(DataMap map) {
    return CarBrandEntity(
      id: map['code'], 
      name: map['name'],
    );
  }

  @override
  DataMap toMap(CarBrandEntity entity) {
    return {
      'code': entity.id,
      'name': entity.name,
    };
  }
  
  @override
  CarBrandEntity fake() {
    throw UnimplementedError();
  }
}