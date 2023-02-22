
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Components/Interest_Widget.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/Profile_Controller.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/3.add_hobbies.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_about.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_childern.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_height.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_martial_status.dart';

class Form_2 extends StatefulWidget {

  @override
  State<Form_2> createState() => _Form_2State();
}

class _Form_2State extends State<Form_2> {
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
                  "Essentials",
                  style: k25styleblack,
                ),
                AppComponents().sizedBox20,
                Essential_Widget(
                  leadingImage: "assets/Vector.png",
                  title: "Height",
                  onTap: () {
                    Get.to(() => Add_Height());
                  },
                  iconfil: Get.find<GetSTorageController>()
                      .box
                      .read(kHeight)
                      .toString() ==
                      "" ||
                      Get.find<GetSTorageController>()
                          .box
                          .read(kHeight)
                          .toString() ==
                          "null"
                      ? Icons.arrow_forward_ios_outlined
                      : Icons.check,
                ),
                Get.find<GetSTorageController>()
                    .box
                    .read(kHeight)
                    .toString() ==
                    "" ||
                    Get.find<GetSTorageController>()
                        .box
                        .read(kHeight)
                        .toString() ==
                        "null"
                    ? SizedBox.shrink()
                    : Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    Get.find<GetSTorageController>()
                        .box
                        .read(kHeight)
                        .toString(),
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Essential_Widget(
                  leadingImage: "assets/martial.png",
                  title: "Martial Status",
                  onTap: () {
                    Get.to(() => Add_Martial());
                  },
                  iconfil: Get.find<GetSTorageController>()
                      .box
                      .read(kMartial_Statius)
                      .toString() ==
                      "" ||
                      Get.find<GetSTorageController>()
                          .box
                          .read(kMartial_Statius)
                          .toString() ==
                          "null"
                      ? Icons.arrow_forward_ios_outlined
                      : Icons.check,
                ),
                Get.find<GetSTorageController>()
                    .box
                    .read(kMartial_Statius)
                    .toString() ==
                    "" ||
                    Get.find<GetSTorageController>()
                        .box
                        .read(kMartial_Statius)
                        .toString() ==
                        "null"
                    ? SizedBox.shrink()
                    : Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    Get.find<GetSTorageController>()
                        .box
                        .read(kMartial_Statius)
                        .toString(),
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Get.find<GetSTorageController>()
                    .box
                    .read(kMartial_Statius)
                    .toString() ==
                    "Divorced" ||
                    Get.find<GetSTorageController>()
                        .box
                        .read(kMartial_Statius)
                        .toString() ==
                        "Seperated" ||
                    Get.find<GetSTorageController>()
                        .box
                        .read(kMartial_Statius)
                        .toString() ==
                        "Widowed"
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Essential_Widget(
                  leadingImage: "assets/child.png",
                  title: "Childrens",
                  onTap: () {
                        Get.to(() => Add_Childern());
                  },
                  iconfil: Get.find<GetSTorageController>()
                          .box
                          .read(kchildern)
                          .toString() ==
                          "" ||
                          Get.find<GetSTorageController>()
                              .box
                              .read(kchildern)
                              .toString() ==
                              "null"
                          ? Icons.arrow_forward_ios_outlined
                          : Icons.check,
                ),
                        Get.find<GetSTorageController>()
                            .box
                            .read(kchildern)
                            .toString() ==
                            "" ||
                            Get.find<GetSTorageController>()
                                .box
                                .read(kchildern)
                                .toString() ==
                                "null"
                            ? SizedBox.shrink()
                            : Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            Get.find<GetSTorageController>()
                                .box
                                .read(kchildern)
                                .toString(),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    )
                    : SizedBox.shrink(),
                Essential_Widget(
                  leadingImage: "assets/hobby.png",
                  title: "Interests",
                  onTap: () {
                    Get.to(() => Add_Hoobies());
                  },
                  iconfil: controller.getList.length == 0
                      ? Icons.arrow_forward_ios_outlined
                      : Icons.check,
                ),
                AppComponents().sizedBox20,
                Wrap(
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.start,
                  runSpacing: 10,
                  spacing: 10,
                  children:
                  List.generate(controller.getList.length, (index) {
                    final topic = controller.getList[index];
                    return IntrinsicWidth(
                      child: InterestWidget(
                        textstyle: controller.getList.contains(topic)
                            ? k14styleWhite
                            : k14styleblack,
                        horizontalDistance: 15,
                        borderColor: controller.getList.contains(topic)
                            ? primarycolor
                            : Colors.grey.shade300,
                       onlyTilte: true,
                        title: controller.getList[index],
                        onTap: () {
                            // if (!controller.getList.contains(topic)) {
                            //   controller.addTopics(topic);
                            // } else {
                            //   controller.removeTopics(topic);
                            // }
                        },
                        color: controller.getList.contains(topic)
                            ? primarycolor
                            : Colors.white,
                      ),
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );}
}


