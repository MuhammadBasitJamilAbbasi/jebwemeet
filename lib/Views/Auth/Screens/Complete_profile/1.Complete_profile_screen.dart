import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/Dialouge_Boxes.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/Profile_Controller.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/2.add_education.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/3.add_hobbies.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_about.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_caste.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_height.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_income.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_sports.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_work.dart';

class Complete_Profile1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileConytroller>();

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: GetBuilder<ProfileConytroller>(
                init: ProfileConytroller(),
                builder: (controller) {
                  return Column(
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                          child: Text(
                            "The more you fill out your profile, the better matches we can find for you",
                            style: k14styleblack,
                          ),
                        ),
                        AppComponents().sizedBox15,
                        InkWell(
                          onTap: () {
                            controller.getImage(ImageSource.gallery);
                          },
                          child: Container(
                            height: 270,
                            width: MediaQuery.of(context).size.width,
                            margin:
                                EdgeInsets.only(left: 30, right: 30, top: 15),
                            child: Stack(
                              children: [
                                Container(
                                  height: 243,
                                  margin: EdgeInsets.only(top: 15, right: 5),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: controller.selectedImagePath
                                              .toString() ==
                                          ""
                                      ? BoxDecoration(
                                          color: kinputbgcolor.withOpacity(0.6),
                                          borderRadius:
                                              BorderRadius.circular(19),
                                        )
                                      : BoxDecoration(
                                          color: kinputbgcolor.withOpacity(0.6),
                                          borderRadius:
                                              BorderRadius.circular(19),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(File(controller
                                                  .selectedImagePath)))),
                                  alignment: Alignment.center,
                                  child:
                                      controller.selectedImagePath.toString() ==
                                              ""
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
                                                  "Tap to add profile photo",
                                                  style: k12styleblackBold,
                                                )
                                              ],
                                            )
                                          : SizedBox.shrink(),
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
                                    color: kinputbgcolor.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(19),
                                  ),
                                  padding: EdgeInsets.only(left: 20),
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "About me",
                                        style: k14styleblackBold,
                                      ),
                                      Text(
                                        "Add about me",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFFB2ADAD),
                                            fontWeight: FontWeight.w300),
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
                          height: 380,
                          margin: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: kinputbgcolor.withOpacity(0.6),
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
                                leadingImage: "assets/education.png",
                                title: "Add education",
                                onTap: () {
                                  Get.to(() => Add_Education());
                                },
                              ),
                              Essential_Widget(
                                leadingImage: "assets/Group 30.png",
                                title: "Add Income",
                                onTap: () {
                                  Get.to(() => Add_Income());
                                },
                              ),
                              Essential_Widget(
                                leadingImage: "assets/work.png",
                                title: "Add work",
                                onTap: () {
                                  Get.to(() => Add_Work());
                                },
                              ),
                              Essential_Widget(
                                leadingImage: "assets/Vector.png",
                                title: "Add height",
                                onTap: () {
                                  Get.to(() => Add_Height());
                                },
                              ),
                              Essential_Widget(
                                leadingImage: "assets/caste.png",
                                title: "Add caste",
                                onTap: () {
                                  Get.to(() => Add_Caste());
                                },
                              ),
                              Text(
                                "Interests",
                                style: k14styleblackBold,
                              ),
                              Essential_Widget(
                                leadingImage: "assets/hobby.png",
                                title: "Add interests",
                                onTap: () {
                                  Get.to(() => Add_Hoobies());
                                },
                              ),
                              Essential_Widget(
                                leadingImage: "assets/reward.png",
                                title: "Add sports",
                                onTap: () {
                                  Get.to(() => Add_Sports());
                                },
                              ),
                              Essential_Widget(
                                leadingImage: "assets/Vector (2).png",
                                title: "Add movies",
                                onTap: () {
                                  Dialouge_Box.showCustomDialoge(
                                      child: Container(
                                        height: 150,
                                        child: Column(
                                          children: [
                                            kCustomTextField(
                                                hinttext: "Add Movies",
                                                isValidator: false,
                                                controller:
                                                    controller.moviesController,
                                                validator: () {
                                                  return "";
                                                }),
                                            AppComponents().sizedBox20,
                                            kCustomButton(
                                                label: "Add Movies",
                                                ontap: () {
                                                  Get.find<
                                                          GetSTorageController>()
                                                      .box
                                                      .write(
                                                          kMovies,
                                                          controller
                                                              .moviesController
                                                              .value
                                                              .text);
                                                  Get.back();
                                                })
                                          ],
                                        ),
                                      ),
                                      title: "Add Movies",
                                      value: true);
                                },
                              ),
                            ],
                          ),
                        )
                      ]);
                },
              ))),
    );
  }
}
