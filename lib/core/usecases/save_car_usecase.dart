import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobcar/services/adapters/services/interfaces/i_storage_service.dart';

import '../entities/car_fipe_entity.dart';

class SaveCarUsecase {
  final _service = Modular.get<IStorageService>();

  Future<void> call(CarFipeEntity car) {
    return _service.saveCar(car);
  }
}
