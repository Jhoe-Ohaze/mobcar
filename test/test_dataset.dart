import 'package:flutter_test/flutter_test.dart';
import 'package:mobcar/core/api_data.dart';
import 'package:mobcar/core/car.dart';

void main(List<String> args) {
  final testManufacturer = Manufacturer(name: 'Test', code: '59');
  final testModel = Model(
    name: 'test',
    code: '5940',
    manufacturer: testManufacturer,
  );

  final testYear = Year(
    name: 'test',
    code: '2014-3',
    manufacturer: testManufacturer,
    model: testModel,
  );

  test('Should not be empty', (() async {
    await APIData.setManufacturers();
    expect(APIData.manufacturersList!.isNotEmpty, true);
  }));

  test('Should not be empty', (() async {
    await APIData.setModels(manufacturer: testManufacturer);
    expect(APIData.modelList!.isNotEmpty, true);
  }));

  test('Should not be empty', (() async {
    await APIData.setYear(model: testModel);
    expect(APIData.yearList!.isNotEmpty, true);
  }));

  test('Should not be empty', (() async {
    await APIData.setFIPE(year: testYear);
    expect(APIData.fipe!.isNotEmpty, true);
  }));
}
