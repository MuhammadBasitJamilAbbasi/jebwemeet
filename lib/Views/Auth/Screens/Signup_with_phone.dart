import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
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
                        controller.isSent
                            ? SizedBox.shrink()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: IntlPhoneField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    contentPadding: EdgeInsets.only(
                                        top: 15, bottom: 15, left: 1),
                                    fillColor: Colors.grey.shade100,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                  ),
                                  initialCountryCode: 'PK',
                                  onChanged: (phone) {
                                    print(phone.completeNumber);
                                    Get.find<GetSTorageController>()
                                        .box
                                        .write(kPhone, phone.completeNumber);
                                  },
                                )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015,
                        ),
                        controller.isSent
                            ? Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                child: textField(
                                    onChanged: (value) {
                                      // resetController.verifyPasswordOnChange(value, context);
                                      controller.codeentered(value);
                                    },
                                    counter: Text(''),
                                    maxlength: 6,
                                    borderColor: Colors.grey,
                                    isPassword: false,
                                    inputType: TextInputType.number,
                                    validation: (value) {
                                      return controller.validateOTP(value);
                                    },
                                    controller: controller.otpController,
                                    hintText: '6-digit code from SMS'),
                              )
                            : SizedBox.shrink(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015,
                        ),
                        controller.isSendOtpLoad
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : controller.isSent
                                ? controller.isVerifyLoad
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30),
                                        child: kCustomButton(
                                            label: "Verify OTP",
                                            ontap: () {
                                              controller.verifyOtp();
                                            }),
                                      )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: kCustomButton(
                                        label: "Send OTP",
                                        ontap: () {
                                          log(Get.find<GetSTorageController>()
                                              .box
                                              .read(kPhone));
                                          controller.sendOTP(
                                              phoneNumber: Get.find<
                                                      GetSTorageController>()
                                                  .box
                                                  .read(kPhone),
                                              context: context);
                                        }),
                                  ),
                        AppComponents().sizedBox10,
                        controller.isSent
                            ? Center(
                                child: TextButton(
                                  onPressed: () async {
                                    await controller.resendOtp();
                                  },
                                  child: Text("Resend code"),
                                ),
                              )
                            : SizedBox.shrink(),
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
