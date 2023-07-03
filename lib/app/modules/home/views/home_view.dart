import 'package:barcode_scanner/app/data/controller/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import '../controllers/home_controller.dart';
import 'package:flutter/services.dart' show rootBundle;

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final controllerFirebase = Get.put(MainController());
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    print(" Result Barcode = ${controller.resultBarcode.text}");
    print(" Barcode2 = ${controller.barcode}");
    print(" Image Exist = ${controller.imageExists}");
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  // spacing: 10,
                  alignment: WrapAlignment.center,
                  runSpacing: 10,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.resultBarcode,
                        onChanged: (value) {
                          controller.onChange(value);
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 12,
                          ),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          hintText: "Insert Part Number",
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'or',
                          style: TextStyle(
                            fontSize: 16.0, // Replace with your desired MD size
                            fontStyle: FontStyle.italic,
                          ),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: ElevatedButton.icon(
                          onPressed: () => controller.res(context),
                          icon: Icon(Icons.barcode_reader),
                          label: Text(
                            'SCAN',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            // onPrimary: Colors.red,
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              // side: BorderSide(
                              //   color: Colors.red,
                              //   width: 2,
                              // ),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Obx(
                  () => Wrap(
                    spacing: 10,
                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      Center(
                        child: Container(
                            margin: EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                                // border: Border.all(
                                //   color: Colors.black,
                                //   width: 4.0,
                                // ),
                                // borderRadius: BorderRadius.circular(50)
                                ),
                            child: FutureBuilder<DocumentSnapshot<Object?>>(
                              future: controllerFirebase
                                  .getDocumentById(controller.result),
                              builder: (context, snapshot) {
                                var partData = snapshot.data!;
                                print(partData);
                                if (partData.exists) {
                                  // Document with the given ID exists
                                  // Render the data in a Text widget
                                  return InteractiveViewer(
                                    transformationController:
                                        controller.transformationController,
                                    onInteractionUpdate: (details) {
                                      controller.interactionUpdate();
                                    },
                                    minScale: 0.5,
                                    maxScale: 4.0,
                                    child: Wrap(
                                        alignment: WrapAlignment.center,
                                        direction: Axis.vertical,
                                        runAlignment: WrapAlignment.center,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          Image.asset(
                                            '',
                                            fit: BoxFit.cover,
                                            width: width / 1.1,
                                          ),
                                        ]),
                                  );
                                } else {
                                  // Document with the given ID does not exist
                                  return Text('Document not found');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
