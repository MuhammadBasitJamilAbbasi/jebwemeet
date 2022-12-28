import 'package:flutter/cupertino.dart';
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
                    "My Birthday is",
                    style: k25styleblack,
                  ),
                ),
                AppComponents().sizedBox50,
                Center(
                  child: kCustomButton(
                      ontap: () {
                        controller.datePicker(context);
                      },
                      label: controller.birthdayDate.value),
                ),
                AppComponents().sizedBox15,
                controller.birthdayDate.value != "Select date"
                    ? Center(
                        child: kCustomButton(
                          label: "Continue",
                          ontap: () {
                            controller.setRegisterViewPage(
                                RegisterViewEnum.RegisterView4);
                            Get.find<GetSTorageController>().box.write(
                                kAge, controller.birthdayDate.value.toString());
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
