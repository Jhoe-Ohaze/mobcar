import 'package:flutter_modular/flutter_modular.dart';

import '../../services/adapters/services/interfaces/i_storage_service.dart';
import '../entities/car_fipe_entity.dart';

class EditCarUsecase {
  final _service = Modular.get<IStorageService>();

  Future<void> call(CarFipeEntity car) {
    return _service.editCar(car);
  }
}
