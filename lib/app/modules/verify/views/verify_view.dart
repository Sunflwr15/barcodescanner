import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/verify_controller.dart';

class VerifyView extends GetView<VerifyController> {
  const VerifyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyController());
    print("password on init: ${controller.localPassword}");
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0, left: 5.0),
                child: Text(
                  "Password  ${controller.localPassword}",
                  style: TextStyle(
                    fontWeight: FontWeight.w500, // Set medium font weight
                    fontSize: 16.0, // Set medium font size
                  ),
                ),
              ),
              Row(
                // spacing: 10,
                // alignment: WrapAlignment.center,
                // runSpacing: 10,
                children: [
                  Expanded(
                    child: TextField(
                      // autofocus: true,
                      controller: controller.passwordController,
                      // onChanged: (value) {
                      //   controller.onChange(value);
                      // },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 12,
                        ),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            topLeft: Radius.circular(16),
                            bottomRight: Radius.circular(0),
                            topRight: Radius.circular(0),
                          ),
                        ),
                        hintText: "Insert The Password Provided",
                      ),
                    ),
                  ),
                  ElevatedButton(
                    // onPressed: () => controller.res(context),
                    onPressed: () =>
                        controller.submit(controller.passwordController.text),
                    // icon: Icon(Icons.barcode_reader),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomLeft: Radius.circular(0),
                          topLeft: Radius.circular(0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 5.0),
                child: Text(
                    "Please enter the provided password to verify the user and protect the data."),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
