import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/completeProfile/view/completeprofilescreen.dart';


class Add_Religion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: SafeArea(
        child: GetBuilder<RegisterController>(builder: (controller) {
          // if(Get.find<GetSTorageController>()
          //     .box
          //     .read(kReligion).toString()==""|| Get.find<GetSTorageController>()
          //     .box
          //     .read(kReligion).toString()=="null") {
          //   Get
          //       .find<GetSTorageController>()
          //       .box
          //       .write(kReligion, "Sunni");
          // }
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppComponents().sizedBox30,
                  AppComponents().backIcon(() {
                    Get.back();
                  }),
                  AppComponents().sizedBox30,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "My religion is",
                      style: k25styleblack,
                    ),
                  ),
                  AppComponents().sizedBox50,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),                child: Center(
                      child: kAppButton(
                        buttonCheck: true,
                        color: Get.find<GetSTorageController>()
                            .box
                            .read(kReligion)
                            .toString() ==
                            "Muslim Sunni"
                            ? textcolor
                            : Colors.white,
                        textColor: Get.find<GetSTorageController>()
                            .box
                            .read(kReligion)
                            .toString() ==
                            "Muslim Sunni"
                            ? Colors.white
                            : Colors.black,
                        buttonText: "Muslim Sunni",
                        onButtonPressed: () {
                          Get.find<GetSTorageController>().box.write(kReligion, "Muslim Sunni");
                          Get.off(() => Complete_Profile1());
                        },

                      )),
                  ),

                  AppComponents().sizedBox15,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Center(
                        child: kAppButton(
                          buttonCheck: true,
                          color: Get.find<GetSTorageController>()
                              .box
                              .read(kReligion)
                              .toString() ==
                              "Muslim Shia"
                              ? textcolor
                              : Colors.white,
                          textColor: Get.find<GetSTorageController>()
                              .box
                              .read(kReligion)
                              .toString() ==
                              "Muslim Shia"
                              ? Colors.white
                              : Colors.black,
                          buttonText: "Muslim Shia",
                          onButtonPressed: () {
                            Get.find<GetSTorageController>().box.write(kReligion, "Muslim Shia");
                            Get.off(() => Complete_Profile1());

                          },

                        )),
                  ),
                  AppComponents().sizedBox15,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),                child: Center(
                      child: kAppButton(
                        buttonText: "Christian",
                        buttonCheck: true,
                        color: Get.find<GetSTorageController>()
                            .box
                            .read(kReligion)
                            .toString() ==
                            "Christian"
                            ? textcolor
                            : Colors.white,
                        textColor: Get.find<GetSTorageController>()
                            .box
                            .read(kReligion)
                            .toString() ==
                            "Christian"
                            ? Colors.white
                            : Colors.black,
                        onButtonPressed: () {
                          Get.find<GetSTorageController>().box.write(kReligion, "Christian");
                          Get.off(() => Complete_Profile1());

                        },

                      )),
                  ),
                  AppComponents().sizedBox15,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),                child: Center(
                      child: kAppButton(
                        buttonText: "Hindu",
                        buttonCheck: true,
                        color: Get.find<GetSTorageController>()
                            .box
                            .read(kReligion)
                            .toString() ==
                            "Hindu"
                            ? textcolor
                            : Colors.white,
                        textColor: Get.find<GetSTorageController>()
                            .box
                            .read(kReligion)
                            .toString() ==
                            "Hindu"
                            ? Colors.white
                            : Colors.black,
                        onButtonPressed: () {
                          Get.find<GetSTorageController>().box.write(kReligion, "Hindu");
                          Get.off(() => Complete_Profile1());

                        },

                      )),
                  ),
                  AppComponents().sizedBox15,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),                child: Center(
                      child: kAppButton(
                        buttonText: "Ahmadi",
                        buttonCheck: true,
                        color: Get.find<GetSTorageController>()
                            .box
                            .read(kReligion)
                            .toString() ==
                            "Ahmadi"
                            ? textcolor
                            : Colors.white,
                        textColor: Get.find<GetSTorageController>()
                            .box
                            .read(kReligion)
                            .toString() ==
                            "Ahmadi"
                            ? Colors.white
                            : Colors.black,
                        onButtonPressed: () {
                          Get.find<GetSTorageController>().box.write(kReligion, "Ahmadi");
                          Get.off(() => Complete_Profile1());

                        },

                      )),
                  ),
                  AppComponents().sizedBox15,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),                child: Center(
                      child: kAppButton(
                        buttonText: "Sikh",
                        buttonCheck: true,
                        color: Get.find<GetSTorageController>()
                            .box
                            .read(kReligion)
                            .toString() ==
                            "Sikh"
                            ? textcolor
                            : Colors.white,
                        textColor: Get.find<GetSTorageController>()
                            .box
                            .read(kReligion)
                            .toString() ==
                            "Sikh"
                            ? Colors.white
                            : Colors.black,
                        onButtonPressed: () {
                          Get.find<GetSTorageController>().box.write(kReligion, "Sikh");
                          Get.off(() => Complete_Profile1());

                        },

                      )),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );

  }
}
