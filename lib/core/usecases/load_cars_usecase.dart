import 'package:flutter_modular/flutter_modular.dart';

import '../../service/stations/interfaces/i_storage_station.dart';
import '../entities/car_fipe_entity.dart';

class LoadCarsUsecase {
  final _service = Modular.get<IStorageStation>();

  Future<Iterable<CarFipeEntity>> call() {
    return _service.loadCars();
  }
}
