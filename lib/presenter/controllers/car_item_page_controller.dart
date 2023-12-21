import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobcar/core/usecases/edit_car_usecase.dart';
import 'package:mobcar/core/usecases/save_car_usecase.dart';
import 'package:smac_dart/smac.dart';

import '../../core/entities/car_brand_entity.dart';
import '../../core/entities/car_fipe_entity.dart';
import '../../core/entities/car_model_entity.dart';
import '../../core/entities/car_year_entity.dart';
import '../../core/usecases/get_car_brands_usecase.dart';
import '../../core/usecases/get_car_fipe_usecase.dart';
import '../../core/usecases/get_car_models_usecase.dart';
import '../../core/usecases/get_car_years_usecase.dart';
import '../../infra/arguments/car_item_args.dart';
import '../components/item/submit_modal.dart';

class CarItemPageController extends Smac {
  late final BuildContext _context;

  final CarItemArgs? _args = Modular.args.data;

  final brandFieldKey = GlobalKey<FormFieldState<CarBrandEntity>>();
  final modelsFieldKey = GlobalKey<FormFieldState<CarModelEntity>>();
  final yearsFieldKey = GlobalKey<FormFieldState<CarYearEntity>>();
  final fipeController = TextEditingController();
  final imageNotifier = ValueNotifier<Uint8List?>(null);
  final busyNotifier = ValueNotifier<bool>(false);

  final getCarBrands = Modular.get<GetCarBrandsUsecase>();
  final getCarModels = Modular.get<GetCarModelsUsecase>();
  final getCarYears = Modular.get<GetCarYearsUsecase>();
  final getFipe = Modular.get<GetCarFipeUsecase>();

  final saveCar = Modular.get<SaveCarUsecase>();
  final editCar = Modular.get<EditCarUsecase>();

  Iterable<CarBrandEntity> brandsIter = [];
  Iterable<CarModelEntity> modelsIter = [];
  Iterable<CarYearEntity> yearsIter = [];
  bool busy = false;

  CarBrandEntity? _selectedBrand;
  CarModelEntity? _selectedModel;
  CarYearEntity? _selectedYear;
  CarFipeEntity? _fipe;

  bool get isEdit => _args?.car != null;
  String get title => isEdit ? 'Editar Carro' : 'Adicionar Carro';
  String? get documentId => _args?.documentId;
  CarBrandEntity? get selectedBrand => _selectedBrand;
  CarModelEntity? get selectedModel => _selectedModel;
  CarYearEntity? get selectedYear => _selectedYear;
  CarFipeEntity? get fipe => _fipe;

  @override
  void onInitState(BuildContext context) async {
    _context = context;
    _fipe = _args?.car;
    imageNotifier.value = _args?.car?.image;
    brandsIter = await getCarBrands();
    notifyListeners();
  }

  void onBrandChange(CarBrandEntity? brand) async {
    _selectedBrand = brand;
    _selectedModel = null;
    _selectedYear = null;
    _fipe = null;
    modelsIter = await getCarModels(brand: _selectedBrand!);
    busyNotifier.value = false;
    notifyListeners();
  }

  void onModelChange(CarModelEntity? model) async {
    _selectedModel = model;
    _selectedYear = null;
    _fipe = null;
    yearsIter = await getCarYears(model: _selectedModel!);
    busyNotifier.value = false;
    notifyListeners();
  }

  void onYearChange(CarYearEntity? year) async {
    _selectedYear = year;
    _fipe = await getFipe(year: _selectedYear!);
    fipeController.text = _fipe!.fipe.toString();
    busyNotifier.value = false;
    notifyListeners();
  }

  void submit() async {
    showDialog(
      context: _context,
      builder: (firstContext) {
        return SubmitModal(
          onConfirm: () async {
            busyNotifier.value = true;
            if (isEdit) {
              await editCar(_fipe!);
            } else {
              await saveCar(_fipe!);
            }
            Modular.to.pop<bool>(true);
          },
        );
      },
    );
  }
}
