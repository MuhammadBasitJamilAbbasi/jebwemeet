import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/1.Complete_profile_screen.dart';

class Add_Religion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storageController = Get.find<GetSTorageController>();

    return Scaffold(
      body: GetBuilder<RegisterController>(builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppComponents().sizedBox50,
                AppComponents().backIcon(() {
                  Get.back();
                }),
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
                  label: "Shia",
                  ontap: () {
                    storageController.box.write(kReligion, "Shia");
                    Get.off(() => Complete_Profile1());
                  },
                  isRegister: true,
                )),
                AppComponents().sizedBox15,
                Center(
                    child: kCustomButton(
                  label: "Sunni",
                  ontap: () {
                    storageController.box.write(kReligion, "Sunni");
                    Get.off(() => Complete_Profile1());
                  },
                  isRegister: true,
                )),
                AppComponents().sizedBox15,
                Center(
                    child: kCustomButton(
                  label: "Christian",
                  ontap: () {
                    storageController.box.write(kReligion, "Christian");
                    Get.off(() => Complete_Profile1());
                  },
                  isRegister: true,
                )),
                AppComponents().sizedBox15,
                Center(
                    child: kCustomButton(
                  label: "Hindu",
                  ontap: () {
                    storageController.box.write(kReligion, "Hindu");
                    Get.off(() => Complete_Profile1());
                  },
                  isRegister: true,
                )),
                AppComponents().sizedBox15,
                Center(
                    child: kCustomButton(
                  label: "Ahmadi",
                  ontap: () {
                    storageController.box.write(kReligion, "Ahmadi");
                    Get.off(() => Complete_Profile1());
                  },
                  isRegister: true,
                )),
                AppComponents().sizedBox15,
                Center(
                    child: kCustomButton(
                  label: "Sikh",
                  ontap: () {
                    storageController.box.write(kReligion, "Sikh");
                    Get.off(() => Complete_Profile1());
                  },
                  isRegister: true,
                ))
              ],
            ),
          ),
        );
      }),
    );
  }
}
