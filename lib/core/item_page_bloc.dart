import 'dart:async';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

import 'package:mobcar/core/api_data.dart';
import 'package:mobcar/core/car.dart';
import 'package:rxdart/rxdart.dart';

class ItemPageBloc {
  final _manufacturersStreamController =
      StreamController<List<Manufacturer>?>.broadcast();
  StreamSink<List<Manufacturer>?> get manufacturersSink =>
      _manufacturersStreamController.sink;
  Stream<List<Manufacturer>?> get manufacturersStream =>
      _manufacturersStreamController.stream;

  final _modelsStreamController = StreamController<List<Model>?>.broadcast();
  StreamSink<List<Model>?> get modelsSink => _modelsStreamController.sink;
  Stream<List<Model>?> get modelsStream => _modelsStreamController.stream;

  final _yearsStreamController = StreamController<List<Year>?>.broadcast();
  StreamSink<List<Year>?> get yearsSink => _yearsStreamController.sink;
  Stream<List<Year>?> get yearsStream => _yearsStreamController.stream;

  final _fipeStreamController = StreamController<String?>.broadcast();
  StreamSink<String?> get fipeSink => _fipeStreamController.sink;
  Stream<String?> get fipeStream => _fipeStreamController.stream;

  final _imagePicker = ImagePicker();
  final _imageStreamController = StreamController<Uint8List?>.broadcast();
  StreamSink<Uint8List?> get imageSink => _imageStreamController.sink;
  Stream<Uint8List?> get imageStream => _imageStreamController.stream;

  Stream<bool> get submitStream => CombineLatestStream.combine4(
      manufacturersStream,
      modelsStream,
      yearsStream,
      fipeStream,
      (a, b, c, d) => true);

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
