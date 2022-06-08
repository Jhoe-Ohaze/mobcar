import 'package:flutter_test/flutter_test.dart';
import 'package:mobcar/core/api_data.dart';

void main(List<String> args) {
  final testManufacturer = <String, dynamic>{'nome': 'Test', 'codigo': '59'};
  final testModel = <String, dynamic>{
    'nome': 'test',
    'codigo': '5940',
  };

  final testYear = <String, dynamic>{'nome': 'test', 'codigo': '2014-3'};

  test('Should not be empty', (() async {
    await APIData.setManufacturers();
    expect(APIData.manufacturersList!.isNotEmpty, true);
  }));

  test('Should not be empty', (() async {
    await APIData.setModels(manufacturer: testManufacturer);
    expect(APIData.modelList!.isNotEmpty, true);
  }));

  test('Should not be empty', (() async {
    await APIData.setYear(manufacturer: testManufacturer, model: testModel);
    expect(APIData.yearList!.isNotEmpty, true);
  }));

  test('Should not be empty', (() async {
    await APIData.setFIPE(
        manufacturer: testManufacturer, model: testModel, year: testYear);
    expect(APIData.fipe!.isNotEmpty, true);
  }));
}
