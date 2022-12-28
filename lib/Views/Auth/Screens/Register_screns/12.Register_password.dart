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
      return Form(
        key: controller.createPasswordKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                Get.find<GetSTorageController>().box.read("isPhone") ==
                        "isPhone"
                    ? Column(
                        children: [
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
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: textField(
                                maxlines: 1,
                                borderColor: Colors.grey,
                                isPassword: controller.isPasswordVisible == true
                                    ? true
                                    : false,
                                inputType: TextInputType.text,
                                validation: (value) {
                                  return controller.validatePassword(value);
                                },
                                controller: controller.passController,
                                hintText: 'Password',
                                suffixIcon:
                                    controller.isPasswordVisible == false
                                        ? IconButton(
                                            onPressed: () {
                                              controller.passwordVisibility();
                                            },
                                            icon: (Icon(
                                              Icons.visibility,
                                              color: butoncolor,
                                            )))
                                        : IconButton(
                                            onPressed: () {
                                              controller.passwordVisibility();
                                            },
                                            icon: Icon(
                                              Icons.visibility_off,
                                              color: Colors.pink,
                                            ),
                                          )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: textField(
                                maxlines: 1,
                                borderColor: Colors.grey,
                                isPassword: controller.isPasswordVisible == true
                                    ? true
                                    : false,
                                inputType: TextInputType.text,
                                validation: (value) {
                                  return controller.validateConfPassword(value);
                                },
                                controller: controller.ConfirmPassController,
                                hintText: 'Confirm password',
                                suffixIcon:
                                    controller.isPasswordVisible == false
                                        ? IconButton(
                                            onPressed: () {
                                              controller.passwordVisibility();
                                            },
                                            icon: (Icon(
                                              Icons.visibility,
                                              color: butoncolor,
                                            )))
                                        : IconButton(
                                            onPressed: () {
                                              controller.passwordVisibility();
                                            },
                                            icon: Icon(
                                              Icons.visibility_off,
                                              color: butoncolor,
                                            ),
                                          )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                controller.isUpdatePassLoad
                    ? Center(child: CircularProgressIndicator.adaptive())
                    : controller.loading
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
                                        controller
                                            .passwordController.value.text);
                                    await controller.register(context);
                                  } else {
                                    snackBar(
                                        context,
                                        "Please enter your 6 character password ",
                                        Colors.pink);
                                  }
                                } else {
                                  if (controller.createPasswordKey.currentState!
                                      .validate()) {
                                    await controller
                                        .updatePasswordRegister(context)
                                        .then((value) async {
                                      Get.find<GetSTorageController>()
                                          .box
                                          .write(
                                              kPassword,
                                              controller.ConfirmPassController
                                                  .value.text);
                                      await controller.addUserdetails();
                                    });
                                  }
                                }
                              },
                              isRegister: true,
                            ),
                          )
              ],
            ),
          ),
        ),
      );
    });
  }
}
