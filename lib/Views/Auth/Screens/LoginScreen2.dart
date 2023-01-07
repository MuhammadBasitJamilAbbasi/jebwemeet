import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/LoginController.dart';
import 'package:jabwemeet/Views/Auth/Screens/Forgot_password_screen/ForgotPass_email_screen.dart';
import 'package:jabwemeet/Views/Auth/Screens/Signup_with_phone.dart';
import 'package:jabwemeet/Views/Auth/Screens/sign_up_screen.dart';

class LoginScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<LoginController>(
          builder: (controller) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.height * 0.025,
                MediaQuery.of(context).size.height * 0.08,
                MediaQuery.of(context).size.height * 0.025,
                0,
              ),
              child: Form(
                key: controller.loginFormKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppComponents().backIcon(() {
                        Get.back();
                      }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.065,
                      ),
                      const Text(
                        "Sign in",
                        style: TextStyle(
                          color: Color(0xfFf1565A),
                          fontWeight: FontWeight.w900,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.055,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: kCustomTextField(
                            hinttext: "Enter your email",
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
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: kPasswordTextField(
                            isObsecure: controller.hidePassword.value,
                            controller: controller.password,
                            hintText: "Password",
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
                              child: const Text(
                                "Forgot password",
                                style: TextStyle(
                                    fontFamily: "Gilroy-Regular",
                                    decoration: TextDecoration.underline,
                                    color: Color(0xfFf1565A),
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.045,
                      ),
                      controller.isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: kCustomButton(
                                  label: "Login",
                                  ontap: () {
                                    controller.loginbutton(context);
                                  }),
                            ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.028,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account ",
                              style: TextStyle(
                                  fontFamily: "Gilroy-Regular",
                                  color: Colors.black,
                                  fontSize: 14),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => SignUpScreen());
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: butoncolor,
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppComponents().sizedBox50,
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              color: Colors.grey.shade300,
                            ),
                          ),
                          Text(
                            " or continue with ",
                            style: k14styleblack,
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ],
                      ),
                      AppComponents().sizedBox20,
                      controller.isLoaderGoogle
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.signInwithGoogle();
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Image.asset(
                                      "assets/google.png",
                                      height: 40,
                                      width: 40,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => SignUpPhoneScreen());
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Icon(
                                      Icons.phone,
                                      color: butoncolor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                      AppComponents().sizedBox20,
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
