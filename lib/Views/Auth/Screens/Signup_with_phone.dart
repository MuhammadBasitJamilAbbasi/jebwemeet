import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Views/Auth/Controllers/LoginController.dart';

class SignUpPhoneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<LoginController>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Container(
                height: Get.height,
                width: Get.width,
                padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.height * 0.025,
                  MediaQuery.of(context).size.height * 0.06,
                  MediaQuery.of(context).size.height * 0.025,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // AppComponents().sizedBox50,
                    AppComponents().backIcon(),
                    AppComponents().sizedBox50,
                    Text(
                      "Sign in with phone number",
                      style: TextStyle(
                        color: Color(0xfFf1565A),
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    AppComponents().sizedBox50,

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: IntlPhoneField(
                              decoration: InputDecoration(
                                filled: true,
                                contentPadding: EdgeInsets.only(
                                    top: 15, bottom: 15, left: 10),
                                fillColor: Colors.grey.shade200,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                              ),
                              initialCountryCode: 'PK',
                              onChanged: (phone) {
                                print(phone.completeNumber);
                              },
                            )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015,
                        ),
                        // Obx(() {
                        //   return Padding(
                        //     padding: const EdgeInsets.symmetric(horizontal: 20),
                        //     child: kPasswordTextField(
                        //       isObsecure: controller.hidePassword.value,
                        //       controller: controller.password,
                        //       hintText: "Password",
                        //       validator: (val) {
                        //         return controller.validatePassword(val!);
                        //       },
                        //       onpress: () {
                        //         controller.hidePassword.value =
                        //             !controller.hidePassword.value;
                        //       },
                        //     ),
                        //   );
                        // }),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: kCustomButton(
                              label: "Login",
                              ontap: () {
                                // controller.loginbutton();
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
