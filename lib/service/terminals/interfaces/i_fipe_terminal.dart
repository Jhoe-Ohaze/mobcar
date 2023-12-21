import '../../../core/entities/car_brand_entity.dart';
import '../../../core/entities/car_fipe_entity.dart';
import '../../../core/entities/car_model_entity.dart';
import '../../../core/entities/car_year_entity.dart';

abstract interface class IFipeTerminal {
  Future<Iterable<CarBrandEntity>> getCarBrands();

  Future<Iterable<CarModelEntity>> getCarModels({
    required CarBrandEntity brand,
  });

  Future<Iterable<CarYearEntity>> getCarYears({
    required CarModelEntity model,
  });

  Future<CarFipeEntity> getCarFipe({
    required CarYearEntity year,
  });
}
