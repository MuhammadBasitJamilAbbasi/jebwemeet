import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Utils/enums.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';

class Register_Martial extends StatelessWidget {
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
                  "My maritial status is",
                  style: k25styleblack,
                ),
              ),
              AppComponents().sizedBox50,
              Center(
                  child: kCustomButton(
                label: "Never Married",
                ontap: () {
                  storageController.box
                      .write(kMartial_Statius, "Never Married");
                  controller
                      .setRegisterViewPage(RegisterViewEnum.RegisterView3);
                },
                isRegister: true,
              )),
              AppComponents().sizedBox15,
              Center(
                  child: kCustomButton(
                label: "Divorced",
                ontap: () {
                  storageController.box.write(kMartial_Statius, "Divorced");
                  controller
                      .setRegisterViewPage(RegisterViewEnum.RegisterView3);
                },
                isRegister: true,
              )),
              AppComponents().sizedBox15,
              Center(
                  child: kCustomButton(
                label: "Seperated",
                ontap: () {
                  storageController.box.write(kMartial_Statius, "Seperated");
                  controller
                      .setRegisterViewPage(RegisterViewEnum.RegisterView3);
                },
                isRegister: true,
              )),
              AppComponents().sizedBox15,
              Center(
                  child: kCustomButton(
                label: "Annulled",
                ontap: () {
                  storageController.box.write(kMartial_Statius, "Annulled");
                  controller
                      .setRegisterViewPage(RegisterViewEnum.RegisterView3);
                },
                isRegister: true,
              )),
              AppComponents().sizedBox15,
              Center(
                  child: kCustomButton(
                label: "Widowed",
                ontap: () {
                  storageController.box.write(kMartial_Statius, "Widowed");
                  controller
                      .setRegisterViewPage(RegisterViewEnum.RegisterView3);
                },
                isRegister: true,
              )),
              AppComponents().sizedBox30,
            ],
          ),
        ),
      );
    });
  }
}
