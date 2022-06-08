import 'dart:async';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mobcar/core/api_data.dart';
import 'package:mobcar/core/car.dart';
import 'package:mobcar/core/database.dart';
import 'package:rxdart/rxdart.dart';

// ignore: constant_identifier_names
enum Level { MANUFACTURER, MODEL, YEAR, FIPE }

class ItemPageBloc {
  //Misc Variables
  final _imagePicker = ImagePicker();
  Uint8List? _oldImage;

  //Behavior Subjects
  final listManufacturerBehavior =
      BehaviorSubject<List<Map<String, dynamic>>?>();
  final listModelBehavior = BehaviorSubject<List<Map<String, dynamic>>?>();
  final listYearBehavior = BehaviorSubject<List<Map<String, dynamic>>?>();
  final manufacturerBehavior = BehaviorSubject<Map<String, dynamic>?>();
  final modelBehavior = BehaviorSubject<Map<String, dynamic>?>();
  final yearBehavior = BehaviorSubject<Map<String, dynamic>?>();
  final fipeBehavior = BehaviorSubject<String>();
  final imageBehavior = BehaviorSubject<Uint8List>();

  //Sinks
  StreamSink<List<Map<String, dynamic>>?> get listManufacturerSink =>
      listManufacturerBehavior.sink;
  StreamSink<List<Map<String, dynamic>>?> get listModelSink =>
      listModelBehavior.sink;
  StreamSink<List<Map<String, dynamic>>?> get listYearSink =>
      listYearBehavior.sink;
  StreamSink<Map<String, dynamic>?> get manufacturerSink =>
      manufacturerBehavior.sink;
  StreamSink<Map<String, dynamic>?> get modelSink => modelBehavior.sink;
  StreamSink<Map<String, dynamic>?> get yearSink => yearBehavior.sink;
  StreamSink<String> get fipeSink => fipeBehavior.sink;
  StreamSink<Uint8List> get imageSink => imageBehavior.sink;

  //Values
  List<Map<String, dynamic>>? get listManufacturer =>
      listManufacturerBehavior.valueOrNull;
  List<Map<String, dynamic>>? get listModel => listModelBehavior.valueOrNull;
  List<Map<String, dynamic>>? get listYear => listYearBehavior.valueOrNull;
  Map<String, dynamic>? get manufacturer => manufacturerBehavior.valueOrNull;
  Map<String, dynamic>? get model => modelBehavior.valueOrNull;
  Map<String, dynamic>? get year => yearBehavior.valueOrNull;
  String get fipe => fipeBehavior.value;
  Uint8List? get image => imageBehavior.valueOrNull;

  //Streams
  Stream<bool> get submitStream => CombineLatestStream.combine4(
        manufacturerBehavior.stream,
        modelBehavior.stream,
        yearBehavior.stream,
        fipeBehavior.stream,
        (Map<String, dynamic>? a, Map<String, dynamic>? b,
            Map<String, dynamic>? c, String d) {
          return (a != null && b != null && c != null && d.isNotEmpty);
        },
      );

  //Functions
  void _nullyfyManufacturerStreams() {
    manufacturerSink.add(null);
    listManufacturerSink.add([]);
  }

  void _nullifyModelStreams() {
    modelSink.add(null);
    listModelSink.add([]);
  }

  void _nullifyYearStreams() {
    yearSink.add(null);
    listYearSink.add([]);
  }

  Future<void> getManufacturers() async {
    _nullyfyManufacturerStreams();
    _nullifyModelStreams();
    _nullifyYearStreams();
    fipeSink.add('');
    await APIData.setManufacturers();
    listManufacturerSink.add(APIData.manufacturersList!);
  }

  Future<void> getModels({required Map<String, dynamic> manufacturer}) async {
    _nullifyModelStreams();
    _nullifyYearStreams();
    fipeSink.add('');
    await APIData.setModels(manufacturer: manufacturer);
    listModelBehavior.sink.add(APIData.modelList);
  }

  Future<void> getYears(
      {required Map<String, dynamic> manufacturer,
      required Map<String, dynamic> model}) async {
    _nullifyYearStreams();
    fipeSink.add('');
    await APIData.setYear(manufacturer: manufacturer, model: model);
    listYearSink.add(APIData.yearList);
  }

  Future<void> getFipe(
      {required Map<String, dynamic> manufacturer,
      required Map<String, dynamic> model,
      required Map<String, dynamic> year}) async {
    await APIData.setFIPE(manufacturer: manufacturer, model: model, year: year);
    fipeBehavior.sink.add(APIData.fipe!);
  }

  Future<void> getImage() async {
    XFile? xImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    Uint8List image = await xImage!.readAsBytes();
    imageBehavior.sink.add(image);
  }

  Future<void> initEditionFields(Car car) async {
    http.Response response;
    if (car.imageURL != null) {
      response = await http.get(Uri.parse(car.imageURL!));
      Uint8List image = response.bodyBytes;
      imageBehavior.sink.add(image);
    }

    await getManufacturers();
    for (int index = 0; index < listManufacturer!.length; index++) {
      if (car.manufacturer['codigo'] ==
          listManufacturer!.elementAt(index)['codigo']) {
        manufacturerSink.add(listManufacturer!.elementAt(index));
        break;
      }
    }

    await getModels(
      manufacturer: car.manufacturer,
    );
    for (int index = 0; index < listModel!.length; index++) {
      if (car.model['codigo'] == listModel!.elementAt(index)['codigo']) {
        modelSink.add(listModel!.elementAt(index));
        break;
      }
    }

    await getYears(
      manufacturer: car.manufacturer,
      model: car.model,
    );
    for (int index = 0; index < listYear!.length; index++) {
      if (car.year['codigo'] == listYear!.elementAt(index)['codigo']) {
        yearSink.add(listYear!.elementAt(index));
        break;
      }
    }

    await getFipe(
      manufacturer: car.manufacturer,
      model: car.model,
      year: car.year,
    );
  }

  Future<void> saveData() async {
    Car car = Car(
        manufacturer: manufacturer!, model: model!, year: year!, fipe: fipe);
    await Database.saveData(car: car, image: image);
  }

  Future<void> updateData(Car oldCar, String documentID) async {
    Car newCar = Car(
      manufacturer: manufacturer!,
      model: model!,
      year: year!,
      fipe: fipe,
    );

    Database.updateData(
      oldData: oldCar,
      newData: newCar,
      oldImage: _oldImage,
      newImage: image,
      documentID: documentID,
    );
  }

  void dispose() {
    fipeBehavior.close();
    imageBehavior.close();
    manufacturerBehavior.close();
    modelBehavior.close();
    yearBehavior.close();
  }
}
