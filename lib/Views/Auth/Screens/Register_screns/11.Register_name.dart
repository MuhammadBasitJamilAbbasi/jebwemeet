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
              AppComponents().backIcon(() {
                controller.setRegisterViewPage(RegisterViewEnum.RegisterView6);
              }),
              AppComponents().sizedBox50,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "My username is",
                  style: k25styleblack,
                ),
              ),
              AppComponents().sizedBox50,
              Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: kCustomTextField(
                    hinttext: "johndoe",
                    labeltext: "username",
                    controller: controller.nameController,
                    validator: (value) {
                      return "";
                    }),
              )),
              AppComponents().sizedBox30,
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: kAppButton(
                    buttonText: "Continue",
                    onButtonPressed: () async {
                      if (controller.nameController.value.text.isNotEmpty &&
                          controller.nameController.value.text.contains(" ") ==
                              false) {
                        if (controller.userNamesList.contains(
                                controller.nameController.value.text.trim()) ==
                            false) {
                          Get.find<GetSTorageController>().box.write(kFull_name,
                              controller.nameController.value.text.trim());
                          if (Get.find<GetSTorageController>()
                                  .box
                                  .read("isPhone") ==
                              "isPhone") {
                            await controller.addUserdetails();
                          } else
                            await controller.addUserdetails();
                        } else {
                          snackBar(context, "Please Enter another username",
                              Colors.pink);
                        }
                      } else {
                        snackBar(context, "Please Enter username without space",
                            Colors.pink);
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
