import 'dart:async';
import 'package:mobcar/core/car.dart';
import 'package:mobcar/core/database.dart';

class ListPageBloc {
  final _carsStreamController = StreamController<List<Car>?>();
  StreamSink<List<Car>?> get carsSink => _carsStreamController.sink;
  Stream<List<Car>?> get carsStream => _carsStreamController.stream;

  void getCarList() async {
    await Database.setCarList();
    carsSink.add(Database.carList);
  }

  void dispose() {
    _carsStreamController.close();
  }
}
