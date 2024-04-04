import 'package:flutter_modular/flutter_modular.dart';

import '../../service/stations/interfaces/i_fipe_station.dart';
import '../entities/car_model_entity.dart';
import '../entities/car_year_entity.dart';
import '../utils/typedefs.dart';

class GetCarYearsUsecase {
  final _fipeService = Modular.get<IFipeStation>();

  AsyncIterable<CarYearEntity> call(CarModelEntity model) async {
    return await _fipeService.getCarYears(
      model,
    );
  }
}
