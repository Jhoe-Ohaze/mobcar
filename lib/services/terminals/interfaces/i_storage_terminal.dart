abstract interface class IStorageTerminal {
  Future<Map<dynamic, String>> getCars();

  Future<void> saveCar(String car);
  Future<void> editCar(int id, String car);
}
