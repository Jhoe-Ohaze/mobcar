import 'package:flutter_modular/flutter_modular.dart';

import '../../service/stations/interfaces/i_fipe_station.dart';
import '../entities/car_fipe_entity.dart';
import '../entities/car_year_entity.dart';

class GetCarFipeUsecase {
  final _fipeService = Modular.get<IFipeStation>();

  Future<CarFipeEntity> call(CarYearEntity year) async {
    return await _fipeService.getCarFipe(year);
  }
}
