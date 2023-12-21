import 'package:flutter_modular/flutter_modular.dart';

import '../../services/adapters/services/interfaces/i_fipe_service.dart';
import '../entities/car_brand_entity.dart';
import '../entities/car_model_entity.dart';

class GetCarModelsUsecase {
  final _fipeService = Modular.get<IFipeService>();

  Future<Iterable<CarModelEntity>> call({
    required CarBrandEntity brand,
  }) async {
    return await _fipeService.getCarModels(
      brand: brand,
    );
  }
}
