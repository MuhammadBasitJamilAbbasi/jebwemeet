import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/LoginController.dart';
import 'package:jabwemeet/Views/Auth/Screens/Forgot_password_screen/ForgotPass_email_screen.dart';
import 'package:jabwemeet/Views/Auth/Screens/Signup_with_phone.dart';
import 'package:jabwemeet/Views/Auth/Screens/sign_up_screen.dart';

class LoginScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.height * 0.030,
                MediaQuery.of(context).size.height * 0.03,
                MediaQuery.of(context).size.height * 0.035,
                0,
              ),
              child: Form(
                key: controller.loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppComponents().backIcon(() {
                      Get.back();
                    }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.065,
                    ),
                    Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.055,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: kCustomTextField(
                          hinttext: "Enter your email",
                          labeltext: "Email",
                          controller: controller.email,
                          validator: (val) {
                            return controller.validateEmail(val!);
                          }),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.035,
                    ),
                    Obx(() {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: kPasswordTextField(
                          isObsecure: controller.hidePassword.value,
                          controller: controller.password,
                          hintText: "Password",
                          labeltext: "Password",
                          validator: (val) {
                            return controller.validatePassword(val!);
                          },
                          onpress: () {
                            controller.hidePassword.value =
                                !controller.hidePassword.value;
                          },
                        ),
                      );
                    }),
                    AppComponents().sizedBox10,
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => ForgetPasswordEmail_Screen());
                            },
                            child: Text(
                              "Forgot password",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: textcolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.045,
                    ),
                    GetBuilder<LoginController>(builder: (controller) {
                      return controller.isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: kAppButton(
                                  buttonText: "Login",
                                  onButtonPressed: () {
                                    controller.loginbutton(context);
                                  }),
                            );
                    }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.028,
                    ),
                    kdontHaveAnAccount(context),
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
                            "  Or sign in with  ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
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
                        GetBuilder<LoginController>(builder: (controller) {
                          return controller.isLoaderGoogle
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : InkWell(
                            onTap: (){
                              controller.signInwithGoogle();
                            },
                                child: Container(
                                    width: 64,
                                    height: 64,
                                    padding: EdgeInsets.all(18),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Colors.grey.shade200),
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
                        ),
                      ],
                    ),
                    AppComponents().sizedBox30,
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
