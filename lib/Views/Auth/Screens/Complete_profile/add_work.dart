import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/Profile_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/completeProfile/view/completeprofilescreen.dart';


class Add_Work extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storageController = Get.find<GetSTorageController>();
    final profileController = Get.find<ProfileController>();
    return Scaffold(body: GetBuilder<RegisterController>(
      builder: (controller) {
        return SafeArea(
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
                  AppComponents().sizedBox10,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "My Occupation Sector is",
                      style: k25styleblack,
                    ),
                  ),
                  AppComponents().sizedBox50,
                  Center(
                    child: buildRegisterDropDown(
                        text: "Select Occupation Sector",
                        list: kWorkList!,
                        value: controller.selectedwork,
                        onchange: (value) {
                          controller.selectedWorkFunction(value);
                        },
                        controller: controller),
                  ),
                  AppComponents().sizedBox30,
                  controller.selectedwork != "Select Occupation Sector"
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: kAppButton(
                              buttonText: "Save",
                              onButtonPressed: () {
                                if (controller.selectedwork.toString() !=
                                    "Select Occupation Sector") {
                                  storageController.box.write(
                                      kWork, controller.selectedwork.toString());
                                  Get.off(() => Complete_Profile1());
                                } else {
                                  snackBar(
                                      context,
                                      "Please Select your Occupation Sector",
                                      Colors.pink);
                                }
                              },
                            ),
                          ),
                        )
                      : SizedBox.shrink()
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
