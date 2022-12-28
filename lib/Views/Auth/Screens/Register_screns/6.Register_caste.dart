import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Utils/enums.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';

class Register_caste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppComponents().backIcon(),
              AppComponents().sizedBox50,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
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
                      child: kCustomButton(
                        label: "Continue",
                        ontap: () {
                          if (controller.selectedValue.toString().isNotEmpty &&
                              controller.selectedValue.toString() !=
                                  "Select Caste") {
                            Get.find<GetSTorageController>().box.write(
                                kCaste, controller.selectedValue.toString());
                            controller.getAllEmails(context);
                            controller.setRegisterViewPage(
                                RegisterViewEnum.RegisterView10);
                          } else {
                            snackBar(context, "Please Select your Caste",
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
      );
    });
  }
}
