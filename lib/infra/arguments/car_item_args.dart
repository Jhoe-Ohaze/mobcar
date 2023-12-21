import '../../core/entities/car_fipe_entity.dart';

class CarItemArgs {
  final CarFipeEntity? car;
  final String? documentId;

  CarItemArgs({
    this.car,
    this.documentId,
  });
}
