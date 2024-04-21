import 'package:hive_flutter/hive_flutter.dart';

import '../interfaces/i_storage_terminal.dart';

class HiveStorageTerminal implements IStorageTerminal {
  final _openBox = Hive.openBox<String>('cars');

  @override
  Future<Map<dynamic, String>> getCars() async {
    final box = await _openBox;

    return box.toMap();
  }

  @override
  Future<void> saveCar(String car) async {
    final box = await _openBox;
    await box.add(car);
  }

  @override
  Future<void> editCar(int id, String car) async {
    final box = await _openBox;
    await box.putAt(id, car);
  }

  @override
  Future<void> deleteCar(int id) async {
    final box = await _openBox;
    await box.delete(id);
  }
}
