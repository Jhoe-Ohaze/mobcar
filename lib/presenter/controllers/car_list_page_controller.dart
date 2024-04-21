import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:smac_dart/core/presenter/async_smac.dart';
import 'package:smac_dart/core/presenter/smac.dart';

import '../../core/entities/car_fipe_entity.dart';
import '../../core/usecases/delete_car_usecase.dart';
import '../../core/usecases/load_cars_usecase.dart';
import '../../infra/arguments/car_item_args.dart';
import '../components/list/car_details_modal_widget.dart';

class CarListPageController extends Smac {
  final _loadCars = Modular.get<LoadCarsUsecase>();
  final _deleteCar = Modular.get<DeleteCarUsecase>();

  final manufacturerFieldKey = GlobalKey<FormFieldState>();
  final modelFieldKey = GlobalKey<FormFieldState>();
  final yearFieldKey = GlobalKey<FormFieldState>();
  final fipeController = TextEditingController();

  final asyncSmac = AsyncSmac();
  final savedCarsNotifier = ValueNotifier<Iterable<CarFipeEntity>>([]);

  void onInitState(BuildContext context) {
    getCarList();
  }

  void getCarList() async {
    asyncSmac.waitFor(() async {
      savedCarsNotifier.value = await _loadCars().then(
        (value) => value.toList(),
      );
    });
  }

  void deleteCar(int id) async {
    await _deleteCar(id);
    final cars = [...savedCarsNotifier.value];
    cars.removeWhere((car) => car.id == id);

    savedCarsNotifier.value = cars;
  }

  void onFabPressed({CarFipeEntity? car}) async {
    if (car is CarFipeEntity) {
      Modular.to.pop();
    }

    final refresh = await Modular.to.pushNamed<bool?>(
      '/form',
      arguments: CarItemArgs(car: car),
    );

    if (refresh == true) {
      getCarList();
    }
  }

  void showDetailsModal({
    required BuildContext context,
    required CarFipeEntity car,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return CarDetailsModalWidget(
          car: car,
          editCallback: () => onFabPressed(car: car),
        );
      },
    );
  }
}
