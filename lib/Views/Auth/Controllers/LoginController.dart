import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Views/Home/Screens/Home/Home.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool hidePassword = true.obs;
  // SignInService service = new SignInService();
  var isLoadingGoogle = false.obs;
  var isLoadingFacebook = false.obs;
  var isAccept = false.obs;
  var isTerm = false.obs;
  var isPolicy = false.obs;
  String? validateEmail(String value) {
    if (value == null || value == '') {
      return "*Required";
    } else if (!value.isEmail) {
      return 'Invalid Password';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value == null || value == '') {
      return "*Required";
    } else if (value.length < 6) {
      return "Password should be more than 6 character";
    }
    return null;
  }

  void showpassword() {
    if (hidePassword.value) {
      hidePassword.value = false;
    } else if (hidePassword.value == false) {
      hidePassword.value = true;
    }
  }

  final loginFormKey = GlobalKey<FormState>();
  bool isLoading = false;
  void loginbutton(BuildContext context) {
    final isValid = loginFormKey.currentState!.validate();
    if (isValid) {
      login(context);
    } else
      print("Not Valid");
  }

  Future login(BuildContext context) async {
    try {
      isLoading = true;
      update();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      )
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(value.user!.uid)
            .update({
          'fcm_token': await FirebaseMessaging.instance.getToken()
        }).whenComplete(() {
          log("User Firebase Messaging Token Updated: ");
        });
      });
      showDialog(
          context: context,
          builder: (builder) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      Get.offAll(() => Home());

      email.clear();
      password.clear();
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      update();
      String? message;
      switch (e.code) {
        case 'invalid-email':
          message = 'Invalid Email';
          break;

        case 'user-disabled':
          message = "Your account is diasbled";
          break;

        case 'user-not-found':
          message = 'User not found';
          break;

        case 'wrong-password':
          message = "Wrong password";
      }

      showDialog(
          context: context,
          builder: (builder) {
            return AlertDialog(
              title: const Text('Login failed'),
              content: Text(message ?? 'No internet'),
            );
          });
    } finally {
      isLoading = false;
      update();
      //   email.clear();
      //   password.clear();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // GetLocation.getGeoLocationPosition();
  }
}
