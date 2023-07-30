// import 'dart:html';

import 'package:barcode_scanner/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';


import 'package:firebase_storage/firebase_storage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:file_picker/file_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:barcode_scanner/app/routes/app_pages.dart';

class MainController extends GetxController {
  // final controller = Get.find<HomeController>();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<User?> streamAuthStatus() => auth.authStateChanges();

  void checkFirestoreConnection() {
    FirebaseFirestore.instance.collection('/part').snapshots().listen(
        (snapshot) {
      print('Connected to Firestore $snapshot'); // Connection successful
    }, onError: (error) {
      print('Failed to connect to Firestore: $error'); // Connection failed
    });
  }

  addData() async {
    CollectionReference slider = firestore.collection('part');

    final sliderData = {
      "part_name": "TES ADD",
      "part_image": "",
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

  Future<void> login() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      User? user = userCredential.user;

      if (user != null) {
        // Anonymous sign-in successful
        // Handle the signed-in user
        print('Signed in anonymously with user ID: ${user.uid}');
      } else {
        // Anonymous sign-in failed
        print('Anonymous sign-in failed');
      }
    } catch (e) {
      // Error occurred during anonymous sign-in
      print('Error signing in anonymously: $e');
    }
  }

   Future<QuerySnapshot<Object?>> getData(String id) async {
    CollectionReference produk = firestore.collection('/part');
    String output1 = id.replaceAll("-", "");
    String output = output1.replaceAll(" ", "");
    print("output: $output input: $id");
    return await produk.where("part_name", isEqualTo: output).get();
  }
  
  
}
