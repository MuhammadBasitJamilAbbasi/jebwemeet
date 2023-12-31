import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/Profile_Controller.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/completeProfile/view/completeprofilescreen.dart';


class Add_JobTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storageController = Get.find<GetSTorageController>();

    return Scaffold(body: GetBuilder<ProfileController>(
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
                      "Add Job Title",
                      style: k25styleblack,
                    ),
                  ),
                  AppComponents().sizedBox40,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: kCustomTextField(
                      labeltext: "Job Title",
                        hinttext: "Type here",
                        controller: controller.jobtitleController,
                        isValidator: false,
                        maxlines: 2,
                        validator: (val) {
                          return "";
                        }),
                  ),
                  AppComponents().sizedBox30,
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: kAppButton(
                        buttonText: "Save",
                        onButtonPressed: () {
                          if (controller
                              .jobtitleController.value.text.isNotEmpty) {
                            Get.find<GetSTorageController>().box.write(kJobTitle,
                                controller.jobtitleController.value.text);
                            Get.off(() => Complete_Profile1());
                          } else {
                            snackBar(context, "Please enter about job title",
                                Colors.pink);
                          }
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
