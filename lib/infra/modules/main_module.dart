import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobcar/core/usecases/edit_car_usecase.dart';
import 'package:mobcar/core/usecases/load_cars_usecase.dart';
import 'package:mobcar/core/usecases/save_car_usecase.dart';

import '../../core/usecases/get_car_brands_usecase.dart';
import '../../core/usecases/get_car_fipe_usecase.dart';
import '../../core/usecases/get_car_models_usecase.dart';
import '../../core/usecases/get_car_years_usecase.dart';
import '../../presenter/pages/car_item_page.dart';
import '../../presenter/pages/car_list_page.dart';
import '../../services/adapters/services/implementations/fipe_rest_service.dart';
import '../../services/adapters/services/implementations/hive_storage_service.dart';
import '../../services/adapters/services/interfaces/i_fipe_service.dart';
import '../../services/adapters/services/interfaces/i_storage_service.dart';
import '../../services/terminals/implementations/fipe_rest_terminal.dart';
import '../../services/terminals/implementations/hive_storage_terminal.dart';
import '../../services/terminals/interfaces/i_fipe_terminal.dart';
import '../../services/terminals/interfaces/i_storage_terminal.dart';

class MainModule extends Module {
  @override
  void binds(Injector i) {
    i.add<IFipeTerminal>(() => FipeRestTerminal());
    i.add<IStorageTerminal>(() => HiveStorageTerminal());
    i.add<IFipeService>(() => FipeRestService());
    i.add<IStorageService>(() => HiveStorageService());
    i.add<GetCarBrandsUsecase>(() => GetCarBrandsUsecase());
    i.add<GetCarModelsUsecase>(() => GetCarModelsUsecase());
    i.add<GetCarYearsUsecase>(() => GetCarYearsUsecase());
    i.add<GetCarFipeUsecase>(() => GetCarFipeUsecase());
    i.add<EditCarUsecase>(() => EditCarUsecase());
    i.add<LoadCarsUsecase>(() => LoadCarsUsecase());
    i.add<SaveCarUsecase>(() => SaveCarUsecase());
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => const CarListPage(),
    );
    r.child(
      '/form',
      child: (context) => const CarItemPage(),
    );
  }
}
