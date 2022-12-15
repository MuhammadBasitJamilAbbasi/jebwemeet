import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/Profile_Controller.dart';

class Add_About extends StatelessWidget {
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
                  AppComponents().backIcon(),
                  AppComponents().sizedBox20,
                  AppComponents().sizedBox10,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "About me",
                      style: k25styleblack,
                    ),
                  ),
                  AppComponents().sizedBox40,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: kCustomTextField(
                        hinttext: "Add about me",
                        controller: controller.aboutController,
                        isValidator: false,
                        maxlines: 7,
                        validator: (val) {
                          return "";
                        }),
                  ),
                  AppComponents().sizedBox30,
                  Center(
                    child: kCustomButton(
                      label: "Save",
                      ontap: () {
                        if (controller.aboutController.value.text.isNotEmpty) {
                          Get.find<GetSTorageController>().box.write(
                              kAbout, controller.aboutController.value.text);
                          controller.aboutController.clear();
                          Get.back();
                        } else {
                          snackBar(context, "Please enter about yourself",
                              Colors.pink);
                        }
                      },
                      isRegister: true,
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
