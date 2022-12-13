import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Utils/enums.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';

class Register_Age extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (controller) {
      return SingleChildScrollView(
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
                    "My age is",
                    style: k25styleblack,
                  ),
                ),
                AppComponents().sizedBox50,
                Center(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: kCustomTextField(
                      hinttext: "Age",
                      isLength: true,
                      controller: controller.ageController,
                      validator: (value) {
                        return "";
                      }),
                )),
                AppComponents().sizedBox15,
                controller.ageController.value.text.isNotEmpty
                    ? Center(
                        child: kCustomButton(
                          label: "Continue",
                          ontap: () {
                            if (controller
                                .ageController.value.text.isNotEmpty) {
                              Get.find<GetSTorageController>().box.write(
                                  kAge, controller.ageController.value.text);
                              controller.setRegisterViewPage(
                                  RegisterViewEnum.RegisterView4);
                            } else {
                              snackBar(context, "Please Enter your age",
                                  Colors.pink);
                            }
                          },
                          isRegister: true,
                        ),
                      )
                    : SizedBox.shrink()
              ],
            ),
          ));
    });
  }
}
