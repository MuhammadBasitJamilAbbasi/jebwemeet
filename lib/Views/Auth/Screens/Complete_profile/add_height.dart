import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/1.Complete_profile_screen.dart';

class Add_Height extends StatelessWidget {
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
                  AppComponents().backIcon(),
                  AppComponents().sizedBox20,
                  AppComponents().sizedBox10,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "My Height is",
                      style: k25styleblack,
                    ),
                  ),
                  AppComponents().sizedBox50,
                  Center(
                    child: buildRegisterDropDown(
                        text: "Select height",
                        list: kheightList!,
                        value: controller.selectedHeight,
                        onchange: (value) {
                          controller.selectedHeightFunction(value);
                        },
                        controller: controller),
                  ),
                  AppComponents().sizedBox30,
                  controller.selectedHeight != "Select height"
                      ? Center(
                          child: kCustomButton(
                            label: "Save",
                            ontap: () {
                              if (controller.selectedHeight.toString() !=
                                  "Select height") {
                                Get.find<GetSTorageController>().box.write(
                                    kHeight,
                                    controller.selectedHeight.toString());
                                Get.off(() => Complete_Profile1());
                              } else {
                                snackBar(context, "Please Select your height",
                                    Colors.pink);
                              }
                            },
                            isRegister: true,
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
