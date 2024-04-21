import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobcar/service/stations/interfaces/i_storage_station.dart';

import '../entities/car_fipe_entity.dart';

class SaveCarUsecase {
  final _service = Modular.get<IStorageStation>();

  Future<void> call(CarFipeEntity car) {
    return _service.saveCar(car);
  }
}
