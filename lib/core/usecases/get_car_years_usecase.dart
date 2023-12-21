import 'package:flutter_modular/flutter_modular.dart';

import '../../services/adapters/services/interfaces/i_fipe_service.dart';
import '../entities/car_model_entity.dart';
import '../entities/car_year_entity.dart';

class GetCarYearsUsecase {
  final _fipeService = Modular.get<IFipeService>();

  Future<Iterable<CarYearEntity>> call({required CarModelEntity model}) async {
    return await _fipeService.getCarYears(
      model: model,
    );
  }
}
