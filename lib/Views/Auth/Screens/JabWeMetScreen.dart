import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';
import 'package:jabwemeet/Views/Auth/Screens/LoginScreen.dart';
import 'package:jabwemeet/Views/Auth/Screens/Signup_with_phone.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppComponents().sizedBox50,
                AppComponents().sizedBox50,
                 Image.asset(
                    "assets/logonew.png",
                   height: 78,
                   width: 134,
                  ),
                AppComponents().sizedBox50,
                Text("Sign up to continue",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700),),
                AppComponents().sizedBox50,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: kAppButton(
                      buttonText: "Continue with email", onButtonPressed: (){
                    Get.to(()=> SignUpScreen());
                  }),
                ),
                AppComponents().sizedBox30,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: kAppButton(
                    buttonstyleSmall: true,
                      buttonText: "Use phone number", onButtonPressed: (){
                    Get.to(() => SignUpPhoneScreen());
                  }),
                ),
                AppComponents().sizedBox50,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 0.3,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "  Or sign up with  ",
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 12),
                      ),
                      Expanded(
                        child: Container(
                          height: 0.3,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                AppComponents().sizedBox20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.asset(
                        "assets/facebook.png",
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                   GetBuilder<RegisterController>(builder: (controller){
                     return controller.isLoaderGoogle? Center(child: CircularProgressIndicator(),):  InkWell(
                       onTap: (){
                         controller.signInwithGoogle();
                       },
                       child: Container(
                         width: 64,
                         height: 64,
                         padding: EdgeInsets.all(18),
                         decoration: BoxDecoration(
                           color: Colors.white,
                           border: Border.all(color: Colors.grey.shade200),
                           borderRadius: BorderRadius.circular(15),
                         ),
                         child: Image.asset(
                           "assets/google.png",
                         ),
                       ),
                     );
                   }),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 64,
                      height: 64,
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.asset(
                        "assets/apple.png",
                      ),
                    ),                ],
                ),
                AppComponents().sizedBox30,
                InkWell(
                  onTap: () {
                    Get.to(() => TermsAndConiditons());
                  },
                  child:  Text(
                    "By continuing you agree to our Terms and \nPrivacy Policy",
                    style: TextStyle(
                      color: textcolor,
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
