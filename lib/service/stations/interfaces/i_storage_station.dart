import '../../../core/entities/car_fipe_entity.dart';
import '../../../core/utils/typedefs.dart';

abstract interface class IStorageStation {
  Future<void> saveCar(CarFipeEntity car);
  Future<void> editCar(CarFipeEntity car);
  AsyncIterable<CarFipeEntity> loadCars();
}
