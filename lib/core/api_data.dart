import 'dart:convert';
import 'package:http/http.dart' as http;

class APIData {
  static const String _baseURL =
      'https://parallelum.com.br/fipe/api/v1/carros/marcas';

  static List<Map<String, dynamic>>? manufacturersList;
  static List<Map<String, dynamic>>? modelList;
  static List<Map<String, dynamic>>? yearList;
  static String? fipe;

  static Future<http.Response> requestManufacturers() {
    return http.get(Uri.parse(_baseURL));
  }

  static Future<http.Response> requestModels({required String manufacturer}) {
    return http.get(Uri.parse('$_baseURL/$manufacturer/modelos'));
  }

  static Future<http.Response> requestYears(
      {required String manufacturer, required String model}) {
    return http.get(Uri.parse('$_baseURL/$manufacturer/modelos/$model/anos'));
  }

  static Future<http.Response> requestFIPE(
      {required String manufacturer,
      required String model,
      required String year}) {
    return http
        .get(Uri.parse('$_baseURL/$manufacturer/modelos/$model/anos/$year'));
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

    manufacturersList = List<Map<String, dynamic>>.generate(
      dynamicList.length,
      (index) => dynamicList.elementAt(index),
    );
  }

  static Future<void> setModels(
      {required Map<String, dynamic> manufacturer}) async {
    http.Response response =
        await requestModels(manufacturer: manufacturer['codigo'].toString()).timeout(
      const Duration(seconds: 15),
      onTimeout: () => throw Exception('Request Timed Out'),
    );

    if (response.statusCode != 200) {
      throw Exception('Error on requesting data');
    }

    List dynamicList = json.decode(response.body)['modelos'];

    modelList = List<Map<String, dynamic>>.generate(
      dynamicList.length,
      (index) => dynamicList.elementAt(index),
    );
  }

  static Future<void> setYear({
    required Map<String, dynamic> manufacturer,
    required Map<String, dynamic> model,
  }) async {
    http.Response response = await requestYears(
            manufacturer: manufacturer['codigo'].toString(), model: model['codigo'].toString())
        .timeout(
      const Duration(seconds: 15),
      onTimeout: () => throw Exception('Request Timed Out'),
    );

    if (response.statusCode != 200) {
      throw Exception('Error on requesting data');
    }

    List dynamicList = json.decode(response.body);
    yearList = List<Map<String, dynamic>>.generate(
      dynamicList.length,
      (index) => dynamicList.elementAt(index),
    );
  }

  static Future<void> setFIPE({
    required Map<String, dynamic> manufacturer,
    required Map<String, dynamic> model,
    required Map<String, dynamic> year,
  }) async {
    http.Response response = await requestFIPE(
      manufacturer: manufacturer['codigo'].toString(),
      model: model['codigo'].toString(),
      year: year['codigo'].toString(),
    ).timeout(
      const Duration(seconds: 15),
      onTimeout: () => throw Exception('Request Timed Out'),
    );

    if (response.statusCode != 200) {
      throw Exception('Error on requesting data');
    }

    Map<String, dynamic> responseBody = json.decode(response.body);
    fipe = responseBody['Valor'];
  }
}
