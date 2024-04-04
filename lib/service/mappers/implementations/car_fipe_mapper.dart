import 'dart:typed_data';

import '../../../core/entities/car_fipe_entity.dart';
import '../../../core/utils/typedefs.dart';
import '../interfaces/entity_mapper.dart';
import 'car_year_mapper.dart';

class CarFipeMapper extends EntityMapper<CarFipeEntity> {
  final _yearMapper = CarYearMapper();

  @override
  CarFipeEntity fromMap(DataMap map) {
    return CarFipeEntity(
      id: map['id'],
      code: map['codeFipe'],
      fipe: map['price'],
      image: map['image'] != null ? Uint8List.fromList(map['image']) : null,
      year: _yearMapper.fromMap(map['year']),
    );
  }

  @override
  DataMap toMap(CarFipeEntity entity) {
    return {
      'id': entity.id,
      'codeFipe': entity.code,
      'price': entity.fipe,
      'image': entity.image?.toString(),
      'year': _yearMapper.toMap(entity.year),
    };
  }

  @override
  CarFipeEntity fake() {
    throw UnimplementedError();
  }
}
