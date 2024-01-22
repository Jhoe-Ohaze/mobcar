import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:smac_dart/core/presenter/async_smac.dart';
import 'package:smac_dart/core/presenter/smac.dart';

import '../../core/entities/car_fipe_entity.dart';
import '../../core/usecases/load_cars_usecase.dart';
import '../../infra/arguments/car_item_args.dart';
import '../components/list/car_details_modal_widget.dart';

class CarListPageController extends Smac {
  final loadCars = Modular.get<LoadCarsUsecase>();

  final manufacturerFieldKey = GlobalKey<FormFieldState>();
  final modelFieldKey = GlobalKey<FormFieldState>();
  final yearFieldKey = GlobalKey<FormFieldState>();
  final fipeController = TextEditingController();

  final asyncController = AsyncSmacController();
  final savedCarsNotifier = ValueNotifier<Iterable<CarFipeEntity>>([]);

  @override
  void onInitState(BuildContext context) {
    super.onInitState(context);
    getCarList();
  }

  Future<void> getCarList() async {
    asyncController.waitFor(() async {
      savedCarsNotifier.value = await loadCars();
    });
  }

  void onFabPressed({CarFipeEntity? car}) async {
    final refresh = await Modular.to.pushNamed<bool?>(
      '/form',
      arguments: CarItemArgs(car: car),
    );

    if (refresh == true) {
      getCarList();
    }

    if (car != null) {
      Modular.to.pop();
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
