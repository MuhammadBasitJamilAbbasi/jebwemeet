import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/Profile_Controller.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/2.add_education.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_caste.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_income.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_industry.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_jobtitle.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_languages.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_rangepractice.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_religion.dart';

import '../../add_work.dart';

class Form_4 extends StatefulWidget {
  @override
  State<Form_4> createState() => _Form_4State();
}

class _Form_4State extends State<Form_4> {
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<ProfileController>(
        builder: (controller){
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppComponents().sizedBox30,
                    Text(
                      "Career",
                      style: k25styleblack,
                    ),
                    AppComponents().sizedBox20,
                    Essential_Widget(
                      leadingImage: "assets/education.png",
                      title: "Education",
                      onTap: () {
                        Get.to(() => Add_Education());
                      },
                      iconfil: Get.find<GetSTorageController>()
                          .box
                          .read(kEducation)
                          .toString() ==
                          "" ||
                          Get.find<GetSTorageController>()
                              .box
                              .read(kEducation)
                              .toString() ==
                              "null"
                          ? Icons.arrow_forward_ios_outlined
                          : Icons.check,
                    ),
                    Get.find<GetSTorageController>()
                        .box
                        .read(kEducation)
                        .toString() ==
                        "" ||
                        Get.find<GetSTorageController>()
                            .box
                            .read(kEducation)
                            .toString() ==
                            "null"
                        ? SizedBox.shrink()
                        : Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        Get.find<GetSTorageController>()
                            .box
                            .read(kEducation)
                            .toString(),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Essential_Widget(
                      leadingImage: "assets/work.png",
                      title: "Profession",
                      onTap: () {
                        Get.to(() => Add_Work());
                      },
                      iconfil: Get.find<GetSTorageController>()
                          .box
                          .read(kWork)
                          .toString() ==
                          "" ||
                          Get.find<GetSTorageController>()
                              .box
                              .read(kWork)
                              .toString() ==
                              "null"
                          ? Icons.arrow_forward_ios_outlined
                          : Icons.check,
                    ),
                    Get.find<GetSTorageController>()
                        .box
                        .read(kWork)
                        .toString() ==
                        "" ||
                        Get.find<GetSTorageController>()
                            .box
                            .read(kWork)
                            .toString() ==
                            "null"
                        ? SizedBox.shrink()
                        : Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        Get.find<GetSTorageController>()
                            .box
                            .read(kWork)
                            .toString(),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Essential_Widget(
                      leadingImage: "assets/job.png",
                      title: "Job Title",
                      onTap: () {
                        Get.to(() => Add_JobTitle());
                      },
                      iconfil:
                      controller.jobtitleController.value.text.isEmpty
                          ? Icons.arrow_forward_ios_outlined
                          : Icons.check,
                    ),
                    controller.jobtitleController.value.text.isEmpty
                        ? SizedBox.shrink()
                        : Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        controller.jobtitleController.value.text,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Essential_Widget(
                        leadingImage: "assets/income.png",
                        title: "Income",
                        onTap: () {
                          Get.to(() => Add_Income());
                        },
                        iconfil: Get.find<GetSTorageController>()
                            .box
                            .read(kIncome)
                            .toString() ==
                            "" ||
                            Get.find<GetSTorageController>()
                                .box
                                .read(kIncome)
                                .toString() ==
                                "null"
                            ? Icons.arrow_forward_ios_outlined
                            : Icons.check),
                    Get.find<GetSTorageController>()
                        .box
                        .read(kIncome)
                        .toString() ==
                        "" ||
                        Get.find<GetSTorageController>()
                            .box
                            .read(kIncome)
                            .toString() ==
                            "null"
                        ? SizedBox.shrink()
                        : Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        Get.find<GetSTorageController>()
                            .box
                            .read(kIncome)
                            .toString(),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ]
              )
          );
        },
      ),
    );}
}

