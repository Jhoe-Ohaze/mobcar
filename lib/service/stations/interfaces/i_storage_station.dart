import '../../../core/entities/car_fipe_entity.dart';

abstract interface class IStorageStation {
  Future<void> saveCar(CarFipeEntity car);
  Future<void> editCar(CarFipeEntity car);
  Future<Iterable<CarFipeEntity>> loadCars();
}
