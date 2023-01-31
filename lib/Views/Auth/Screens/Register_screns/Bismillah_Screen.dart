import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';
import 'package:jabwemeet/Views/Auth/Screens/Register_screns/register_screen.dart';
import 'package:jabwemeet/Views/Auth/Screens/TermsAndConditions.dart';
import 'package:jabwemeet/Views/Auth/Screens/sign_up_screen.dart';

class Bismillah_Screen extends StatefulWidget {
  @override
  State<Bismillah_Screen> createState() => _Bismillah_ScreenState();
}

class _Bismillah_ScreenState extends State<Bismillah_Screen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified == true) {
      timer?.cancel();
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      snackBar(context, e.toString(), Colors.pink);
      print(e.toString());
    }
  }

  Timer? timer;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<RegisterController>(
          init: RegisterController(),
          builder: (controller) {
            return isEmailVerified
                ? SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppComponents().sizedBox30,
                            AppComponents().backIcon(() {
                              Get.back();
                            }),
                            AppComponents().sizedBox30,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Image.asset("assets/kindpng_2078997.png"),
                            ),
                            AppComponents().sizedBox30,
                            Center(
                              child: Text(
                                "Be Respectful",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16),
                              ),
                            ),
                            AppComponents().sizedBox15,
                            Text(
                              "Jab We Meet is made for people with ultimate goal of getting married or networking so please act accordingly and treat others with respect.",
                              style: k14styleblack,
                            ),
                            AppComponents().sizedBox30,
                            Center(
                              child: Text(
                                "Be Yourself",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16),
                              ),
                            ),
                            AppComponents().sizedBox15,
                            Text(
                              "Make sure your profile information is true to who you are. Inappropriate users are banned and we have a zero tolerance policy for profits that impersonate others. Our community is full of real and authentic prople and we're excired for you to join",
                              style: k14styleblack,
                            ),
                            AppComponents().sizedBox30,
                            InkWell(
                              onTap: () {
                                Get.to(() => TermsAndConiditons());
                              },
                              child: Center(
                                child: Text(
                                  "By continuing you agree to our Terms & Condition\n and Privacy Policy",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    decoration: TextDecoration.underline,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            AppComponents().sizedBox30,
                            Center(
                              child: controller.isUpdatePassLoad
                                  ? CircularProgressIndicator()
                                  : Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: kAppButton(
                                        onButtonPressed: () async {
                                          final con =
                                              Get.find<GetSTorageController>();
                                          print("isAccept: " +
                                              controller.isAccept.value
                                                  .toString());
                                          print("isTerm: " +
                                              controller.isTerm.value.toString());
                                          print("isPolicy: " +
                                              controller.isPolicy.value
                                                  .toString());
                                          if (con.box.read("isAccept") ==
                                                  "true" &&
                                              con.box.read("isTerm") == "true" &&
                                              con.box.read("isPolicy") ==
                                                  "true") {
                                            await Get.find<RegisterController>()
                                                .addsignupdetails()
                                                .then((value) => Get.to(
                                                    () => Register_screen()));
                                          } else
                                            snackBar(
                                                context,
                                                "Accept the Terms & Conditions and Privacy Policy",
                                                Colors.pink);
                                        },
                                        buttonText: "I Understand",
                                      ),
                                  ),
                            ),
                            AppComponents().sizedBox10,
                          ],
                        ),
                      ),
                    ),
                  )
                : SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppComponents().sizedBox20,
                            AppComponents().backIcon(() {
                              Get.back();
                            }),
                            AppComponents().sizedBox50,
                            Text(
                              "A verification email has been sent to your email.",
                              style: k25styleblack,
                            ),
                            AppComponents().sizedBox10,
                            Text(
                              "Please check your inbox & spam folder.",
                              style: k20styleblack,
                            ),
                            AppComponents().sizedBox50,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AppComponents().sizedBox30,
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: kAppButton(
                                        buttonText: "Resend Email",
                                        onButtonPressed: () {
                                          sendVerificationEmail();
                                        }),
                                  ),
                                ),
                                Center(
                                  child: TextButton(
                                      onPressed: () {
                                        FirebaseAuth.instance.signOut();
                                        Get.off(() => SignUpScreen());
                                      },
                                      child: Text("Cancel")),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          }),
    );
  }
}
