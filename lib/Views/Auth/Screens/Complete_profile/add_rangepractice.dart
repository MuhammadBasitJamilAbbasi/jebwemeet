import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/Profile_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/completeProfile/view/completeprofilescreen.dart';


class Add_RangePractice extends StatelessWidget {
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
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "How Religious are you?",
                      style: k25styleblack,
                    ),
                  ),
                  AppComponents().sizedBox40,
                  Center(
                    child: buildRegisterDropDown(
                        text: "Please Select",
                        list: kPractisingList!,
                        value: controller.selectedPractisingStatus,
                        onchange: (value) {
                          controller.selectedPractisingFunction(value);
                        },
                        controller: controller),
                  ),
                  AppComponents().sizedBox20,
                  controller.selectedPractisingStatus != "Please Select"
                      ? Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child:  kAppButton(
                        buttonText: "Save",
                        buttonstyleSmall: true,
                        onButtonPressed: () {
                          Get.find<GetSTorageController>().box.write(
                              kReligiousPractice,
                              controller.selectedPractisingStatus.toString());
                          Get.off(() => Complete_Profile1());
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
