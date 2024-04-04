import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobcar/core/utils/typedefs.dart';

import '../../service/stations/interfaces/i_fipe_station.dart';
import '../entities/car_brand_entity.dart';
import '../entities/car_model_entity.dart';

class GetCarModelsUsecase {
  final _fipeService = Modular.get<IFipeStation>();

  AsyncIterable<CarModelEntity> call(
    CarBrandEntity brand,
  ) async {
    return await _fipeService.getCarModels(
      brand,
    );
  }
}
