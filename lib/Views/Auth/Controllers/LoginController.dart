import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jabwemeet/Models/UserModel.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/1.Complete_profile_screen.dart';
import 'package:jabwemeet/Views/Auth/Screens/Register_screns/register_screen.dart';
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
      return 'Invalid Email';
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
      User? user = FirebaseAuth.instance.currentUser;
      try {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user!.uid)
            .get()
            .then((value) async => {
                  if (value.get("imageUrl") == "")
                    {Get.offAll(() => Complete_Profile1())}
                  else
                    {Get.offAll(() => Home())}
                });
      } catch (e) {
        log(e.toString());
      }
      ;

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

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoaderGoogle = false;

  Future<String?> signInwithGoogle() async {
    try {
      isLoaderGoogle = true;
      update();
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await auth.signInWithCredential(credential).then((value) async {
        await addUserdetails();
        User? user = FirebaseAuth.instance.currentUser;
        try {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user!.uid)
              .get()
              .then((value) async => {
                    if (value.get("age") == "")
                      {Get.offAll(() => Register_screen())}
                    else
                      {
                        if (value.get("imageUrl") == "")
                          {Get.offAll(() => Complete_Profile1())}
                        else
                          {Get.offAll(() => Home())}
                      }
                  });
        } catch (e) {
          log(e.toString());
        }
        ;
      });
    } on FirebaseAuthException catch (e) {
      isLoaderGoogle = false;
      update();
      print(e.message);
      throw e;
    }
  }

//add the user details while signup
  final storage = Get.find<GetSTorageController>();
  Future addUserdetails() async {
    FirebaseAuth _fireAuth = FirebaseAuth.instance;
    User? user = _fireAuth.currentUser;
    UserModel userModel = UserModel(
        height: null,
        name: user!.displayName,
        about: null,
        address: storage.box.read(kAddress),
        age: "",
        caste: "",
        creativity: "",
        education: "",
        email: user.email,
        fcm_token: await FirebaseMessaging.instance.getToken(),
        gender: "",
        smoking: null,
        star_sign: null,
        religion: null,
        hobbies: null,
        sports: null,
        work: null,
        martial_status: null,
        imageUrl: "",
        phone_number: null,
        income: null,
        uid: FirebaseAuth.instance.currentUser!.uid,
        password: null);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set(userModel.toMap());
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // GetLocation.getGeoLocationPosition();
  }
}
