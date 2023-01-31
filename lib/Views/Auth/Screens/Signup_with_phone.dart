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
        body:  SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Container(
                height: Get.height,
                width: Get.width,
                padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.height * 0.030,
                  MediaQuery.of(context).size.height * 0.06,
                  MediaQuery.of(context).size.height * 0.025,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppComponents().backIcon(() {
                      Get.back();
                    }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.065,
                    ),
                    Text(
                      "My Mobile",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    AppComponents().sizedBox10,
                    Text("Please enter your valid phone number. We will send you a 4-digit code to verify your account. ",style: TextStyle(
                      fontWeight: FontWeight.w400,fontSize: 14,color: Colors.black
                    ),),
                    AppComponents().sizedBox50,
                    Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            child: IntlPhoneField(
                              showDropdownIcon: false,
                              autofocus: false,
                              flagsButtonMargin: EdgeInsets.only(left: 10),
                              style:
                              TextStyle(
                                  color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                filled: true,
                               isCollapsed: true,

                                contentPadding: EdgeInsets.only(
                                    top: 20, bottom: 20, left: 1),
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300,width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        color: textcolor)),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300,width: 1)),
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
        GetBuilder<LoginController>(
          builder: (controller) {
            return
              controller.isSendOtpLoad
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20),
                child: kAppButton(
                    buttonText: "Send OTP",
                    onButtonPressed: () {
                      log(Get
                          .find<GetSTorageController>()
                          .box
                          .read(kPhone));
                      controller.sendOTP(
                          phoneNumber: Get
                              .find<
                              GetSTorageController>()
                              .box
                              .read(kPhone),
                          context: context);
                    }),
              );
          })
                  ],
                ),
              ),
        ));
  }
}
