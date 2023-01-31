import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/completeProfile/view/completeprofilescreen.dart';

class Add_Martial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storageController = Get.find<GetSTorageController>();
    return Scaffold(
      body: GetBuilder<RegisterController>(builder: (controller) {
        if (Get.find<GetSTorageController>()
                    .box
                    .read(kMartial_Statius)
                    .toString() ==
                "" ||
            Get.find<GetSTorageController>()
                    .box
                    .read(kMartial_Statius)
                    .toString() ==
                "null") {
          Get.find<GetSTorageController>()
              .box
              .write(kMartial_Statius, "Never Married");
        }
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppComponents().sizedBox50,
                AppComponents().backIcon(() {
                  Get.off(() => Complete_Profile1());
                }),
                AppComponents().sizedBox40,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "My maritial\nstatus is",
                    style: k25styleblack,
                  ),
                ),
                AppComponents().sizedBox30,
                Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: kAppButton(
                    buttonCheck: true,
                    color: Get.find<GetSTorageController>()
                                .box
                                .read(kMartial_Statius)
                                .toString() ==
                            "Never Married"
                        ? textcolor
                        : Colors.white,
                    textColor: Get.find<GetSTorageController>()
                                .box
                                .read(kMartial_Statius)
                                .toString() ==
                            "Never Married"
                        ? Colors.white
                        : Colors.black,
                    buttonText: "Never Married",
                    onButtonPressed: () {
                      storageController.box
                          .write(kMartial_Statius, "Never Married");
                      Get.off(() => Complete_Profile1());
                    },
                  ),
                )),
                AppComponents().sizedBox15,
                Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: kAppButton(
                    buttonCheck: true,
                    color: Get.find<GetSTorageController>()
                                .box
                                .read(kMartial_Statius)
                                .toString() ==
                            "Divorced"
                        ? textcolor
                        : Colors.white,
                    textColor: Get.find<GetSTorageController>()
                                .box
                                .read(kMartial_Statius)
                                .toString() ==
                            "Divorced"
                        ? Colors.white
                        : Colors.black,
                    buttonText: "Divorced",
                    onButtonPressed: () {
                      storageController.box.write(kMartial_Statius, "Divorced");
                      Get.off(() => Complete_Profile1());
                    },
                  ),
                )),
                AppComponents().sizedBox15,
                Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: kAppButton(
                    buttonCheck: true,
                    color: Get.find<GetSTorageController>()
                                .box
                                .read(kMartial_Statius)
                                .toString() ==
                            "Seperated"
                        ? textcolor
                        : Colors.white,
                    textColor: Get.find<GetSTorageController>()
                                .box
                                .read(kMartial_Statius)
                                .toString() ==
                            "Seperated"
                        ? Colors.white
                        : Colors.black,
                    buttonText: "Seperated",
                    onButtonPressed: () {
                      storageController.box
                          .write(kMartial_Statius, "Seperated");
                      Get.off(() => Complete_Profile1());
                    },
                  ),
                )),
                AppComponents().sizedBox15,
                Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: kAppButton(
                    buttonCheck: true,
                    color: Get.find<GetSTorageController>()
                                .box
                                .read(kMartial_Statius)
                                .toString() ==
                            "Annulled"
                        ? textcolor
                        : Colors.white,
                    textColor: Get.find<GetSTorageController>()
                                .box
                                .read(kMartial_Statius)
                                .toString() ==
                            "Annulled"
                        ? Colors.white
                        : Colors.black,
                    buttonText: "Annulled",
                    onButtonPressed: () {
                      storageController.box.write(kMartial_Statius, "Annulled");
                      Get.off(() => Complete_Profile1());
                    },
                  ),
                )),
                AppComponents().sizedBox15,
                Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: kAppButton(
                    buttonCheck: true,
                    color: Get.find<GetSTorageController>()
                                .box
                                .read(kMartial_Statius)
                                .toString() ==
                            "Widowed"
                        ? textcolor
                        : Colors.white,
                    textColor: Get.find<GetSTorageController>()
                                .box
                                .read(kMartial_Statius)
                                .toString() ==
                            "Widowed"
                        ? Colors.white
                        : Colors.black,
                    buttonText: "Widowed",
                    onButtonPressed: () {
                      storageController.box.write(kMartial_Statius, "Widowed");
                      Get.off(() => Complete_Profile1());
                    },
                  ),
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
