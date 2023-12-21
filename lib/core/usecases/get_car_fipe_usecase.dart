import 'package:flutter_modular/flutter_modular.dart';

import '../../services/adapters/services/interfaces/i_fipe_service.dart';
import '../entities/car_fipe_entity.dart';
import '../entities/car_year_entity.dart';

class GetCarFipeUsecase {
  final _fipeService = Modular.get<IFipeService>();

  Future<CarFipeEntity> call({required CarYearEntity year}) async {
    return await _fipeService.getCarFipe(
      year: year,
    );
  }
}
