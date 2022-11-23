import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Utils/enums.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';

class Register_Religion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storageController = Get.find<GetSTorageController>();

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
                  "My religion is",
                  style: k25styleblack,
                ),
              ),
              AppComponents().sizedBox50,
              Center(
                  child: kCustomButton(
                label: "Islam",
                ontap: () {
                  storageController.box.write(kReligion, "Islam");
                  controller
                      .setRegisterViewPage(RegisterViewEnum.RegisterView6);
                },
                isRegister: true,
              )),
              AppComponents().sizedBox15,
              Center(
                  child: kCustomButton(
                label: "Christianity",
                ontap: () {
                  storageController.box.write(kReligion, "Christianity");
                  controller
                      .setRegisterViewPage(RegisterViewEnum.RegisterView6);
                },
                isRegister: true,
              )),
              AppComponents().sizedBox15,
              Center(
                  child: kCustomButton(
                label: "Judaisim",
                ontap: () {
                  storageController.box.write(kReligion, "Judaisim");
                  controller
                      .setRegisterViewPage(RegisterViewEnum.RegisterView6);
                },
                isRegister: true,
              )),
              AppComponents().sizedBox15,
              Center(
                  child: kCustomButton(
                label: "Hinduism",
                ontap: () {
                  storageController.box.write(kReligion, "Hinduism");
                  controller
                      .setRegisterViewPage(RegisterViewEnum.RegisterView6);
                },
                isRegister: true,
              )),
              AppComponents().sizedBox15,
              Center(
                  child: kCustomButton(
                label: "Prefer not to say",
                ontap: () {
                  storageController.box.write(kReligion, "Prefer not to say");
                  controller
                      .setRegisterViewPage(RegisterViewEnum.RegisterView6);
                },
                isRegister: true,
              ))
            ],
          ),
        ),
      );
    });
  }
}
