import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'car.dart';

class Database {
  static List<Car>? carList;

  static Future<String> _uploadImage(Uint8List image) async {
    TaskSnapshot task = await FirebaseStorage.instance
        .ref()
        .child('Images')
        .child('${DateTime.now().millisecondsSinceEpoch.toRadixString(36)}.jpg')
        .putData(image, SettableMetadata(contentType: 'image/jpeg'));

    String imageURL = await task.ref.getDownloadURL();
    return imageURL;
  }

  static Future<void> setCarList() async {
    QuerySnapshot<Map<String, dynamic>>? listSnapshot = await FirebaseFirestore
        .instance
        .collection('Cars')
        .orderBy('added_on', descending: true)
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docList =
        listSnapshot.docs;
    List<Car> receivedList = List<Car>.generate(docList.length, (index) {
      DocumentSnapshot<Map<String, dynamic>> doc = docList.elementAt(index);
      Map<String, dynamic> data = doc.data()!;

      Car car = Car(
        manufacturer: data['manufacturer'],
        model: data['model'],
        year: data['year'],
        fipe: data['fipe'],
        id: doc.id,
      );
      if (data.containsKey('image_url')) car.imageURL = data['image_url'];
      return car;
    });

    carList = receivedList;
  }

  static Future<void> saveData({required Car car, Uint8List? image}) async {
    Map<String, dynamic> data = {
      'manufacturer': car.manufacturer,
      'model': car.model,
      'year': car.year,
      'fipe': car.fipe,
      'added_on': DateTime.now().toString(),
    };

    if (image != null) {
      data['image_url'] = await _uploadImage(image);
    }

    FirebaseFirestore.instance.collection('Cars').add(data);
  }

  static Future<void> updateData({
    required Car oldData,
    required Car newData,
    required String documentID,
    Uint8List? oldImage,
    Uint8List? newImage,
  }) async {
    Map<String, dynamic> data = {};

    if (oldData.manufacturer != newData.manufacturer) {
      data['manufacturer'] = newData.manufacturer;
    }

    if (oldData.model != newData.model) {
      data['model'] = newData.model;
    }

    if (oldData.year != newData.year) {
      data['year'] = newData.year;
    }

    if (oldData.fipe != newData.fipe) {
      data['fipe'] = newData.fipe;
    }

    if (!const ListEquality().equals(oldImage, newImage)) {
      if (oldData.imageURL != null) {
        await FirebaseStorage.instance.refFromURL(oldData.imageURL!).delete();
      }
      data['image_url'] = await _uploadImage(newImage!);
    }

    await FirebaseFirestore.instance
        .collection('Cars')
        .doc(documentID)
        .update(data);
  }

  static Future<void> deleteData({required Car car}) async {
    if (car.imageURL != null) {
      await FirebaseStorage.instance.refFromURL(car.imageURL!).delete();
    }
    await FirebaseFirestore.instance.collection('Cars').doc(car.id).delete();
  }
}
