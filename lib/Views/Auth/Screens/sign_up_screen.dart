import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';
import 'package:jabwemeet/Views/Auth/Screens/Signup_with_phone.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegisterController>();
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
                key: controller.signupKey,
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
                      "Sign Up",
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
                          controller: controller.emailController,
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
                          controller: controller.passController,
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.045,
                    ),
                    GetBuilder<RegisterController>(builder: (controller) {
                      return controller.loading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: kAppButton(
                                  buttonText: "Sign Up",
                                  onButtonPressed: () {
                                    controller.sendVerificationEmail(controller.emailController.value.text, controller.generateCode(6), "1");
                                  }),
                            );
                    }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.028,
                    ),
                    alreadyHaveAnAccount(context),
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
                    AppComponents().sizedBox40,
                    AppComponents().sizedBox20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Container(
                        //   width: 64,
                        //   height: 64,
                        //   padding: EdgeInsets.all(18),
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     border: Border.all(color: Colors.grey.shade200),
                        //     borderRadius: BorderRadius.circular(15),
                        //   ),
                        //   child: Image.asset(
                        //     "assets/facebook.png",
                        //   ),
                        // ),
                        SizedBox(
                          width: 20,
                        ),
                        GetBuilder<RegisterController>(builder: (controller) {
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
                        // Container(
                        //   width: 64,
                        //   height: 64,
                        //   padding: EdgeInsets.all(18),
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     border: Border.all(color: Colors.grey.shade200),
                        //     borderRadius: BorderRadius.circular(15),
                        //   ),
                        //   child: Image.asset(
                        //     "assets/apple.png",
                        //   ),
                        // ),
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
