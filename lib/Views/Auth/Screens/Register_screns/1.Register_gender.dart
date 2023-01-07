import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Utils/enums.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';

class Register_Gender extends StatelessWidget {
  const Register_Gender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppComponents().backIcon(() {
                Get.back();
              }),
              AppComponents().sizedBox50,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "I am a",
                  style: k25styleblack,
                ),
              ),
              AppComponents().sizedBox50,
              Center(
                  child: kCustomButton(
                label: "Man",
                ontap: () {
                  Get.find<GetSTorageController>().box.write(kGender, "Man");
                  controller
                      .setRegisterViewPage(RegisterViewEnum.RegisterView3);
                },
                isRegister: true,
              )),
              AppComponents().sizedBox15,
              Center(
                  child: kCustomButton(
                label: "Woman",
                ontap: () {
                  Get.find<GetSTorageController>().box.write(kGender, "Woman");
                  controller
                      .setRegisterViewPage(RegisterViewEnum.RegisterView3);
                },
                isRegister: true,
              )),
            ],
          ),
        ),
      );
    });
  }
}
