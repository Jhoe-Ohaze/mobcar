import 'package:flutter_modular/flutter_modular.dart';

import '../../service/stations/interfaces/i_storage_station.dart';
import '../entities/car_fipe_entity.dart';
import '../utils/typedefs.dart';

class LoadCarsUsecase {
  final _service = Modular.get<IStorageStation>();

  AsyncIterable<CarFipeEntity> call() {
    return _service.loadCars();
  }
}
