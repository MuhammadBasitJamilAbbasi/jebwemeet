import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/Profile_Controller.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/1.Complete_profile_screen.dart';

class Add_RangePractice extends StatelessWidget {
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
                      "Add Religious Practice",
                      style: k25styleblack,
                    ),
                  ),
                  AppComponents().sizedBox40,
                  Slider(
                    value: controller.selectedReligiousPractice,
                    onChanged: (value) {
                      controller.selectedReligiousPracticeFunction(value);
                    },
                    min: 0,
                    max: 100,
                    divisions: 4,
                    autofocus: true,
                    thumbColor: Colors.deepOrange,
                    label: controller.selectedReligiousPractice
                            .round()
                            .toString() +
                        "%",
                  ),
                  AppComponents().sizedBox30,
                  Center(
                    child: kCustomButton(
                      label: "Save",
                      ontap: () {
                        Get.find<GetSTorageController>().box.write(
                            kReligiousPractice,
                            controller.selectedReligiousPractice.toString() +
                                "%");
                        Get.off(() => Complete_Profile1());
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
