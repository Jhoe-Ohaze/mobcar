import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobcar/core/usecases/load_cars_usecase.dart';
import 'package:smac_dart/core/presenter/async_smac.dart';
import 'package:smac_dart/core/presenter/smac.dart';

import '../../core/entities/car_fipe_entity.dart';
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

  void onFabPressed() async {
    final refresh = await Modular.to.pushNamed<bool?>('/form');
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
        );
      },
    );
  }
}
