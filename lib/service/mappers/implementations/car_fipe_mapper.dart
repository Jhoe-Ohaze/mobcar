import 'dart:convert';
import 'dart:typed_data';

import '../../../core/entities/car_fipe_entity.dart';
import '../../../core/utils/typedefs.dart';
import '../interfaces/entity_mapper.dart';
import 'car_year_mapper.dart';

class CarFipeMapper extends EntityMapper<CarFipeEntity> {
  final _yearMapper = CarYearMapper();

  @override
  CarFipeEntity fromMap(DataMap map) {
    final imageString = map['image'];
    Uint8List? image;

    if (imageString is String) {
      final list = jsonDecode(imageString) as List;
      final intIter = list.map<int>((e) => e);
      image = Uint8List.fromList(intIter.toList());
    }

    return CarFipeEntity(
      id: map['id'],
      code: map['codeFipe'],
      fipe: map['price'],
      image: image,
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
