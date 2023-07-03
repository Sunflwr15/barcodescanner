import 'package:get/get.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:file_picker/file_picker.dart';

import 'package:barcode_scanner/app/routes/app_pages.dart';

class MainController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  addData(bool aktifSlider, String deskSlider, String gambarSlider) async {
    CollectionReference slider = firestore.collection('');

    final sliderData = {
      "active_slider": aktifSlider,
      "deskripsi_slider": deskSlider,
      "gambar_slider": gambarSlider
    };

// Add a new document with a generated ID
    try {
      await slider.add(sliderData).then((DocumentReference doc) {
        print('DocumentSnapshot added with ID: ${doc.id}');
        Get.defaultDialog(title: 'Alert', middleText: 'berhasil menambah data');
        // Get.offNamed(Routes.SLIDER_DATA);
      });
    } catch (e) {
      Get.defaultDialog(title: 'Alert', middleText: 'gagal menambah data');
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getData(
      String documentId) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('your_collection_name')
        .doc(documentId)
        .get();

    if (snapshot.exists) {
      // Document with the given ID exists
      return snapshot;
    } else {
      // Document with the given ID does not exist
      throw Exception('Document not found');
    }
  }

  Future<DocumentSnapshot<Object?>> getDocumentById(RxString documentId) async {
    DocumentSnapshot<Object?> snapshot = await FirebaseFirestore.instance
        .collection('your_collection_name')
        .doc(documentId as String)
        .get();

    return snapshot;
  }
}
