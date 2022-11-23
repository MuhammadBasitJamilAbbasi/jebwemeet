import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';
import 'package:jabwemeet/Views/Auth/Screens/Forgot_password_screen/create_new_pass.dart';

class ForgetPassword_OTP_view extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  const ForgetPassword_OTP_view(
      {Key? key, required this.phoneNumber, required this.verificationId})
      : super(key: key);

  @override
  State<ForgetPassword_OTP_view> createState() =>
      _ForgetPassword_OTP_viewState();
}

class _ForgetPassword_OTP_viewState extends State<ForgetPassword_OTP_view> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<RegisterController>(
          init: RegisterController(),
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: controller.resetPasswordFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppComponents().sizedBox30,
                      AppComponents().backIcon(),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 25),
                        width: double.infinity,
                        child: Text(
                            'Enter the 6-digit code we just texted to your phone number: ${widget.phoneNumber}',
                            style: k25styleblack),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
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
                              return controller.validateName(value);
                            },
                            controller: controller.otpController,
                            hintText: '6-digit code from SMS'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      controller.isVerifyLoad
                          ? Center(child: CircularProgressIndicator.adaptive())
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: kCustomButton2(
                                height: 50,
                                borderColor: Colors.transparent,
                                textStyle: controller.isCodeEntered
                                    ? TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500)
                                    : TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500),
                                title: 'Verify',
                                onPressed: () async {
                                  // Navigator.pushNamed(context, route.createNewPassword);
                                  if (controller
                                      .resetPasswordFormKey.currentState!
                                      .validate()) {
                                    await controller.verifyOtp();
                                    Get.to(() => CreateNewPasswordView());
                                    // resetController.verifyOTP(
                                    //     context, widget.verificationId);
                                  } else {}
                                },
                                primaryColor: controller.isCodeEntered
                                    ? butoncolor
                                    : Colors.grey.shade200,
                              ),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () async {
                            await controller.resendOtp();
                          },
                          child: Text("Resend code"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
