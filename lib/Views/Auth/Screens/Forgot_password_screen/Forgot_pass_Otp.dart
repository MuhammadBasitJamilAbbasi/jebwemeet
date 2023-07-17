
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/LoginController.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';
import 'package:jabwemeet/Views/Auth/Screens/Forgot_password_screen/create_new_pass.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class ForgetPassword_OTP_view extends StatefulWidget {
  @override
  State<ForgetPassword_OTP_view> createState() => _ForgetPassword_OTP_viewState();
}

class _ForgetPassword_OTP_viewState extends State<ForgetPassword_OTP_view> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: Get.height,
            width: Get.width,
            padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.height * 0.030,
              MediaQuery.of(context).size.height * 0.06,
              MediaQuery.of(context).size.height * 0.025,
              0,
            ),
            child: GetBuilder<RegisterController>(builder: (controller) {
              return OtpPinField(
                otpPinFieldInputType: OtpPinFieldInputType.none,

                showCustomKeyboard: true,
                upperChild: Column(
                  children: [
                    AppComponents().backIcon(() {
                      Get.back();
                    }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.065,
                    ),
                    _isResendAgain
                        ? Center(
                      child: Text(
                        "00:" + _start.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    )
                        : Text(""),
                    AppComponents().sizedBox10,
                    Center(
                      child: Text(
                        "Type the verification code\n we’ve sent you ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                    ),
                    AppComponents().sizedBox50,
                  ],
                ),
                middleChild: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          if (_isResendAgain) return;
                          resend();
                          print(_start
                              .toString()); //the value is 60 when it being printed
                          print(
                              _isResendAgain); // the value is true when it being printed
                        },
                        child: Text(
                          _isResendAgain
                              ? "Try again in " + _start.toString()
                              : "Resend OTP",
                          style: TextStyle(color: textcolor,fontWeight: FontWeight.w600),
                        ))
                  ],
                ),
                onChange: (value) {
                  // if (value.length == 6) {
                  //   controller.getotp(value,context);
                  // }
                },
                onSubmit: (text) {
                  if (text.length == 6) {
                    controller.getotpPassword(text);
                  }
                },
                otpPinFieldStyle: OtpPinFieldStyle(
                    defaultFieldBorderColor: Colors.grey.shade300,
                    activeFieldBorderColor: textcolor,
                    defaultFieldBackgroundColor: textcolor,
                    fieldBorderRadius: 15,
                    fieldBorderWidth: 0.3,
                    activeFieldBackgroundColor: textcolor,
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                maxLength: 6,
                highlightBorder: true,
                fieldWidth: 45,
                cursorColor: Colors.white,
                fieldHeight: 45,

                keyboardType: TextInputType.number,
                //  autoFocus: false, //want to open keyboard or not
                otpPinFieldDecoration:
                OtpPinFieldDecoration.defaultPinBoxDecoration,
              );
            }),
          ),
        ));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    const oneSec = Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_start == 0) {
          _start = 60;
          _isResendAgain = false;
          timer.cancel();
        } else {
          _start--;
        }
      });
    });
  }

  bool _isResendAgain = true;

  late Timer _timer;

  int _start = 60;

  void resend() {
    setState(() {
      _isResendAgain = true;
      Get.find<LoginController>().resendOtp();
    });

    const oneSec = Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_start == 0) {
          _start = 60;
          _isResendAgain = false;
          timer.cancel();
        } else {
          _start--;
        }
      });
    });
  }
}
