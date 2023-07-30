import 'package:barcode_scanner/app/modules/verify/controllers/verify_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase Connection State: Connected");
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // var password = prefs.getString("action");
    // print("password: $password");
  } catch (e) {
    print("Firebase Connection State: Not Connected");
  }

  // Run your app
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  final controller = Get.put(VerifyController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: controller.getPass(), // Assuming you have a method to retrieve the stored password
      builder: (context, snapshot) {
        print(snapshot.connectionState);
        print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.done) {
          final storedPassword = snapshot.data;
          print("storedPassword: $storedPassword");
          final isPasswordValid = storedPassword == "partdatabaseamju";
          return GetMaterialApp(
            title: "Application",
            initialRoute: isPasswordValid ? Routes.HOME : Routes.VERIFY,
            getPages: AppPages.routes,
          );
        } else {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}
