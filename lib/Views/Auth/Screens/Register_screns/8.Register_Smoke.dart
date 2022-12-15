import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Utils/enums.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';

class Register_Smoke extends StatelessWidget {
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
                  "Do you smoke",
                  style: k25styleblack,
                ),
              ),
              AppComponents().sizedBox50,
              Center(
                child: buildRegisterDropDown(
                    text: "Do you smoke",
                    list: ksmokeList!,
                    value: controller.selectedSmoke,
                    onchange: (value) {
                      controller.selectedSmokeFunction(value);
                    },
                    controller: controller),
              ),
              AppComponents().sizedBox30,
              controller.selectedSmoke != "Do you smoke?"
                  ? Center(
                      child: kCustomButton(
                        label: "Continue",
                        ontap: () {
                          if (controller.selectedSmoke.toString() !=
                              "Do you smoke?") {
                            Get.find<GetSTorageController>().box.write(
                                kSmoke, controller.selectedSmoke.toString());
                            controller.setRegisterViewPage(
                                RegisterViewEnum.RegisterView9);
                          } else {
                            snackBar(context, "Please Select the answer",
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
