import 'dart:math';

import 'package:barcode_scanner/app/data/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:flutter/services.dart' show rootBundle;

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  RxString result = "Can't find the part number?".obs;
  RxString barcode = RxString("_");
  TextEditingController resultBarcode = TextEditingController();
  double scale = 1.0;
  double _previousScale = 1.0;
  final controllerFirebase = Get.put(MainController());
  final TransformationController transformationController =
      TransformationController();
  String imagePath = '';
  bool imageExists = false;

  @override
  void onInit() {
    super.onInit();
    // controllerFirebase.login();
    controllerFirebase.checkFirestoreConnection();
  }

  

  void res(context) async {
    final response = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SimpleBarcodeScannerPage()),
    );
    print("response => $response");
    barcode.value = response.toString();
    resultBarcode.text = barcode.value;
    print("Barcode Value: ${resultBarcode.text}");
    onChange(response);
  }

  void onChange(String value) {
    print("==== ON CHANGE BERJALAN ====");
    print(value);
    resultBarcode.value = TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
    print("===== ${resultBarcode.text} ======");
    barcode.value = resultBarcode.text;
  }

  void interactionUpdate() {
    scale = transformationController.value.getMaxScaleOnAxis();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
