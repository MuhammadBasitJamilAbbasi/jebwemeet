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
            .write(kGender,"Man");
      }

      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppComponents().backIconWithSkip(() {
                Get.back();
              }, () {}),
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
                        buttonText: "Man",
                        buttonCheck: true,
                        color: Get.find<GetSTorageController>()
                                    .box
                                    .read(kGender)
                                    .toString() ==
                                "Man"
                            ? textcolor
                            : Colors.white,
                        textColor: Get.find<GetSTorageController>()
                                    .box
                                    .read(kGender)
                                    .toString() ==
                                "Man"
                            ? Colors.white
                            : Colors.black,
                        onButtonPressed: () {
                          Get.find<GetSTorageController>()
                              .box
                              .write(kGender, "Man");
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
                          "Woman"
                      ? textcolor
                      : Colors.white,
                  textColor: Get.find<GetSTorageController>()
                              .box
                              .read(kGender)
                              .toString() ==
                          "Woman"
                      ? Colors.white
                      : Colors.black,
                  buttonText: "Woman",
                  onButtonPressed: () {
                    Get.find<GetSTorageController>()
                        .box
                        .write(kGender, "Woman");
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
