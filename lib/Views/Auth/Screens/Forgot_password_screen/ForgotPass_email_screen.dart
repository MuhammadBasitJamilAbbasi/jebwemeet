import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';

class ForgetPasswordEmail_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<RegisterController>(
          init: RegisterController(),
          builder: (resetController) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: resetController.resetFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppComponents().sizedBox30,
                      AppComponents().backIcon(() {
                        Get.back();
                      }),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 25),
                        width: double.infinity,
                        child: Text('Enter the email to reset the password',
                            style: k25styleblack),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: kCustomTextField(
                            hinttext: "johndoe@gmail.com",
                            controller: resetController.resetemailController,
                            validator: (value) {
                              return resetController.validateEmail(value);
                            }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      resetController.isResetLoad
                          ? Center(child: CircularProgressIndicator.adaptive())
                          : Center(
                              child: kCustomButton(
                                  label: "Continue",
                                  ontap: () async {
                                    if (resetController
                                        .resetFormKey.currentState!
                                        .validate()) {
                                      //  await  resetController.resetPassword();
                                      // await sendOTP(context);
                                      await resetController
                                          .getNumberAndPassword(context);
                                      await resetController.sendOTP(
                                          phoneNumber: resetController.number,
                                          context: context);
                                    } else {}
                                  }),
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
