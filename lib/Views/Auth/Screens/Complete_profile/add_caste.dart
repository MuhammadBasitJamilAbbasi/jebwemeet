import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/completeProfile/view/completeprofilescreen.dart';


class Add_Caste extends StatefulWidget {
  @override
  State<Add_Caste> createState() => _Add_CasteState();
}

class _Add_CasteState extends State<Add_Caste> {
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
                  AppComponents().sizedBox50,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "My Caste is",
                      style: k25styleblack,
                    ),
                  ),
                  AppComponents().sizedBox50,
                  Center(
                    child: buildRegisterDropDown(
                        text: "Select Caste",
                        list: kcasteList!,
                        value: controller.selectedValue,
                        onchange: (value) {
                          controller.selectedCasteFunction(value);
                        },
                        controller: controller),
                  ),
                  AppComponents().sizedBox30,
                  controller.selectedValue != "Select Caste"
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: kAppButton(
                              buttonText: "Save",
                                buttonstyleSmall: true,
                              onButtonPressed: () {
                                if (controller.selectedValue
                                        .toString()
                                        .isNotEmpty &&
                                    controller.selectedValue.toString() !=
                                        "Select Caste") {
                                  Get.find<GetSTorageController>().box.write(
                                      kCaste,
                                      controller.selectedValue.toString());
                                  Get.off(() => Complete_Profile1());
                                } else {
                                  snackBar(context, "Please Select your Caste",
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
