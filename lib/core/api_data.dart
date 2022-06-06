import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobcar/core/car.dart';

class APIData {
  static const String _baseURL =
      'https://parallelum.com.br/fipe/api/v1/carros/marcas';

  static List<Manufacturer>? manufacturersList;
  static List<Model>? modelList;
  static List<Year>? yearList;
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

    manufacturersList = List<Manufacturer>.generate(
      dynamicList.length,
      (index) {
        Map<String, dynamic> map = dynamicList.elementAt(index);
        final manufacturer = Manufacturer(
          name: map['nome'],
          code: map['codigo'],
        );
        return manufacturer;
      },
    );
  }

  static Future<void> setModels({required Manufacturer manufacturer}) async {
    http.Response response =
        await requestModels(manufacturer: manufacturer.code).timeout(
      const Duration(seconds: 15),
      onTimeout: () => throw Exception('Request Timed Out'),
    );

    if (response.statusCode != 200) {
      throw Exception('Error on requesting data');
    }

    List dynamicList = json.decode(response.body)['modelos'];

    modelList = List<Model>.generate(
      dynamicList.length,
      (index) {
        final map = dynamicList.elementAt(index);
        final model = Model(
          manufacturer: manufacturer,
          name: map['nome'],
          code: map['codigo'].toString(),
        );
        return model;
      },
    );
  }

  static Future<void> setYear({required Model model}) async {
    http.Response response = await requestYears(
            manufacturer: model.manufacturer.code, model: model.code)
        .timeout(
      const Duration(seconds: 15),
      onTimeout: () => throw Exception('Request Timed Out'),
    );

    if (response.statusCode != 200) {
      throw Exception('Error on requesting data');
    }

    List dynamicList = json.decode(response.body);
    yearList = List<Year>.generate(
      dynamicList.length,
      (index) {
        Map<String, dynamic> map = dynamicList.elementAt(index);
        final year = Year(
          manufacturer: model.manufacturer,
          model: model,
          name: map['nome'],
          code: map['codigo'],
        );
        return year;
      },
    );
  }

  static Future<void> setFIPE({required Year year}) async {
    http.Response response = await requestFIPE(
            manufacturer: year.manufacturer.code,
            model: year.model.code,
            year: year.code)
        .timeout(
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
