import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/entities/car_brand_entity.dart';
import '../../../core/entities/car_fipe_entity.dart';
import '../../../core/entities/car_model_entity.dart';
import '../../../core/entities/car_year_entity.dart';
import '../../terminals/interfaces/i_fipe_terminal.dart';
import '../interfaces/i_fipe_station.dart';

class FipeRestStation implements IFipeStation {
  final _terminal = Modular.get<IFipeTerminal>();

  @override
  Future<Iterable<CarBrandEntity>> getCarBrands() {
    return _terminal.getCarBrands();
  }

  @override
  Future<Iterable<CarModelEntity>> getCarModels(
      {required CarBrandEntity brand}) {
    return _terminal.getCarModels(brand: brand);
  }

  @override
  Future<Iterable<CarYearEntity>> getCarYears({required CarModelEntity model}) {
    return _terminal.getCarYears(model: model);
  }

  @override
  Future<CarFipeEntity> getCarFipe({required CarYearEntity year}) {
    return _terminal.getCarFipe(year: year);
  }
}
