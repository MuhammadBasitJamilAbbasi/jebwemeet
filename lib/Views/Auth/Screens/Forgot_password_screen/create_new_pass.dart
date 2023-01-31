import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';

class CreateNewPasswordView extends StatefulWidget {
  const CreateNewPasswordView({Key? key}) : super(key: key);

  @override
  State<CreateNewPasswordView> createState() => _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends State<CreateNewPasswordView> {
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
                key: controller.createPasswordKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
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
                        child: Text(
                            'Your new password must be different from previous used password',
                            style: k25styleblack),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
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
                            hintText: 'New Password',
                            suffixIcon: controller.isPasswordVisible == false
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
                        padding: EdgeInsets.symmetric(horizontal: 10),
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
                            suffixIcon: controller.isPasswordVisible == false
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
                        height: 30,
                      ),
                      controller.isUpdatePassLoad
                          ? Center(child: CircularProgressIndicator.adaptive())
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: kAppButton(
                                buttonText: 'Create New Password',
                                onButtonPressed: () async {
                                  if (controller.createPasswordKey.currentState!
                                      .validate()) {
                                    await controller.updatePassword(context);
                                  } else {}
                                },
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
