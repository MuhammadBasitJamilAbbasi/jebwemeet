import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Models/UserModel.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Home/Controllers/Edit_profile_controller.dart';

class Edit_Profile extends StatelessWidget {
  UserModel userModel;

  Edit_Profile({required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: GetBuilder<EditProfileController>(
          init: EditProfileController(userModel: userModel),
          builder: (controller) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppComponents().sizedBox50,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AppComponents().backIcon(() {Get.back();}),
                ),
                AppComponents().sizedBox20,
                Center(
                  child: Stack(
                    children: [
                      SizedBox(
                        width: 160,
                        height: 160,
                        child: Center(
                          child: SizedBox(
                            width: 130,
                            height: 130,
                            child: controller.selectedImagePath
                                        .toString() ==
                                    ""
                                ? CircleAvatar(
                                    foregroundImage: NetworkImage(
                                        userModel.imageUrl.toString()),
                                    radius: 10,
                                  )
                                : CircleAvatar(
                                    foregroundImage: FileImage(File(
                                        controller.selectedImagePath)),
                                    radius: 10,
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 10,
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: InkWell(
                            onTap: () {
                              controller.getImage(context);
                            },
                            child: Image.asset("assets/camera.png",color: textcolor,),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                AppComponents().sizedBox20,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Blur my profile",
                        style: k20styleblack,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "My Name is",
                    style: k20styleblack,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 10),
                  child: kCustomTextField(
                      hinttext: "John Doe",
                      labeltext: "",
                      controller: controller.nameController,
                      validator: () {}),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Martial Status is",
                    style: k20styleblack,
                  ),
                ),
                AppComponents().sizedBox10,
                buildProfileDropDown(
                    text: "Select Status",
                    list: kMartial_StatusList!,
                    value: controller.selectedMartialStatus == ""
                        ? kMartial_StatusList![0]
                        : controller.selectedMartialStatus,
                    onchange: (value) {
                      controller.selectedMartialStatus = value;
                      controller.update();
                    },
                    controller: controller),
                AppComponents().sizedBox20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Select Religion is",
                    style: k20styleblack,
                  ),
                ),
                AppComponents().sizedBox10,
                buildProfileDropDown(
                    text: "Select Religion",
                    list: kReligionList!,
                    value: controller.selectedReligion == ""
                        ? kReligionList![0]
                        : controller.selectedReligion,
                    onchange: (value) {
                      controller.selectedReligionFunction(value.toString());
                    },
                    controller: controller),
                AppComponents().sizedBox20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Select Caste is",
                    style: k20styleblack,
                  ),
                ),
                AppComponents().sizedBox10,
                buildProfileDropDown(
                    text: "Select Caste",
                    list: kcasteList!,
                    value: controller.selectedCaste == ""
                        ? kcasteList![0]
                        : controller.selectedCaste,
                    onchange: (value) {
                      controller.selectedCasteFunction(value.toString());
                    },
                    controller: controller),
                AppComponents().sizedBox20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Select City is",
                    style: k20styleblack,
                  ),
                ),
                AppComponents().sizedBox10,
                buildProfileDropDown(
                    text: "Select City",
                    list: kCityList!,
                    value: controller.selectedCity == ""
                        ? kCityList![0]
                        : controller.selectedCity,
                    onchange: (value) {
                      controller.selectedCityFunction(value.toString());
                    },
                    controller: controller),
                AppComponents().sizedBox30,
                Center(
                  child: controller.isLoader
                      ? CircularProgressIndicator()
                      : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: kAppButton(
                            buttonText: "Save",
                            onButtonPressed: () {
                              controller.submitProfile(context);
                            }),
                      ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
