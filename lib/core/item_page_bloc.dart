import 'dart:async';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

import 'package:mobcar/core/api_data.dart';
import 'package:mobcar/core/car.dart';

class ItemPageBloc {
  final _manufacturersStreamController =
      StreamController<List<Manufacturer>?>();
  StreamSink<List<Manufacturer>?> get manufacturersSink =>
      _manufacturersStreamController.sink;
  Stream<List<Manufacturer>?> get manufacturersStream =>
      _manufacturersStreamController.stream;

  final _modelsStreamController = StreamController<List<Model>?>();
  StreamSink<List<Model>?> get modelsSink => _modelsStreamController.sink;
  Stream<List<Model>?> get modelsStream => _modelsStreamController.stream;

  final _yearsStreamController = StreamController<List<Year>?>();
  StreamSink<List<Year>?> get yearsSink => _yearsStreamController.sink;
  Stream<List<Year>?> get yearsStream => _yearsStreamController.stream;

  final _fipeStreamController = StreamController<String?>();
  StreamSink<String?> get fipeSink => _fipeStreamController.sink;
  Stream<String?> get fipeStream => _fipeStreamController.stream;

  final _imagePicker = ImagePicker();
  final _imageStreamController = StreamController<Uint8List?>();
  StreamSink<Uint8List?> get imageSink => _imageStreamController.sink;
  Stream<Uint8List?> get imageStream => _imageStreamController.stream;

  void getManufacturers() async {
    modelsSink.add(null);
    yearsSink.add(null);
    fipeSink.add(null);
    await APIData.setManufacturers();
    manufacturersSink.add(APIData.manufacturersList);
  }

  void getModels(Manufacturer? manufacturer) async {
    modelsSink.add(null);
    yearsSink.add(null);
    fipeSink.add(null);
    await APIData.setModels(manufacturer: manufacturer!);
    modelsSink.add(APIData.modelList);
  }

  void getYears(Model? model) async {
    yearsSink.add(null);
    fipeSink.add(null);
    await APIData.setYear(model: model!);
    yearsSink.add(APIData.yearList);
  }

  void getFipe(Year? year) async {
    fipeSink.add(null);
    await APIData.setFIPE(year: year!);
    fipeSink.add(APIData.fipe);
  }

  void getImage() async {
    XFile? xImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    Uint8List image = await xImage!.readAsBytes();
    imageSink.add(image);
  }

  void dispose() {
    _fipeStreamController.close();
    _imageStreamController.close();
    _manufacturersStreamController.close();
    _modelsStreamController.close();
    _yearsStreamController.close();
  }
}
