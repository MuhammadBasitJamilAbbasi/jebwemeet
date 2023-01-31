import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/Profile_Controller.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_about.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_caste.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_languages.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_rangepractice.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_religion.dart';

class Form_3 extends StatefulWidget {
  @override
  State<Form_3> createState() => _Form_3State();
}

class _Form_3State extends State<Form_3> {
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
                  "Personal",
                  style: k25styleblack,
                ),
                AppComponents().sizedBox20,
                Essential_Widget(
                  leadingImage: "assets/about.png",
                  title: "About me",
                  onTap: () {
                    Get.to(() => Add_About());
                  },
                  iconfil: controller
                      .aboutController.value.text.isEmpty
                      ? Icons.arrow_forward_ios_outlined
                      : Icons.check,
                ),
                controller.aboutController.value.text.isEmpty
                    ? SizedBox.shrink()
                    : Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    controller.aboutController.value.text,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Essential_Widget(
                  leadingImage: "assets/religion.png",
                  title: "Religion",
                  onTap: () {
                    Get.to(() => Add_Religion());
                  },
                  iconfil: Get.find<GetSTorageController>()
                      .box
                      .read(kReligion)
                      .toString() ==
                      "" ||
                      Get.find<GetSTorageController>()
                          .box
                          .read(kReligion)
                          .toString() ==
                          "null"
                      ? Icons.arrow_forward_ios_outlined
                      : Icons.check,
                ),
                Get.find<GetSTorageController>()
                    .box
                    .read(kReligion)
                    .toString() ==
                    "" ||
                    Get.find<GetSTorageController>()
                        .box
                        .read(kReligion)
                        .toString() ==
                        "null"
                    ? SizedBox.shrink()
                    : Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    Get.find<GetSTorageController>()
                        .box
                        .read(kReligion)
                        .toString(),
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Essential_Widget(
                  leadingImage: "assets/religionp.png",
                  title: "Religious Practice",
                  onTap: () {
                    Get.to(() => Add_RangePractice());
                  },
                  iconfil: Get.find<GetSTorageController>()
                      .box
                      .read(kReligiousPractice)
                      .toString() ==
                      "" ||
                      Get.find<GetSTorageController>()
                          .box
                          .read(kReligiousPractice)
                          .toString() ==
                          "null"
                      ? Icons.arrow_forward_ios_outlined
                      : Icons.check,
                ),
                Get.find<GetSTorageController>()
                    .box
                    .read(kReligiousPractice)
                    .toString() ==
                    "" ||
                    Get.find<GetSTorageController>()
                        .box
                        .read(kReligiousPractice)
                        .toString() ==
                        "null"
                    ? SizedBox.shrink()
                    : Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    Get.find<GetSTorageController>()
                        .box
                        .read(kReligiousPractice)
                        .toString(),
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Essential_Widget(
                  leadingImage: "assets/caste.png",
                  title: "Caste",
                  onTap: () {
                    Get.to(() => Add_Caste());
                  },
                  iconfil: Get.find<GetSTorageController>()
                      .box
                      .read(kCaste)
                      .toString() ==
                      "" ||
                      Get.find<GetSTorageController>()
                          .box
                          .read(kCaste)
                          .toString() ==
                          "null"
                      ? Icons.arrow_forward_ios_outlined
                      : Icons.check,
                ),
                Get.find<GetSTorageController>()
                    .box
                    .read(kCaste)
                    .toString() ==
                    "" ||
                    Get.find<GetSTorageController>()
                        .box
                        .read(kCaste)
                        .toString() ==
                        "null"
                    ? SizedBox.shrink()
                    : Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    Get.find<GetSTorageController>()
                        .box
                        .read(kCaste)
                        .toString(),
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Essential_Widget(
                  leadingImage: "assets/lang.png",
                  title: "Languages",
                  onTap: () {
                    Get.to(() => Add_Languages());
                  },
                  iconfil: controller.kList!.isEmpty
                      ? Icons.arrow_forward_ios_outlined
                      : Icons.check,
                ),
                controller.kList!.isNotEmpty
                    ?  Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 5,
                  runSpacing: 15,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runAlignment: WrapAlignment.start,
                  children: controller.kList!.map((String document) {
                    return InkWell(
                      onTap: () {
                        if (controller.kList!.contains(document)) {
                          controller.kList!.remove(document);
                          controller.update();
                        } else {
                          controller.kList!.add(document);
                          controller.update();
                        }
                        print("selected Language list");
                        print(controller.kList!.toString());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            color: controller.kList!.contains(document)
                                ? primarycolor
                                : Colors.transparent,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          document.toString(),
                          style: TextStyle(
                              color: controller.kList!.contains(document)
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    );
                  }).toList(),
                )
                    : Text(""),
              ]
          )
          );
        },
      ),
    );}
}

