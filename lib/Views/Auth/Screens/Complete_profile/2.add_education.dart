import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/completeProfile/view/completeprofilescreen.dart';


class Add_Education extends StatelessWidget {
  const Add_Education({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storageController = Get.find<GetSTorageController>();
    if (Get.find<GetSTorageController>()
        .box
        .read(kEducation)
        .toString() ==
        "" ||
        Get.find<GetSTorageController>()
            .box
            .read(kEducation)
            .toString() ==
            "null") {
      Get.find<GetSTorageController>()
          .box
          .write(kEducation, "Bachelor’s degree");
    }
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppComponents().sizedBox30,
                AppComponents().backIcon(() {
                  Get.back();
                }),
                AppComponents().sizedBox20,
                Center(
                    child: Image.asset(
                  "assets/education.png",
                  height: 41,
                  width: 48,
                )),
                AppComponents().sizedBox10,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Center(
                    child: Text(
                      "Education",
                      style: k25styleblack,
                    ),
                  ),
                ),
                AppComponents().sizedBox50,
                Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: kAppButton(
                        buttonCheck: true,
                        color: Get.find<GetSTorageController>()
                            .box
                            .read(kEducation)
                            .toString() ==
                            "High School"
                            ? textcolor
                            : Colors.white,
                        textColor: Get.find<GetSTorageController>()
                            .box
                            .read(kEducation)
                            .toString() ==
                            "High School"
                            ? Colors.white
                            : Colors.black,
                  buttonText: "High School",
                  onButtonPressed: () {
                      storageController.box.write(kEducation, "High School");
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
                            .read(kEducation)
                            .toString() ==
                            "Diploma"
                            ? textcolor
                            : Colors.white,
                        textColor: Get.find<GetSTorageController>()
                            .box
                            .read(kEducation)
                            .toString() ==
                            "Diploma"
                            ? Colors.white
                            : Colors.black,
                  buttonText: "Diploma",
                  onButtonPressed: () {
                      storageController.box.write(kEducation, "Diploma");
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
                            .read(kEducation)
                            .toString() ==
                            "Bachelor’s degree"
                            ? textcolor
                            : Colors.white,
                        textColor: Get.find<GetSTorageController>()
                            .box
                            .read(kEducation)
                            .toString() ==
                            "Bachelor’s degree"
                            ? Colors.white
                            : Colors.black,
                  buttonText: "Bachelor’s degree",
                  onButtonPressed: () {
                      storageController.box
                          .write(kEducation, "Bachelor’s degree");
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
                            .read(kEducation)
                            .toString() ==
                            "Master’s degree"
                            ? textcolor
                            : Colors.white,
                        textColor: Get.find<GetSTorageController>()
                            .box
                            .read(kEducation)
                            .toString() ==
                            "Master’s degree"
                            ? Colors.white
                            : Colors.black,
                  buttonText: "Master’s degree",
                  onButtonPressed: () {
                      storageController.box.write(kEducation, "Master’s degree");
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
                            .read(kEducation)
                            .toString() ==
                            "PhD"
                            ? textcolor
                            : Colors.white,
                        textColor: Get.find<GetSTorageController>()
                            .box
                            .read(kEducation)
                            .toString() ==
                            "PhD"
                            ? Colors.white
                            : Colors.black,
                  buttonText: "PhD",
                  onButtonPressed: () {
                      storageController.box.write(kEducation, "PhD");
                      Get.off(() => Complete_Profile1());
                  },

                ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
