import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Utils/enums.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';

class Register_Creativity extends StatelessWidget {
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
                  "My Creativity",
                  style: k25styleblack,
                ),
              ),
              AppComponents().sizedBox50,
              Center(
                child: buildRegisterDropDown(
                    text: "Select Creativity",
                    list: kcreativityList!,
                    value: controller.selectedCreativity,
                    onchange: (value) {
                      controller.selectedCreativityFunction(value);
                    },
                    controller: controller),
              ),
              AppComponents().sizedBox30,
              controller.selectedCreativity != "Select Creativity"
                  ? Center(
                      child: kCustomButton(
                        label: "Continue",
                        ontap: () {
                          User? user = FirebaseAuth.instance.currentUser;
                          if (controller.selectedCreativity.toString() !=
                              "Select Creativity") {
                            Get.find<GetSTorageController>().box.write(
                                kCreativity,
                                controller.selectedCreativity.toString());
                            if (Get.find<GetSTorageController>()
                                    .box
                                    .read("isPhone") ==
                                "isPhone") {
                              controller.setRegisterViewPage(
                                  RegisterViewEnum.RegisterView10);
                            } else {
                              if (user == null) {
                                controller.setRegisterViewPage(
                                    RegisterViewEnum.RegisterView10);
                              } else {
                                controller.setRegisterViewPage(
                                    RegisterViewEnum.RegisterView12);
                              }
                            }
                          } else {
                            snackBar(context, "Please Select your creativity",
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
