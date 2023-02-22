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
      if(Get.find<GetSTorageController>()
          .box
          .read(kGender).toString()=="" || Get.find<GetSTorageController>()
          .box
          .read(kGender).toString()=="null") {
        Get.find<GetSTorageController>()
            .box
            .write(kGender,"Male");
      }

      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppComponents().backIcon(() {
                Get.back();
              },),
              AppComponents().sizedBox30,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "I am a",
                  style: kboldStyleHeading,
                ),
              ),
              AppComponents().sizedBox50,
               Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                          child: kAppButton(
                        buttonText: "Male",
                        buttonCheck: true,
                        color: Get.find<GetSTorageController>()
                                    .box
                                    .read(kGender)
                                    .toString() ==
                                "Male"
                            ? textcolor
                            : Colors.white,
                        textColor: Get.find<GetSTorageController>()
                                    .box
                                    .read(kGender)
                                    .toString() ==
                                "Male"
                            ? Colors.white
                            : Colors.black,
                        onButtonPressed: () {
                          Get.find<GetSTorageController>()
                              .box
                              .write(kGender, "Male");
                          controller.setRegisterViewPage(
                              RegisterViewEnum.RegisterView2);
                        },
                      )),
                    ),
              AppComponents().sizedBox15,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Center(
                    child: kAppButton(
                  buttonCheck: true,
                  color: Get.find<GetSTorageController>()
                              .box
                              .read(kGender)
                              .toString() ==
                          "Female"
                      ? textcolor
                      : Colors.white,
                  textColor: Get.find<GetSTorageController>()
                              .box
                              .read(kGender)
                              .toString() ==
                          "Female"
                      ? Colors.white
                      : Colors.black,
                  buttonText: "Female",
                  onButtonPressed: () {
                    Get.find<GetSTorageController>()
                        .box
                        .write(kGender, "Female");
                    controller
                        .setRegisterViewPage(RegisterViewEnum.RegisterView2);
                  },
                )),
              ),
            ],
          ),
        ),
      );
    });
  }
}
