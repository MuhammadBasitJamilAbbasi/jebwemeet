import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Screens/TermsAndConditions.dart';
import 'package:jabwemeet/Views/Auth/Screens/login_screen.dart';

class JabWeMet_Screen2 extends StatefulWidget {
  const JabWeMet_Screen2({Key? key}) : super(key: key);

  @override
  State<JabWeMet_Screen2> createState() => _JabWeMet_Screen2State();
}

class _JabWeMet_Screen2State extends State<JabWeMet_Screen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Image.asset(
                  "assets/Jabwemeet logo.png",
                  height: 87,
                  width: 177,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Image.asset(
                  "assets/Center img.png",
                  height: 260,
                  width: 260,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Image.asset(
                  "assets/soulmate.png",
                  height: 60,
                  width: MediaQuery.of(context).size.width - 100,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Join us with the mindset of making a match and socialize with million of peoples.",
                    style: k14styleblack,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                kCustomButton(
                    label: "Login",
                    ontap: () {
                      Get.to(() => LoginScreen());
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.055,
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) => const TermsAndConiditons()));
                    },
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                          color: butoncolor, fontWeight: FontWeight.w600),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: butoncolor, width: 1.0),
                        ),
                      ),
                      elevation: MaterialStateProperty.all(0.0),
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
                        color: Colors.black,
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
                      color: Colors.black,
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
