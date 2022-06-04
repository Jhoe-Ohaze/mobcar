import 'dart:convert';

import 'package:http/http.dart' as http;

class Database {
  static List<Map<String, dynamic>> manufacturersList = [];

  static Future<http.Response> requestManufacturers() {
    return http
        .get(Uri.parse('https://parallelum.com.br/fipe/api/v1/carros/marcas'));
  }

  static Future<void> setManufacturers() async {
    http.Response response = await requestManufacturers().timeout(
      const Duration(seconds: 15),
      onTimeout: () => throw Exception('Request Timed Out'),
    );
    if (response.statusCode != 200) {
      throw Exception('Error on requesting data');
    }
    List dynamicList = json.decode(response.body);
    List<Map<String, dynamic>> mapList =
        List<Map<String, dynamic>>.generate(dynamicList.length, (index) {
      return dynamicList.elementAt(index);
    });
    manufacturersList = mapList;
  }
}
