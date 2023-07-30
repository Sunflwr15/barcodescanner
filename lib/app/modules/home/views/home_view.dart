import 'package:barcode_scanner/app/data/controller/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final controllerFirebase = Get.put(MainController());
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    print("Result Barcode = ${controller.resultBarcode.text}");
    print("Barcode2 = ${controller.barcode}");
    print("Image Exist = ${controller.imageExists}");
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: height / 1.2,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          autofocus: true,
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
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                topLeft: Radius.circular(16),
                                bottomRight: Radius.circular(0),
                                topRight: Radius.circular(0),
                              ),
                            ),
                            hintText: "Insert Part Number",
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
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
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 15),
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
                  SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      width: width,
                      child: Wrap(
                        spacing: 10,
                        direction: Axis.vertical,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              width: width / 1.1,
                              margin: EdgeInsets.only(top: 20),
                              decoration: BoxDecoration(),
                              child: FutureBuilder<QuerySnapshot<Object?>>(
                                future: controllerFirebase
                                    .getData(controller.resultBarcode.text),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    var docs = snapshot.data!.docs;
                                    print("IMAGE DATA ${docs.length}");
                                    return docs.length != 0
                                        ? Wrap(
                                            children: List.generate(docs.length,
                                                (index) {
                                              return InteractiveViewer(
                                                transformationController:
                                                    controller
                                                        .transformationController,
                                                onInteractionUpdate: (details) {
                                                  controller
                                                      .interactionUpdate();
                                                },
                                                minScale: 0.5,
                                                maxScale: 4.0,
                                                child: Image.network(
                                                  (docs[index].data() as Map<
                                                          String, dynamic>)[
                                                      "part_image"], // Replace with the actual field name from your Firestore document
                                                  fit: BoxFit.fitWidth,
                                                  width: width / 1.1,
                                                  height: height / 1.3,
                                                ),
                                              );
                                            }),
                                          )
                                        : Text(
                                            "Document is not available or it doesn't exist", textAlign: TextAlign.center,);
                                  } else {
                                    return Center(child: CircularProgressIndicator());
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          // Align(
                          //   alignment: Alignment.bottomRight,
                          //   child: ElevatedButton.icon(
                          //     onPressed: () => controller.res(context),
                          //     icon: Icon(Icons.barcode_reader),
                          //     label: Text(
                          //       'SCAN',
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //       ),
                          //     ),
                          //     style: ElevatedButton.styleFrom(
                          //       primary: Colors.red,
                          //       padding: EdgeInsets.symmetric(
                          //           vertical: 16, horizontal: 15),
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.only(
                          //           topLeft: Radius.circular(16),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
