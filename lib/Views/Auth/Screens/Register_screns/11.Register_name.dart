import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Utils/enums.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';

class Register_Name extends StatelessWidget {
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
                  "My full name is",
                  style: k25styleblack,
                ),
              ),
              AppComponents().sizedBox50,
              Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: kCustomTextField(
                    hinttext: "Full name",
                    controller: controller.nameController,
                    validator: (value) {
                      return "";
                    }),
              )),
              AppComponents().sizedBox15,
              controller.nameController.value.text.isNotEmpty
                  ? Center(
                      child: kCustomButton(
                        label: "Continue",
                        ontap: () {
                          if (controller.nameController.value.text.isNotEmpty) {
                            Get.find<GetSTorageController>().box.write(
                                kFull_name,
                                controller.nameController.value.text);
                            controller.setRegisterViewPage(
                                RegisterViewEnum.RegisterView12);
                          } else {
                            snackBar(
                                context, "Please Enter your Name", Colors.pink);
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
