import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mobcar/core/database.dart';

void main(List<String> args) {
  test('Should return 200', (() async {
    http.Response response = await Database.requestManufacturers();
    expect(response.statusCode, 200);
  }));

  test('Should return a list of Manufacturers', (() async {
    await Database.setManufacturers();
    print(Database.manufacturersList);
    expect(Database.manufacturersList.isNotEmpty, true);
  }));
}
