import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Utils/locations.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/onboarding_controller.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/completeProfile/view/completeprofilescreen.dart';

import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/completeProfile/view/completeprofilescreen.dart';
import 'package:jabwemeet/Views/Auth/Screens/JabWeMetScreen.dart';
import 'package:jabwemeet/Views/Auth/Screens/Register_screns/register_screen.dart';
import 'package:jabwemeet/Views/Auth/Screens/onboarding2.dart';
import 'package:jabwemeet/Views/Home/Controllers/home_page_controller.dart';
import 'package:jabwemeet/Views/Home/Screens/Home/home_swap.dart';
import 'package:jabwemeet/Views/Home/Screens/Home/new_home_swapable.dart';
import 'package:profanity_filter/profanity_filter.dart';

import '../../../Services/notification/local_notifications/local_notification_service.dart';
import '../../Home/Screens/Likes/LIke.dart';

class Splash_Screen extends StatefulWidget {
  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen>
    with TickerProviderStateMixin {
  final getStorageController = Get.find<GetSTorageController>();
  getlocation() async {
    Position position = await GetLocation.getPermission().whenComplete(() {});
    Get.find<GetSTorageController>()
        .box
        .write(P_LATITUDE, position.latitude.toString());
    Get.find<GetSTorageController>()
        .box
        .write(P_LONGITUDE, position.longitude.toString());
  }
  final filter = ProfanityFilter();
  final string="ass";
  String badString = 'you are an dog';
  @override
  void initState() {
    print("<===== Bad string========>");
    print(filter.hasProfanity(string).toString());
    String cleanString = filter.censor('you are an ass');
    print(cleanString.toString());
    //Method called.
    getInitialMessage(context);
    /* If the app is open then the the notification occurs.
     Its a stream hence we listen to it.*/
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        log(message.notification!.title!);
        log(message.notification!.body!);
        log("Message Data: JWM Notification Message ${message.data["jwm_message"]}");
        LocalNotificationApiImplementation.createAndDisplayNotification(
            message);
      }
    });
    /* Shows Changes when the app is opened by a notification  */
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log("Notification: App was opened by a notification");
      if (message.notification != null) {
        log(message.notification!.title!);
        log(message.notification!.body!);
        log("Message Data: JWM Notification Message ${message.data['jwm_message']}");
      }
    });
    // TODO: implement initState
    super.initState();
    // getposition();
    Timer(Duration(seconds: 5), () async {
      if (getStorageController.box.read("loggedin").toString() == "loggedin") {
        await initFunction();
      } else {
        Get.offAll(() => OnboardingScreen());
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
                  if (value.get("age") == 0)
                    {Get.offAll(() => OnboardingScreen())}
                  else
                    {
                      if (value.get("imageUrl") == null ||
                          value.get("imageUrl") == "null")
                        {Get.offAll(() => OnboardingScreen())}
                      else
                        {
                          Get.offAll(() => HomeSwapNew())}
                    }
                }
              else
                {Get.offAll(() => OnboardingScreen())}
            });
  }

  void getInitialMessage(BuildContext context) async {
    /*
    =>This message will be null if the user did not open
      the app with notification.
    =>This method will be called when app in terminated state and you get a
      notification
    =>When you click on notification app open from terminated state and you
      can get notification data in this method
    */
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      /*This will be the property sent from the cloud notification*/
      log("New Notification: JWM Notification Message => ${message.data['jwm_message']}");
      Get.to(() => LikesView());
    }
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 70),
        color: textcolor,
        child: Center(
          child: Image.asset(
            "assets/logonew.png",
            height: 120,
            color: Colors.white,
            width: 150,
          ),
        ),
      ),
    );
  }
}
