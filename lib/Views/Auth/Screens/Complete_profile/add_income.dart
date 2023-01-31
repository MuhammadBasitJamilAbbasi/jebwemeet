import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/completeProfile/view/completeprofilescreen.dart';


class Add_Income extends StatelessWidget {
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
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Text(
                          "My Income",
                          style: k25styleblack,
                        ),
                        Text(
                          "(per month)",
                          style: k14styleblack,
                        ),
                      ],
                    ),
                  ),
                  AppComponents().sizedBox50,
                  Center(
                    child: buildRegisterDropDown(
                        text: "Select income",
                        list: kIncomeList!,
                        value: controller.selectedIncome,
                        onchange: (value) {
                          controller.selectedIncomeFunction(value);
                        },
                        controller: controller),
                  ),
                  AppComponents().sizedBox30,
                  controller.selectedIncome != "Select income"
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: kAppButton(
                              buttonText: "Save",
                              buttonstyleSmall: true,
                              onButtonPressed: () {
                                if (controller.selectedIncome.toString() !=
                                    "Select income") {
                                  Get.find<GetSTorageController>().box.write(
                                      kIncome,
                                      controller.selectedIncome.toString());
                                  Get.off(() => Complete_Profile1());
                                } else {
                                  snackBar(context, "Please Select your income",
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
