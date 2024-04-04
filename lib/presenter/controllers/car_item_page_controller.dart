import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:smac_dart/smac.dart';

import '../../core/entities/car_brand_entity.dart';
import '../../core/entities/car_fipe_entity.dart';
import '../../core/entities/car_model_entity.dart';
import '../../core/entities/car_year_entity.dart';
import '../../core/usecases/edit_car_usecase.dart';
import '../../core/usecases/get_car_brands_usecase.dart';
import '../../core/usecases/get_car_fipe_usecase.dart';
import '../../core/usecases/get_car_models_usecase.dart';
import '../../core/usecases/get_car_years_usecase.dart';
import '../../core/usecases/save_car_usecase.dart';
import '../../infra/arguments/car_item_args.dart';
import '../components/item/submit_modal.dart';

class CarItemPageController extends Smac {
  late final BuildContext _context;

  final CarItemArgs? _args = Modular.args.data;

  final brandFieldKey = GlobalKey<FormFieldState<CarBrandEntity>>();
  final modelsFieldKey = GlobalKey<FormFieldState<CarModelEntity>>();
  final yearsFieldKey = GlobalKey<FormFieldState<CarYearEntity>>();
  final asyncController = AsyncSmacController();
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
  CarBrandEntity? get selectedBrand => _selectedBrand;
  CarModelEntity? get selectedModel => _selectedModel;
  CarYearEntity? get selectedYear => _selectedYear;
  CarFipeEntity? get fipe => _fipe;

  @override
  void onInitState(BuildContext context) async {
    _context = context;
    asyncController.triggerLoading();
    brandsIter = await getCarBrands();

    if (_args != null) {
      imageNotifier.value = _args?.car?.image;
      await onBrandChange(_args!.car?.brand);
      await onModelChange(_args!.car?.model);
      await onYearChange(_args!.car?.year);
      _fipe = _args!.car;
    }
    asyncController.triggerSuccess();
  }

  Future<void> onBrandChange(CarBrandEntity? brand) async {
    if (brand != null) {
      _selectedBrand = brand;
      _selectedModel = null;
      _selectedYear = null;
      _fipe = null;
      modelsIter = await getCarModels(_selectedBrand!);
      busyNotifier.value = false;
      notifyListeners();
    }
  }

  Future<void> onModelChange(CarModelEntity? model) async {
    if (model != null) {
      _selectedModel = model;
      _selectedYear = null;
      _fipe = null;
      yearsIter = await getCarYears(_selectedModel!);
      busyNotifier.value = false;
      notifyListeners();
    }
  }

  Future<void> onYearChange(CarYearEntity? year) async {
    if (year != null) {
      _selectedYear = year;
      _fipe = await getFipe(_selectedYear!);
      _fipe = _fipe?.copyWith(id: () => _args?.car?.id);
      fipeController.text = _fipe!.fipe.toString();
      busyNotifier.value = false;
      notifyListeners();
    }
  }

  void submit() async {
    if (_fipe != _args?.car) {
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
}
