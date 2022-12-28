import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Screens/LoginScreen2.dart';
import 'package:jabwemeet/Views/Auth/Screens/TermsAndConditions.dart';
import 'package:jabwemeet/Views/Auth/Screens/sign_up_screen.dart';

class JabWeMet_Screen extends StatefulWidget {
  const JabWeMet_Screen({Key? key}) : super(key: key);

  @override
  State<JabWeMet_Screen> createState() => _JabWeMet_ScreenState();
}

class _JabWeMet_ScreenState extends State<JabWeMet_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/jabwemet.png",
                  ),
                  fit: BoxFit.cover)),
          child: Container(
            color: Color(0xFFF15759).withOpacity(0.10),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                const Image(
                  image: AssetImage(
                    "assets/logo_full.png",
                  ),
                ),
                Expanded(child: Container()),
                SizedBox(
                  height: 40,
                  width: 260,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => LoginScreen2());
                    },
                    child: Text("Login", style: k14styleWhite),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: Color(0xfFf1565A)),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xfFf1565A)),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  height: 40,
                  width: 260,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => SignUpScreen());
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: butoncolor, fontWeight: FontWeight.w600),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: Colors.white),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    "Forgot password",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                        fontSize: 12),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => TermsAndConiditons());
                  },
                  child: const Text(
                    "By continuing you agree to our Terms and \nPrivacy Policy",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
