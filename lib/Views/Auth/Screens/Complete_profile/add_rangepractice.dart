import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/Profile_Controller.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/completeProfile/view/completeprofilescreen.dart';


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
                  AppComponents().backIcon(() {
                    Get.back();
                  }),
                  AppComponents().sizedBox20,
                  AppComponents().sizedBox10,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "Add Religious Practice",
                      style: k25styleblack,
                    ),
                  ),
                  AppComponents().sizedBox40,
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 6.0,
                      activeTickMarkColor: textcolor,
                      inactiveTickMarkColor: Colors.grey.shade300,
                      trackShape: RoundedRectSliderTrackShape(),
                      activeTrackColor: textcolor,
                      inactiveTrackColor: Colors.grey.shade300,
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 14.0,
                        pressedElevation: 8.0,
                      ),
                      thumbColor: textcolor,
                      overlayColor: Colors.pink.withOpacity(0.2),
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 32.0),

                      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                      valueIndicatorColor: textcolor,
                      valueIndicatorTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    child: Slider(
                      value: controller.selectedReligiousPractice,
                      onChanged: (value) {
                        controller.selectedReligiousPracticeFunction(value);
                      },
                      min: 0,
                      max: 100,
                      divisions: 4,
                      autofocus: true,
                      label: controller.selectedReligiousPractice
                              .round()
                              .toString() +
                          "%",
                    ),
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
                              kReligiousPractice,
                              controller.selectedReligiousPractice.toString() +
                                  "%");
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
