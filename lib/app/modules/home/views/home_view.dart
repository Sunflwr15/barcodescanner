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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // spacing: 10,
                  // alignment: WrapAlignment.center,
                  // runSpacing: 10,
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
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Wrap(
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
                        // child: FutureBuilder<QuerySnapshot<Object?>>(
                        //   future: controllerFirebase.getDocumentById(
                        //       controller.result.value),
                        //   builder: (context, snapshot) {
                        //     if (snapshot.connectionState ==
                        //         ConnectionState.waiting) {
                        //       return CircularProgressIndicator();
                        //     } else if (snapshot.hasError) {
                        //       print(snapshot.error);
                        //       return Text('Error: ${snapshot.error.toString()}');
                        //     } else if (snapshot.hasData) {
                        //       var partData = snapshot.data!.docs;
                        //       print(partData);
                        //       return InteractiveViewer(
                        //         transformationController:
                        //             controller.transformationController,
                        //         onInteractionUpdate: (details) {
                        //           controller.interactionUpdate();
                        //         },
                        //         minScale: 0.5,
                        //         maxScale: 4.0,
                        //         child: Wrap(
                        //           alignment: WrapAlignment.center,
                        //           direction: Axis.vertical,
                        //           runAlignment: WrapAlignment.center,
                        //           crossAxisAlignment: WrapCrossAlignment.center,
                        //           children: [
                        //             Image.asset(
                        //               '',
                        //               fit: BoxFit.cover,
                        //               width: width / 1.1,
                        //             ),
                        //           ],
                        //         ),
                        //       );
                        //     } else {
                        //       return Container();
                        //     }
                        //   },
                        // ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
