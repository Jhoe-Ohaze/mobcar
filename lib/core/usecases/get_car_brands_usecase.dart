import 'package:flutter_modular/flutter_modular.dart';

import '../../service/stations/interfaces/i_fipe_station.dart';
import '../entities/car_brand_entity.dart';
import '../utils/typedefs.dart';

class GetCarBrandsUsecase {
  final _fipeService = Modular.get<IFipeStation>();

  AsyncIterable<CarBrandEntity> call() async {
    return await _fipeService.getCarBrands();
  }
}
