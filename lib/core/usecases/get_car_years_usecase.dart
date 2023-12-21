import 'package:flutter_modular/flutter_modular.dart';

import '../../service/stations/interfaces/i_fipe_station.dart';
import '../entities/car_model_entity.dart';
import '../entities/car_year_entity.dart';

class GetCarYearsUsecase {
  final _fipeService = Modular.get<IFipeStation>();

  Future<Iterable<CarYearEntity>> call({required CarModelEntity model}) async {
    return await _fipeService.getCarYears(
      model: model,
    );
  }
}
