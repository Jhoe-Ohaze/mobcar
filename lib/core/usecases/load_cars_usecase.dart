import 'package:flutter_modular/flutter_modular.dart';

import '../../services/adapters/services/interfaces/i_storage_service.dart';
import '../entities/car_fipe_entity.dart';

class LoadCarsUsecase {
  final _service = Modular.get<IStorageService>();

  Future<Iterable<CarFipeEntity>> call() {
    return _service.loadCars();
  }
}
