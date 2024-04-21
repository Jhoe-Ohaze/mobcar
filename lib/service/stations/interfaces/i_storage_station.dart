import '../../../core/entities/car_fipe_entity.dart';
import '../../../core/utils/typedefs.dart';

abstract interface class IStorageStation {
  AsyncIterable<CarFipeEntity> loadCars();

  Future<void> saveCar(CarFipeEntity car);
  Future<void> editCar(CarFipeEntity car);
  Future<void> deleteCar(int id);
}
