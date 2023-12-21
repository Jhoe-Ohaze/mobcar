import 'package:flutter_modular/flutter_modular.dart';

import '../../services/adapters/services/interfaces/i_fipe_service.dart';
import '../entities/car_brand_entity.dart';

class GetCarBrandsUsecase {
  final _fipeService = Modular.get<IFipeService>();

  Future<Iterable<CarBrandEntity>> call() async {
    return await _fipeService.getCarBrands();
  }
}
