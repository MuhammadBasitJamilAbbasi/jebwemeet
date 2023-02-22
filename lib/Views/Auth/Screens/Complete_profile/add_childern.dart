import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/completeProfile/view/completeprofilescreen.dart';


class Add_Childern extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storageController = Get.find<GetSTorageController>();

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
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "My Childern is",
                      style: k25styleblack,
                    ),
                  ),
                  AppComponents().sizedBox50,
                  Center(
                    child: buildRegisterDropDown(
                        text: "0",
                        list: kChildernList!,
                        value: controller.selectedChild,
                        onchange: (value) {
                          controller.selectedChildFunction(value);
                        },
                        controller: controller),
                  ),
                  AppComponents().sizedBox30,
                  Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: kAppButton(
                              buttonText: "Save",
                              buttonstyleSmall: true,
                              onButtonPressed: () {
                                  Get.find<GetSTorageController>().box.write(
                                      kchildern,
                                      controller.selectedChild.toString());
                                  Get.off(() => Complete_Profile1());
                              },
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
