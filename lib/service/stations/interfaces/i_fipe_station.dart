import '../../../core/entities/car_brand_entity.dart';
import '../../../core/entities/car_fipe_entity.dart';
import '../../../core/entities/car_model_entity.dart';
import '../../../core/entities/car_year_entity.dart';
import '../../../core/utils/typedefs.dart';

abstract interface class IFipeStation {
  AsyncIterable<CarBrandEntity> getCarBrands();

  AsyncIterable<CarModelEntity> getCarModels(CarBrandEntity brand);

  AsyncIterable<CarYearEntity> getCarYears(CarModelEntity model);

  Future<CarFipeEntity> getCarFipe(CarYearEntity year);
}
