import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/entities/car_fipe_entity.dart';
import '../../../terminals/interfaces/i_storage_terminal.dart';
import '../../mappers/implementations/car_fipe_mapper.dart';
import '../interfaces/i_storage_service.dart';

class HiveStorageService implements IStorageService {
  final _terminal = Modular.get<IStorageTerminal>();

  @override
  Future<Iterable<CarFipeEntity>> loadCars() async {
    final map = await _terminal.getCars();
    final list = <CarFipeEntity>[];

    map.forEach((key, value) {
      CarFipeEntity car = CarFipeMapper().fromJson(value);
      car = car.copyWith(id: () => key);
      list.add(car);
    });

    return list;
  }

  @override
  Future<void> saveCar(CarFipeEntity car) async {
    final map = CarFipeMapper().toJson(car);
    await _terminal.saveCar(map);
  }

  @override
  Future<void> editCar(CarFipeEntity car) async {
    final map = CarFipeMapper().toJson(car);
    await _terminal.editCar(car.id!, map);
  }
}
