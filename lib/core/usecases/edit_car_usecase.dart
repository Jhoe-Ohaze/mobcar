import 'package:flutter_modular/flutter_modular.dart';

import '../../service/stations/interfaces/i_storage_station.dart';
import '../entities/car_fipe_entity.dart';

class EditCarUsecase {
  final _service = Modular.get<IStorageStation>();

  Future<void> call(CarFipeEntity car) {
    return _service.editCar(car);
  }
}
