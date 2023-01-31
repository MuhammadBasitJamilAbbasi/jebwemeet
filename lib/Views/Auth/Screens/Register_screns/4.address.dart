import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Utils/enums.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';

class Register_address extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppComponents().backIcon(() {
                controller.setRegisterViewPage(RegisterViewEnum.RegisterView2);
              }),
              AppComponents().sizedBox50,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "I live in",
                  style: kboldStyleHeading,
                ),
              ),
              AppComponents().sizedBox50,
              Center(
                child: buildRegisterDropDown(
                    text: "Select City",
                    list: kCityList!,
                    value: controller.selectedCity,
                    onchange: (value) {
                      controller.selectedCityFunction(value);
                    },
                    controller: controller),
              ),
              AppComponents().sizedBox30,
              controller.selectedCity != "Select City"
                  ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                        child: kAppButton(
                          buttonText: "Continue",
                         buttonstyleSmall: true,
                          onButtonPressed: () {
                            if (controller.selectedCity.toString().isNotEmpty &&
                                controller.selectedCity.toString() !=
                                    "Select City") {
                              Get.find<GetSTorageController>().box.write(
                                  kAddress, controller.selectedCity.toString());
                              controller.setRegisterViewPage(
                                  RegisterViewEnum.RegisterView4);
                            } else {
                              snackBar(context, "Please Select your City",
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
      );
    });
  }
}
