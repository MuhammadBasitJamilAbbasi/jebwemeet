import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/kCommonButton.dart';
import 'package:jabwemeet/Utils/constants.dart';

class Dialouge_Box {
  static Future<bool> showExitPopup_PrepareFood(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Do you want to leave this page?"),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('yes selected');
                            // exit(0);
                            // Get.offAll(() => HomePage());
                            // Get.offUntil( GetPageRoute(page: () => HomePage()) , (route) => route.settings.name =="/homeScreen" );
                          },
                          child: Text("Yes"),
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          print('no selected');
                          Navigator.of(context).pop();
                        },
                        child:
                            Text("No", style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  static Future<bool> showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/appicon.png",
                    height: 45,
                    width: 45,
                  ),
                  SizedBox(height: 20),
                  Center(child: Text("Do you want to Exit the App?")),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('yes selected');
                            exit(0);
                            // Get.off(() => HomePage());
                            // Get.offUntil( GetPageRoute(page: () => HomePage()) , (route) => route.settings.name =="/homeScreen" );
                          },
                          child: Container(
                              height: 45,
                              child: Center(child: Text("Yes"))),
                          style: ElevatedButton.styleFrom(primary: textcolor),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          print('no selected');
                          Navigator.of(context).pop();
                        },
                        child:
                            Container(
                                height:45,
                                child: Center(child: Text("No", style: TextStyle(color: Colors.white)))),
                        style: ElevatedButton.styleFrom(
                          primary: textcolor,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  static void showDialogBOX({required Widget child, required String title}) {
    Get.defaultDialog(
      title: title,
      radius: 10,
      barrierDismissible: false,
      //padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      contentPadding: EdgeInsets.only(
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
          left: 10,
          right: 10),
      // title: 'Detail Of The Day',
      content: SingleChildScrollView(
          child: Column(
        children: [
          child,
          Container(
            margin: EdgeInsets.only(top: 20),
            width: 100,
            height: 30,
            child: kCommonButton(
                text: "Back",
                ontap: () {
                  Get.back();
                }),
          )
        ],
      )),
    );
  }

  static void showCustomDialoge(
      {required Widget child, required String title, required bool value}) {
    Get.defaultDialog(
      title: title,
      titleStyle: k14styleblackBold,
      backgroundColor: Colors.grey.shade200,
      barrierDismissible: value,
      titlePadding: EdgeInsets.only(top: 15),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      // backgroundColor: BACKGROUND_COLOR,
      // title: 'Detail Of The Day',
      content: child,
      // titleStyle: titleStyle,
    );
  }

  static show_snackBarError(
      {required String title, required String description}) {
    Get.snackbar(
      title,
      description,
      colorText: Colors.white,
      borderRadius: 0,
      backgroundColor: Colors.red.shade800,
      icon: Icon(Icons.error, color: Colors.white),
      animationDuration: 0.35.seconds,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      reverseAnimationCurve: Curves.easeOutExpo,
      overlayColor: Colors.white38,
      overlayBlur: .1,
      margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static show_snackBarSuccess(
      {required String title,
      required String description,
      bool should_go_back = false}) {
    Get.snackbar(title, description,
        colorText: Colors.black,
        borderRadius: 0,
        backgroundColor: Colors.white54,
        borderColor: Colors.black.withOpacity(0.65),
        icon: Icon(Icons.check_circle, color: Colors.grey.shade200),
        animationDuration: 0.45.seconds,
        forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
        reverseAnimationCurve: Curves.easeOutExpo,
        overlayColor: Colors.white54,
        overlayBlur: .1,
        margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        snackStyle: SnackStyle.FLOATING,
        snackPosition: SnackPosition.BOTTOM, snackbarStatus: (status) {
      print(status);
      if (status == SnackbarStatus.CLOSED) {
        if (should_go_back) Get.back();
      }
    });
  }
}
