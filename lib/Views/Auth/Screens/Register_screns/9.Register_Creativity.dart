import 'package:dropdown_button2/dropdown_button2.dart';
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
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: [
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            'Select Creativity',
                            style: k14styleWhite,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: kcreativityList!
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: k14styleWhite,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    offset: Offset(0, -20),
                    value: controller.selectedCreativity,
                    onChanged: (value) {
                      controller.selectedCreativityFunction(value.toString());
                    },
                    icon: Icon(
                      Icons.arrow_drop_down_outlined,
                    ),
                    dropdownMaxHeight: 300,
                    iconSize: 24,
                    iconEnabledColor: Colors.white,
                    iconDisabledColor: Colors.grey,
                    buttonHeight: 47,
                    buttonWidth: 247,
                    buttonPadding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFEA7C4A),
                            Color(0xFFF1565A),
                          ]),
                    ),
                    itemHeight: 40,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFEA7C4A),
                            Color(0xFFF1565A),
                          ]),
                    ),
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                  ),
                ),
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
