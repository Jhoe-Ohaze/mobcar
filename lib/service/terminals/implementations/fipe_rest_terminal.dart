import 'dart:convert';

import 'package:http/http.dart';

import '../../../core/entities/car_brand_entity.dart';
import '../../../core/entities/car_fipe_entity.dart';
import '../../../core/entities/car_model_entity.dart';
import '../../../core/entities/car_year_entity.dart';
import '../../../core/utils/datamap_typedef.dart';
import '../../mappers/implementations/car_brand_mapper.dart';
import '../../mappers/implementations/car_fipe_mapper.dart';
import '../../mappers/implementations/car_model_mapper.dart';
import '../../mappers/implementations/car_year_mapper.dart';
import '../interfaces/i_fipe_terminal.dart';

class FipeRestTerminal implements IFipeTerminal {
  final _baseURL = 'https://parallelum.com.br/fipe/api/v2/cars/brands';

  Future<Response> requestModels({required String manufacturer}) {
    return get(Uri.parse('$_baseURL/$manufacturer/modelos'));
  }

  @override
  Future<Iterable<CarBrandEntity>> getCarBrands() async {
    final response = await get(Uri.parse(_baseURL));
    final iter = jsonDecode(response.body) as Iterable;

    final mapIter = Iterable<Map<String, dynamic>>.generate(
      iter.length,
      (index) {
        final Map map = iter.elementAt(index);
        return map.map((key, value) => MapEntry(key, value));
      },
    );

    final convertedMap = mapIter.map(
      (map) => CarBrandMapper().fromMap(map),
    );

    return convertedMap;
  }

  @override
  Future<Iterable<CarModelEntity>> getCarModels(
      {required CarBrandEntity brand}) async {
    final brandId = brand.id;
    final brandMap = {'brand': CarBrandMapper().toMap(brand)};

    final response = await get(Uri.parse('$_baseURL/$brandId/models'));
    final iter = jsonDecode(response.body) as Iterable;

    final mapIter = Iterable<Map<String, dynamic>>.generate(
      iter.length,
      (index) {
        final Map map = iter.elementAt(index);
        return map.map((key, value) => MapEntry(key, value));
      },
    );

    final convertedMap = mapIter.map((map) {
      map.addAll(brandMap);
      return CarModelMapper().fromMap(map);
    });

    return convertedMap.toList();
  }

  @override
  Future<Iterable<CarYearEntity>> getCarYears(
      {required CarModelEntity model}) async {
    final brandId = model.brand.id;
    final modelId = model.id;
    final modelMap = {'model': CarModelMapper().toMap(model)};

    final response =
        await get(Uri.parse('$_baseURL/$brandId/models/$modelId/years'));
    final iter = jsonDecode(response.body) as Iterable;

    final mapIter = Iterable<Map<String, dynamic>>.generate(
      iter.length,
      (index) {
        final Map map = iter.elementAt(index);
        return map.map((key, value) => MapEntry(key, value));
      },
    );

    final convertedMap = mapIter.map((map) {
      map.addAll(modelMap);
      return CarYearMapper().fromMap(map);
    });

    return convertedMap.toList();
  }

  @override
  Future<CarFipeEntity> getCarFipe({required CarYearEntity year}) async {
    final brandId = year.model.brand.id;
    final modelId = year.model.id;
    final yearId = year.id;
    final yearMap = {'year': CarYearMapper().toMap(year)};

    final response = await get(
        Uri.parse('$_baseURL/$brandId/models/$modelId/years/$yearId'));
    final map = jsonDecode(response.body) as DataMap;

    map.addAll(yearMap);
    final convertedMap = CarFipeMapper().fromMap(map);

    return convertedMap;
  }
}
