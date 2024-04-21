import 'package:flutter_modular/flutter_modular.dart';

import '../../service/stations/interfaces/i_storage_station.dart';

class DeleteCarUsecase {
  final _station = Modular.get<IStorageStation>();

  Future<void> call(int id) async {
    return await _station.deleteCar(id);
  }
}
