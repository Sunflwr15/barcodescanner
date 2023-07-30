import 'package:get/get.dart';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class VerifyController extends GetxController {
  //TODO: Implement VerifyController
  final TextEditingController passwordController = TextEditingController();
  final count = 0.obs;
  RxString? localPassword = RxString("");

  @override
  void onInit() async {
    getPass();
    print("password on init: $localPassword");
    super.onInit();
  }

  Future<void> submit(String action) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (action != "partdatabaseamju") {
      Get.defaultDialog(title: 'Alert', middleText: 'Invalid Password');
    } else {
      print("Berjalan");
      prefs.setString('action', action);
      getPass();
      Get.toNamed("/home");
    }
  }

  getPass() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var password = prefs.getString("action");
    localPassword!.value = password.toString();
    print("get password: $password");
    print("local password: $localPassword");
    return password;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
