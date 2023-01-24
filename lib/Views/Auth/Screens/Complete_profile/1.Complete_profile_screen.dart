import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/Profile_Controller.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/2.add_education.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/3.add_hobbies.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_about.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_caste.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_childern.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_height.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_income.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_industry.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_jobtitle.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_languages.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_martial_status.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_rangepractice.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_religion.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_work.dart';

class Complete_Profile1 extends StatefulWidget {
  @override
  State<Complete_Profile1> createState() => _Complete_Profile1State();
}

class _Complete_Profile1State extends State<Complete_Profile1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            controller: controller.scrollController,
            physics: BouncingScrollPhysics(),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppComponents().sizedBox30,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "Complete your profile",
                      style: k25styleblack,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Text(
                      "The more you fill out your profile, the better matches we can find for you",
                      style: k14styleblack,
                    ),
                  ),
                  AppComponents().sizedBox15,
                  Center(
                    child: InkWell(
                      onTap: () {
                        controller.pickImagestatus = true;
                        controller.update();
                        Get.bottomSheet(
                            isDismissible: true,
                            // backgroundColor: Colors.white,
                            Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              child: InkWell(
                                onTap: () {
                                  controller.pickImagestatus = false;
                                  controller.update();
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 1,
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            topRight: Radius.circular(25)),
                                        // border: Border.all(
                                        //   color: butoncolor,
                                        //   width: 1.2,
                                        // ),
                                        color: Colors.white),
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01),
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    controller.getImage(context,
                                                        ImageSource.camera);
                                                  },
                                                  child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.171,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.171,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: butoncolor,
                                                              width: 1.2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12)),
                                                      child: Icon(
                                                        Icons
                                                            .camera_alt_outlined,
                                                        size: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.064,
                                                      )),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.01,
                                                ),
                                                Text(
                                                  "Camera",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 13,
                                                      color: const Color(
                                                          0xff666666)),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    controller.getImage(context,
                                                        ImageSource.gallery);
                                                  },
                                                  child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.171,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.171,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: butoncolor,
                                                              width: 1.2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12)),
                                                      child: Icon(
                                                        Icons.image_outlined,
                                                        size: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.064,
                                                      )),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.01,
                                                ),
                                                Text(
                                                  "Gallery",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 13,
                                                      color: const Color(
                                                          0xff666666)),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ));
                      },
                      child: Container(
                        height: 190,
                        width: 190,
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Container(
                              height: 190,
                              width: 190,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: 15, right: 0),
                              decoration: controller.selectedImagePath
                                          .toString() ==
                                      ""
                                  ? BoxDecoration(
                                      color: kinputbgcolor.withOpacity(0.3),
                                      shape: BoxShape.circle,
                                    )
                                  : BoxDecoration(
                                      color: kinputbgcolor.withOpacity(0.3),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(File(
                                              controller.selectedImagePath)))),
                              child:
                                  controller.selectedImagePath.toString() == ""
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/camera.png",
                                              height: 50,
                                              width: 55,
                                            ),
                                            AppComponents().sizedBox10,
                                            Text(
                                              "Profile photo",
                                              style: k12styleblack,
                                            )
                                          ],
                                        )
                                      : SizedBox.shrink(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    "assets/add.png",
                                    height: 35,
                                    width: 35,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "My Profile Blur",
                          style: k16styleblack,
                        ),
                        Switch(
                          value: controller.isBlured,
                          onChanged: (value) {
                            controller.blurFunction(value);
                          },
                          activeTrackColor: Colors.deepOrange.shade200,
                          activeColor: primarycolor,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => Add_About());
                    },
                    child: Container(
                      height: 90,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            height: 64,
                            margin: EdgeInsets.only(top: 15, right: 5),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color:
                                  controller.aboutController.value.text.isEmpty
                                      ? kinputbgcolor.withOpacity(0.3)
                                      : kinputbgcolor.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(19),
                            ),
                            padding: EdgeInsets.only(left: 20),
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "About me",
                                  style: k14styleblackBold,
                                ),
                                Text(
                                  controller.aboutController.value.text.isEmpty
                                      ? "About me"
                                      : controller.aboutController.value.text,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFFB2ADAD),
                                      fontWeight: FontWeight.w300),
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                "assets/add.png",
                                height: 35,
                                width: 35,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: kinputbgcolor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(19),
                    ),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Essentials",
                          style: k14styleblackBold,
                        ),
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
                          leadingImage: "assets/Vector.png",
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
                            ? Essential_Widget(
                                leadingImage: "assets/Vector.png",
                                title: "Childerns",
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
                              )
                            : SizedBox.shrink(),
                        Essential_Widget(
                          leadingImage: "assets/hobby.png",
                          title: "Interests",
                          onTap: () {
                            Get.to(() => Add_Hoobies());
                          },
                          iconfil: controller.selectedList.length == 0
                              ? Icons.arrow_forward_ios_outlined
                              : Icons.check,
                        ),
                        // Essential_Widget(
                        //   leadingImage: "assets/Vector.png",
                        //   title: "Add Childern",
                        //   onTap: () {
                        //     Get.to(() => Add_Martial());
                        //   },
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: kinputbgcolor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(19),
                    ),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Education",
                          style: k14styleblackBold,
                        ),
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
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: kinputbgcolor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(19),
                    ),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Personal",
                          style: k14styleblackBold,
                        ),
                        Essential_Widget(
                          leadingImage: "assets/work.png",
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
                          leadingImage: "assets/work.png",
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
                          leadingImage: "assets/caste.png",
                          title: "Languages",
                          onTap: () {
                            Get.to(() => Add_Languages());
                          },
                          iconfil: Get.find<GetSTorageController>()
                                          .box
                                          .read(kLanguage)
                                          .toString() ==
                                      "" ||
                                  Get.find<GetSTorageController>()
                                          .box
                                          .read(kLanguage)
                                          .toString() ==
                                      "null"
                              ? Icons.arrow_forward_ios_outlined
                              : Icons.check,
                        ),
                        controller.kList!.isNotEmpty
                            ? SizedBox(
                                height: 30,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.kList!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (BuildContext context, index) {
                                      return Text(
                                          controller.kList![index].toString() +
                                              ", ");
                                    }),
                              )
                            : Text(""),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: kinputbgcolor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(19),
                    ),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Career",
                          style: k14styleblackBold,
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
                          leadingImage: "assets/Group 30.png",
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
                          leadingImage: "assets/Group 30.png",
                          title: "Industry",
                          onTap: () {
                            Get.to(() => Add_Industry());
                          },
                          iconfil: controller
                                  .addindustryController.value.text.isEmpty
                              ? Icons.arrow_forward_ios_outlined
                              : Icons.check,
                        ),
                        controller.addindustryController.value.text.isEmpty
                            ? SizedBox.shrink()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: Text(
                                  controller.addindustryController.value.text,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                        Essential_Widget(
                            leadingImage: "assets/Group 30.png",
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Text(
                      "More photos",
                      style: k14styleblack,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      controller.filesImage =
                          await controller.pickImage(multiple: true);
                      controller.update();
                      await controller.uploadImages(context);
                    },
                    child: Container(
                      height: 270,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 30, right: 30, top: 0),
                      child: Stack(
                        children: [
                          Container(
                            height: 247,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 15, right: 5),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: kinputbgcolor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(19),
                            ),
                            child: controller.filesImage.length == 0
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/camera.png",
                                        height: 50,
                                        width: 55,
                                      ),
                                      AppComponents().sizedBox10,
                                      Text(
                                        "Tap to add more photos",
                                        style: k12styleblackBold,
                                      )
                                    ],
                                  )
                                : GridView.count(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    children: controller.filesImage
                                        .map(
                                          (e) => SizedBox(
                                            width: double.infinity,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Image.file(
                                                File(e.path),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                "assets/add.png",
                                height: 35,
                                width: 35,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  AppComponents().sizedBox10,
                  Center(
                      child: controller.isLoader
                          ? CircularProgressIndicator()
                          : kCustomButton(
                              label: "Submit",
                              ontap: () async {
                                controller.submitProfile(context);
                              })),
                  AppComponents().sizedBox10,
                ]),
          );
        },
      )),
    );
  }
}
