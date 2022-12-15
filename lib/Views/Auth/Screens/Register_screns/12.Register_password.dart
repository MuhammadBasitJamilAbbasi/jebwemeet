import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';

class Register_Password extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppComponents().backIcon(),
              AppComponents().sizedBox50,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "My password will be",
                  style: k25styleblack,
                ),
              ),
              AppComponents().sizedBox50,
              Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Obx(() {
                  return kPasswordTextField(
                    isObsecure: controller.hidePassword.value,
                    controller: controller.passwordController,
                    hintText: "Password",
                    validator: (val) {
                      return controller.validatePassword(val!);
                    },
                    onpress: () {
                      controller.hidePassword.value =
                          !controller.hidePassword.value;
                    },
                  );
                }),
              )),
              AppComponents().sizedBox30,
              controller.passwordController.value.text.isNotEmpty
                  ? controller.loading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: butoncolor,
                          ),
                        )
                      : Center(
                          child: kCustomButton(
                            label: "Continue",
                            ontap: () async {
                              if (FirebaseAuth.instance.currentUser == null) {
                                if (controller.passwordController.value.text
                                        .isNotEmpty &&
                                    controller.passwordController.value.text
                                            .length >=
                                        6) {
                                  Get.find<GetSTorageController>().box.write(
                                      kPassword,
                                      controller.passwordController.value.text);
                                  controller.register(context);
                                } else {
                                  snackBar(
                                      context,
                                      "Please enter your 6 character password ",
                                      Colors.pink);
                                }
                              } else {
                                Get.find<GetSTorageController>().box.write(
                                    kPassword,
                                    controller.passwordController.value.text);
                                await controller.addUserdetails();
                              }
                            },
                            isRegister: true,
                          ),
                        )
                  : SizedBox.shrink()
            ],
          ),
        ),
      );
    });
  }
}
