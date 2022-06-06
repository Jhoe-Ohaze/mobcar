import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mobcar/core/api_data.dart';

void main(List<String> args) {
  test('Should return 200', (() async {
    http.Response response = await APIData.requestManufacturers();
    expect(response.statusCode, 200);
  }));

  test('Should return 200', (() async {
    http.Response response = await APIData.requestModels(manufacturer: '59');
    expect(response.statusCode, 200);
  }));

  test('Should return 200', (() async {
    http.Response response =
        await APIData.requestYears(manufacturer: '59', model: '5940');
    expect(response.statusCode, 200);
  }));

  test('Should return 200', (() async {
    http.Response response =
        await APIData.requestFIPE(manufacturer: '59', model: '5940', year: '2014-3');
    expect(response.statusCode, 200);
  }));
}
