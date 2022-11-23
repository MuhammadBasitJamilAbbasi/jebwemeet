import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Screens/JabWeMetScreen.dart';

class Splash_Screen extends StatefulWidget {
  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen>
    with TickerProviderStateMixin {
  final getStorageControlller = Get.find<GetSTorageController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getposition();
    Timer(Duration(seconds: 5), () {
      if (getStorageControlller.box.read("isLogged").toString() == "isLogged") {
        // Get.offAll(() => HomePage());
      } else {
        Get.offAll(() => JabWeMet_Screen());
      }
    });
  }

/*
  getposition() async {
    Position position =
        await GetLocation.getGeoLocationPosition().whenComplete(() {
      Timer(Duration(seconds: 2), () {
        print("install     " +
            getStorageControlller.box.read("install").toString());
        print("islogged    " +
            getStorageControlller.box.read("isLogged").toString());
        if (getStorageControlller.box.read("isLogged").toString() ==
            "isLogged") {
          Get.offAll(() => HomePage());
        } else {
          if (getStorageControlller.box.read("install").toString() == "true") {
            Get.offAll(() => LoginScreen());
          } else {
            Get.offAll(() => Get_Started());
          }
        }
      });
    });
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            "assets/splash.png",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
