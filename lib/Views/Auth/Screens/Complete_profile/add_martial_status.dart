import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/1.Complete_profile_screen.dart';

class Add_Martial extends StatelessWidget {
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
                    Get.off(() => Complete_Profile1());
                  },
                  isRegister: true,
                )),
                AppComponents().sizedBox15,
                Center(
                    child: kCustomButton(
                  label: "Divorced",
                  ontap: () {
                    storageController.box.write(kMartial_Statius, "Divorced");
                    Get.off(() => Complete_Profile1());
                  },
                  isRegister: true,
                )),
                AppComponents().sizedBox15,
                Center(
                    child: kCustomButton(
                  label: "Seperated",
                  ontap: () {
                    storageController.box.write(kMartial_Statius, "Seperated");
                    Get.off(() => Complete_Profile1());
                  },
                  isRegister: true,
                )),
                AppComponents().sizedBox15,
                Center(
                    child: kCustomButton(
                  label: "Annulled",
                  ontap: () {
                    storageController.box.write(kMartial_Statius, "Annulled");
                    Get.off(() => Complete_Profile1());
                  },
                  isRegister: true,
                )),
                AppComponents().sizedBox15,
                Center(
                    child: kCustomButton(
                  label: "Widowed",
                  ontap: () {
                    storageController.box.write(kMartial_Statius, "Widowed");
                    Get.off(() => Complete_Profile1());
                  },
                  isRegister: true,
                )),
                AppComponents().sizedBox30,
              ],
            ),
          ),
        );
      }),
    );
  }
}
