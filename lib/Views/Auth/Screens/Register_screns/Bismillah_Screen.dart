import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
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
      await Get.find<RegisterController>().addsignupdetails();
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
      body: GetBuilder<RegisterController>(builder: (controller) {
        return isEmailVerified
            ? SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppComponents().sizedBox30,
                        AppComponents().backIcon(),
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
                                fontWeight: FontWeight.w500,
                                fontFamily: "Gilroy-Bold",
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
                                fontWeight: FontWeight.w500,
                                fontFamily: "Gilroy-Bold",
                                fontSize: 16),
                          ),
                        ),
                        AppComponents().sizedBox15,
                        Text(
                          "Make sure your profile information is true to who you are. Inappropriate users are banned and we have a zero tolerance policy for profits that impersonate others. Our community is full of real and authentic prople and we're excired for you to join",
                          style: k14styleblack,
                        ),
                        AppComponents().sizedBox20,
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
                                fontFamily: "Gilroy-Regular",
                                decoration: TextDecoration.underline,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        AppComponents().sizedBox30,
                        Center(
                          child: kCustomButton(
                            ontap: () {
                              if (controller.isAccept.value == true &&
                                  controller.isTerm.value == true &&
                                  controller.isPolicy.value == true) {
                                Get.to(() => Register_screen());
                              } else
                                snackBar(
                                    context,
                                    "Accept the Terms & Conditions and Privacy Policy",
                                    Colors.pink);
                            },
                            label: "I Understand",
                            isRegister: true,
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
                        AppComponents().backIcon(),
                        AppComponents().sizedBox50,
                        Text(
                          "A verification email has been sent to your email.",
                          style: k25styleblack,
                        ),
                        Text(
                          "Please check your inbox & spam folder.",
                          style: k16styleblack,
                        ),
                        AppComponents().sizedBox50,
                        AppComponents().sizedBox50,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppComponents().sizedBox30,
                            Center(
                              child: kCustomButton(
                                  label: "Resend Email",
                                  ontap: () {
                                    sendVerificationEmail();
                                  }),
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
