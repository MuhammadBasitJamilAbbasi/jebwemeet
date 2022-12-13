import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/1.Complete_profile_screen.dart';
import 'package:jabwemeet/Views/Auth/Screens/JabWeMetScreen.dart';
import 'package:jabwemeet/Views/Auth/Screens/Register_screns/register_screen.dart';
import 'package:jabwemeet/Views/Home/Screens/Home/Home.dart';

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
    Timer(Duration(seconds: 5), () async {
      if (getStorageControlller.box.read("loggedin").toString() == "loggedin") {
        await initFunction();
      } else {
        Get.offAll(() => JabWeMet_Screen());
      }
    });
  }

  initFunction() async {
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) async => {
              if (value.exists)
                {
                  if (value.get("age") == null)
                    {Get.offAll(() => Register_screen())}
                  else
                    {
                      if (value.get("imageUrl") == null)
                        {Get.offAll(() => Complete_Profile1())}
                      else
                        {Get.offAll(() => Home())}
                    }
                }
              else
                {Get.offAll(() => JabWeMet_Screen())}
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
