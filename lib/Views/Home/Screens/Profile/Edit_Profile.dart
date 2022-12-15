import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Models/UserModel.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/Profile_Controller.dart';

class Edit_Profile extends StatelessWidget {
  UserModel userModel;
  Edit_Profile({required this.userModel});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GetBuilder<ProfileController>(
            builder: (controller) {
              controller.nameController.text = userModel.name.toString();
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppComponents().sizedBox50,
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xfFf1565A),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 3),
                          child: GestureDetector(
                            child: const Center(
                              child: Icon(
                                Icons.arrow_back_ios_rounded,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              Get.back();
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        "Edit Profile",
                        style: k25styleblack,
                      ),
                    ],
                  ),
                  AppComponents().sizedBox20,
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
                        hinttext: "Name",
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
                        controller.selectedMartialFunction(value.toString());
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
                    child: kCustomButton(label: "Save", ontap: () {}),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
