import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/LoginController.dart';
import 'package:jabwemeet/Views/Auth/Screens/Register_screns/Bismillah_Screen.dart';
import 'package:jabwemeet/Views/Auth/Screens/Signup_with_phone.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<LoginController>(
      builder: (controller) {
        return Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/login_page.jpg"),
                  fit: BoxFit.cover)),
          child: Form(
            child: SingleChildScrollView(
              child: Container(
                height: Get.height,
                width: Get.width,
                color: Colors.black.withOpacity(0.2),
                padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.height * 0.025,
                  MediaQuery.of(context).size.height * 0.06,
                  MediaQuery.of(context).size.height * 0.025,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 1,
                        child: AppComponents().backIcon(() {
                          Get.back();
                        })),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Sign in your account",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.175,
                    ),
                    Expanded(
                      flex: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: kCustomTextField(
                                hinttext: "Enter your email",
                                controller: controller.email,
                                validator: (value) {
                                  return controller.validateEmail(value);
                                }),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.035,
                          ),
                          Obx(() {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 30),
                                  child: Text(
                                    "Forgot password",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        decoration: TextDecoration.underline,
                                        color: Colors.white,
                                        fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AppComponents().sizedBox20,
                          controller.isLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: kCustomButton(
                                      label: "Login",
                                      ontap: () {
                                        controller.loginbutton(context);
                                      }),
                                ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      fontSize: 12),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => Bismillah_Screen());
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        decoration: TextDecoration.underline,
                                        color: butoncolor,
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AppComponents().sizedBox20,
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                " Or Continue with",
                                style: k12styleWhite,
                              ),
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          AppComponents().sizedBox20,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Image.asset(
                                  "assets/google.png",
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
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Icon(
                                    Icons.phone,
                                    color: butoncolor,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ));
  }
}
