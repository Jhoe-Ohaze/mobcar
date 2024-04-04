import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/entities/car_brand_entity.dart';
import '../../../core/entities/car_fipe_entity.dart';
import '../../../core/entities/car_model_entity.dart';
import '../../../core/entities/car_year_entity.dart';
import '../../../core/utils/typedefs.dart';
import '../../terminals/interfaces/i_fipe_terminal.dart';
import '../interfaces/i_fipe_station.dart';

class FipeRestStation implements IFipeStation {
  final _terminal = Modular.get<IFipeTerminal>();

  @override
  AsyncIterable<CarBrandEntity> getCarBrands() {
    return _terminal.getCarBrands();
  }

  @override
  AsyncIterable<CarModelEntity> getCarModels(
    CarBrandEntity brand,
  ) {
    return _terminal.getCarModels(brand);
  }

  @override
  AsyncIterable<CarYearEntity> getCarYears(
    CarModelEntity model,
  ) {
    return _terminal.getCarYears(model);
  }

  @override
  Future<CarFipeEntity> getCarFipe(CarYearEntity year) {
    return _terminal.getCarFipe(year);
  }
}
