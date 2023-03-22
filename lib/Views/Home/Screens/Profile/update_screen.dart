import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Components/Interest_Widget.dart';
import 'package:jabwemeet/Models/UserModel.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/Profile_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/completeProfile/view/completeprofilescreen.dart';
import 'package:jabwemeet/Views/Home/Controllers/Edit_profile_controller.dart';

import '../../../../Models/Hobbies_Model.dart';

class Update_Screen extends StatefulWidget {
  UserModel userModel;
  bool username;
  bool about;
  bool education;
  bool martial_status;
  bool caste;
  bool city;
  bool religion;
  bool religion_practise;
  bool job_title;
  bool address;
  bool childs;
  bool interests;

  Update_Screen({
    required this.userModel,
    this.username = false,
    this.education = false,
    this.religion = false,
    this.caste = false,
    this.address = false,
    this.martial_status = false,
    this.job_title = false,
    this.about = false,
    this.interests = false,
    this.childs = false,
    this.city = false,
    this.religion_practise = false,
  });

  @override
  State<Update_Screen> createState() => _Update_ScreenState();
}

class _Update_ScreenState extends State<Update_Screen> {
  @override
  Widget build(BuildContext context) {
    final storage = Get.find<GetSTorageController>();

    return Scaffold(
        body: GetBuilder<EditProfileController>(
      init: EditProfileController(userModel: widget.userModel),
      builder: (controller) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppComponents().sizedBox30,
                  AppComponents().backIcon(() {
                    Get.back();
                  }),
                  AppComponents().sizedBox20,
                  AppComponents().sizedBox10,
                  widget.username
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "Username",
                                style: k25styleblack,
                              ),
                            ),
                            AppComponents().sizedBox40,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: kCustomTextField(
                                  labeltext: "",
                                  hinttext: "Type here",
                                  controller: controller.nameController,
                                  isValidator: false,
                                  maxlines: 1,
                                  validator: (val) {
                                    return "";
                                  }),
                            ),
                            AppComponents().sizedBox30,
                            Center(
                              child: controller.isLoader
                                  ? CircularProgressIndicator()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: kAppButton(
                                        buttonText: "Update",
                                        onButtonPressed: () {
                                          if (controller.nameController.value
                                              .text.isNotEmpty) {
                                            if (Get.find<RegisterController>()
                                                    .userNamesList
                                                    .contains(controller
                                                        .nameController
                                                        .value
                                                        .text
                                                        .trim()) ==
                                                false) {
                                              controller.updateProfile(context,
                                                  parameter: "name",
                                                  value: controller
                                                      .nameController
                                                      .value
                                                      .text);
                                            } else {
                                              snackBar(
                                                  context,
                                                  "username not availble",
                                                  Colors.pink);
                                            }
                                          } else {
                                            snackBar(
                                                context,
                                                "username should not be empty",
                                                Colors.pink);
                                          }
                                        },
                                      ),
                                    ),
                            )
                          ],
                        )
                      : SizedBox.shrink(),
                  widget.job_title
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "Job title",
                                style: k25styleblack,
                              ),
                            ),
                            AppComponents().sizedBox40,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: kCustomTextField(
                                  labeltext: "",
                                  hinttext: "Type here",
                                  controller: controller.jobtitleController,
                                  isValidator: false,
                                  maxlines: 1,
                                  validator: (val) {
                                    return "";
                                  }),
                            ),
                            AppComponents().sizedBox30,
                            Center(
                              child: controller.isLoader
                                  ? CircularProgressIndicator()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: kAppButton(
                                        buttonText: "Update",
                                        onButtonPressed: () {
                                          if (controller.jobtitleController
                                              .value.text.isNotEmpty) {
                                            controller.updateProfile(context,
                                                parameter: "job_title",
                                                value: controller
                                                    .jobtitleController
                                                    .value
                                                    .text);
                                          } else {
                                            snackBar(
                                                context,
                                                "Job title should not be empty",
                                                Colors.pink);
                                          }
                                        },
                                      ),
                                    ),
                            )
                          ],
                        )
                      : SizedBox.shrink(),
                  widget.about
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "About",
                                style: k25styleblack,
                              ),
                            ),
                            AppComponents().sizedBox40,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: kCustomTextField(
                                  labeltext: "",
                                  hinttext: "Type here",
                                  controller: controller.aboutController,
                                  isValidator: false,
                                  maxlines: 4,
                                  validator: (val) {
                                    return "";
                                  }),
                            ),
                            AppComponents().sizedBox30,
                            Center(
                              child: controller.isLoader
                                  ? CircularProgressIndicator()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: kAppButton(
                                        buttonText: "Update",
                                        onButtonPressed: () {
                                          if (controller.aboutController.value
                                              .text.isNotEmpty) {
                                            controller.updateProfile(context,
                                                parameter: "about",
                                                value: controller
                                                    .aboutController
                                                    .value
                                                    .text);
                                          } else {
                                            snackBar(
                                                context,
                                                "About should not be empty",
                                                Colors.pink);
                                          }
                                        },
                                      ),
                                    ),
                            )
                          ],
                        )
                      : SizedBox.shrink(),
                  widget.education
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "Education",
                                style: k25styleblack,
                              ),
                            ),
                            AppComponents().sizedBox40,
                            Center(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: kAppButton(
                                buttonCheck: true,
                                color: Get.find<GetSTorageController>()
                                            .box
                                            .read(kEducation)
                                            .toString() ==
                                        "High School"
                                    ? textcolor
                                    : Colors.white,
                                textColor: Get.find<GetSTorageController>()
                                            .box
                                            .read(kEducation)
                                            .toString() ==
                                        "High School"
                                    ? Colors.white
                                    : Colors.black,
                                buttonText: "High School",
                                onButtonPressed: () {
                                  storage.box.write(kEducation, "High School");
                                  setState(() {});
                                },
                              ),
                            )),
                            AppComponents().sizedBox15,
                            Center(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: kAppButton(
                                buttonCheck: true,
                                color: Get.find<GetSTorageController>()
                                            .box
                                            .read(kEducation)
                                            .toString() ==
                                        "Diploma"
                                    ? textcolor
                                    : Colors.white,
                                textColor: Get.find<GetSTorageController>()
                                            .box
                                            .read(kEducation)
                                            .toString() ==
                                        "Diploma"
                                    ? Colors.white
                                    : Colors.black,
                                buttonText: "Diploma",
                                onButtonPressed: () {
                                  storage.box.write(kEducation, "Diploma");
                                  setState(() {});
                                },
                              ),
                            )),
                            AppComponents().sizedBox15,
                            Center(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: kAppButton(
                                buttonCheck: true,
                                color: Get.find<GetSTorageController>()
                                            .box
                                            .read(kEducation)
                                            .toString() ==
                                        "Bachelor’s degree"
                                    ? textcolor
                                    : Colors.white,
                                textColor: Get.find<GetSTorageController>()
                                            .box
                                            .read(kEducation)
                                            .toString() ==
                                        "Bachelor’s degree"
                                    ? Colors.white
                                    : Colors.black,
                                buttonText: "Bachelor’s degree",
                                onButtonPressed: () {
                                  storage.box
                                      .write(kEducation, "Bachelor’s degree");
                                  setState(() {});
                                },
                              ),
                            )),
                            AppComponents().sizedBox15,
                            Center(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: kAppButton(
                                buttonCheck: true,
                                color: Get.find<GetSTorageController>()
                                            .box
                                            .read(kEducation)
                                            .toString() ==
                                        "Master’s degree"
                                    ? textcolor
                                    : Colors.white,
                                textColor: Get.find<GetSTorageController>()
                                            .box
                                            .read(kEducation)
                                            .toString() ==
                                        "Master’s degree"
                                    ? Colors.white
                                    : Colors.black,
                                buttonText: "Master’s degree",
                                onButtonPressed: () {
                                  storage.box
                                      .write(kEducation, "Master’s degree");
                                  setState(() {});
                                },
                              ),
                            )),
                            AppComponents().sizedBox15,
                            Center(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: kAppButton(
                                buttonCheck: true,
                                color: Get.find<GetSTorageController>()
                                            .box
                                            .read(kEducation)
                                            .toString() ==
                                        "PhD"
                                    ? textcolor
                                    : Colors.white,
                                textColor: Get.find<GetSTorageController>()
                                            .box
                                            .read(kEducation)
                                            .toString() ==
                                        "PhD"
                                    ? Colors.white
                                    : Colors.black,
                                buttonText: "PhD",
                                onButtonPressed: () {
                                  storage.box.write(kEducation, "PhD");
                                  setState(() {});
                                },
                              ),
                            )),
                            AppComponents().sizedBox30,
                            Center(
                              child: controller.isLoader
                                  ? CircularProgressIndicator()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: kAppButton(
                                        buttonText: "Update",
                                        onButtonPressed: () {
                                          if (storage.box
                                                  .read(kEducation)
                                                  .toString() !=
                                              "") {
                                            controller.updateProfile(context,
                                                parameter: "education",
                                                value: storage.box
                                                    .read(kEducation));
                                          } else {
                                            snackBar(
                                                context,
                                                "Please select education",
                                                Colors.pink);
                                          }
                                        },
                                      ),
                                    ),
                            )
                          ],
                        )
                      : SizedBox.shrink(),
                  widget.martial_status
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "Martial Status",
                                style: k25styleblack,
                              ),
                            ),
                            AppComponents().sizedBox40,
                            Center(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: kAppButton(
                                buttonCheck: true,
                                color: Get.find<GetSTorageController>()
                                            .box
                                            .read(kMartial_Statius)
                                            .toString() ==
                                        "Never Married"
                                    ? textcolor
                                    : Colors.white,
                                textColor: Get.find<GetSTorageController>()
                                            .box
                                            .read(kMartial_Statius)
                                            .toString() ==
                                        "Never Married"
                                    ? Colors.white
                                    : Colors.black,
                                buttonText: "Never Married",
                                onButtonPressed: () {
                                  storage.box
                                      .write(kMartial_Statius, "Never Married");
                                  setState(() {});
                                },
                              ),
                            )),
                            AppComponents().sizedBox15,
                            Center(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: kAppButton(
                                buttonCheck: true,
                                color: Get.find<GetSTorageController>()
                                            .box
                                            .read(kMartial_Statius)
                                            .toString() ==
                                        "Divorced"
                                    ? textcolor
                                    : Colors.white,
                                textColor: Get.find<GetSTorageController>()
                                            .box
                                            .read(kMartial_Statius)
                                            .toString() ==
                                        "Divorced"
                                    ? Colors.white
                                    : Colors.black,
                                buttonText: "Divorced",
                                onButtonPressed: () {
                                  storage.box
                                      .write(kMartial_Statius, "Divorced");
                                  setState(() {});
                                },
                              ),
                            )),
                            AppComponents().sizedBox15,
                            Center(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: kAppButton(
                                buttonCheck: true,
                                color: Get.find<GetSTorageController>()
                                            .box
                                            .read(kMartial_Statius)
                                            .toString() ==
                                        "Widowed"
                                    ? textcolor
                                    : Colors.white,
                                textColor: Get.find<GetSTorageController>()
                                            .box
                                            .read(kMartial_Statius)
                                            .toString() ==
                                        "Widowed"
                                    ? Colors.white
                                    : Colors.black,
                                buttonText: "Widowed",
                                onButtonPressed: () {
                                  storage.box
                                      .write(kMartial_Statius, "Widowed");
                                  setState(() {});
                                },
                              ),
                            )),
                            AppComponents().sizedBox15,
                            Center(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: kAppButton(
                                buttonCheck: true,
                                color: Get.find<GetSTorageController>()
                                            .box
                                            .read(kMartial_Statius)
                                            .toString() ==
                                        "Prefer not to say"
                                    ? textcolor
                                    : Colors.white,
                                textColor: Get.find<GetSTorageController>()
                                            .box
                                            .read(kMartial_Statius)
                                            .toString() ==
                                        "Prefer not to say"
                                    ? Colors.white
                                    : Colors.black,
                                buttonText: "Prefer not to say",
                                onButtonPressed: () {
                                  storage.box.write(
                                      kMartial_Statius, "Prefer not to say");
                                  setState(() {});
                                },
                              ),
                            )),
                            AppComponents().sizedBox30,
                            Center(
                              child: controller.isLoader
                                  ? CircularProgressIndicator()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: kAppButton(
                                        buttonText: "Update",
                                        onButtonPressed: () {
                                          if (storage.box
                                                  .read(kMartial_Statius)
                                                  .toString() !=
                                              "") {
                                            controller.updateProfile(context,
                                                parameter: "martial_status",
                                                value: storage.box
                                                    .read(kMartial_Statius));
                                          } else {
                                            snackBar(
                                                context,
                                                "PLease Select Martial Status",
                                                Colors.pink);
                                          }
                                        },
                                      ),
                                    ),
                            )
                          ],
                        )
                      : SizedBox.shrink(),
                  widget.childs
                      ? GetBuilder<RegisterController>(builder: (controller2) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "Children's",
                                  style: k25styleblack,
                                ),
                              ),
                              AppComponents().sizedBox40,
                              Center(
                                child: buildProfileDropDown(
                                    text: "0",
                                    list: kChildernList!,
                                    value: controller2.selectedChild,
                                    onchange: (value) {
                                      controller2.selectedChildFunction(value);
                                    },
                                    controller: controller),
                              ),
                              AppComponents().sizedBox30,
                              Center(
                                child: controller.isLoader
                                    ? CircularProgressIndicator()
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: kAppButton(
                                          buttonText: "Update",
                                          onButtonPressed: () {
                                            if (controller2.selectedChild
                                                    .toString() !=
                                                "") {
                                              controller.updateProfile(context,
                                                  parameter: "childerns",
                                                  value: controller2
                                                      .selectedChild
                                                      .toString());
                                            } else {
                                              snackBar(
                                                  context,
                                                  "PLease Select Childrens",
                                                  Colors.pink);
                                            }
                                          },
                                        ),
                                      ),
                              )
                            ],
                          );
                        })
                      : SizedBox.shrink(),
                  widget.city
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "City",
                                style: k25styleblack,
                              ),
                            ),
                            AppComponents().sizedBox40,
                            Center(
                              child: buildProfileDropDown(
                                  text: "Islamabad",
                                  list: kCityList2!,
                                  value: controller.selectedCity == ""
                                      ? kCityList2![0]
                                      : controller.selectedCity,
                                  onchange: (value) {
                                    controller
                                        .selectedCityFunction(value.toString());
                                  },
                                  controller: controller),
                            ),
                            AppComponents().sizedBox30,
                            Center(
                              child: controller.isLoader
                                  ? CircularProgressIndicator()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: kAppButton(
                                        buttonText: "Update",
                                        onButtonPressed: () {
                                          if (controller.selectedCity != "") {
                                            controller.updateProfile(context,
                                                parameter: "address",
                                                value: controller.selectedCity);
                                          } else {
                                            snackBar(
                                                context,
                                                "PLease Select City",
                                                Colors.pink);
                                          }
                                        },
                                      ),
                                    ),
                            )
                          ],
                        )
                      : SizedBox.shrink(),
                  widget.caste
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "Caste",
                                style: k25styleblack,
                              ),
                            ),
                            AppComponents().sizedBox40,
                            Center(
                              child: buildProfileDropDown(
                                  text: "Abbasi",
                                  list: kcasteList2!,
                                  value: controller.selectedCaste == ""
                                      ? kcasteList2![0]
                                      : controller.selectedCaste,
                                  onchange: (value) {
                                    controller.selectedCasteFunction(
                                        value.toString());
                                  },
                                  controller: controller),
                            ),
                            AppComponents().sizedBox30,
                            Center(
                              child: controller.isLoader
                                  ? CircularProgressIndicator()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: kAppButton(
                                        buttonText: "Update",
                                        onButtonPressed: () {
                                          if (controller.selectedCaste != "") {
                                            controller.updateProfile(context,
                                                parameter: "caste",
                                                value:
                                                    controller.selectedCaste);
                                          } else {
                                            snackBar(
                                                context,
                                                "PLease Select Caste",
                                                Colors.pink);
                                          }
                                        },
                                      ),
                                    ),
                            )
                          ],
                        )
                      : SizedBox.shrink(),
                  widget.religion
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "Religion",
                                style: k25styleblack,
                              ),
                            ),
                            AppComponents().sizedBox40,
                            Center(
                              child: buildProfileDropDown(
                                  text: "Sunni",
                                  list: kReligionList2!,
                                  value: controller.selectedReligion == ""
                                      ? kReligionList2![0]
                                      : controller.selectedReligion,
                                  onchange: (value) {
                                    controller.selectedReligionFunction(
                                        value.toString());
                                  },
                                  controller: controller),
                            ),
                            AppComponents().sizedBox30,
                            Center(
                              child: controller.isLoader
                                  ? CircularProgressIndicator()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: kAppButton(
                                        buttonText: "Update",
                                        onButtonPressed: () {
                                          if (controller.selectedReligion !=
                                              "") {
                                            controller.updateProfile(context,
                                                parameter: "religion",
                                                value: controller
                                                    .selectedReligion);
                                          } else {
                                            snackBar(
                                                context,
                                                "PLease Select Religion",
                                                Colors.pink);
                                          }
                                        },
                                      ),
                                    ),
                            )
                          ],
                        )
                      : SizedBox.shrink(),
                  widget.religion_practise
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "Religion Practise",
                                style: k25styleblack,
                              ),
                            ),
                            AppComponents().sizedBox40,
                            Center(
                              child: buildProfileDropDown(
                                  text: "Very Practising",
                                  list: kPractisingList2!,
                                  value:
                                      controller.selectedPractisingStatus == ""
                                          ? kPractisingList2![0]
                                          : controller.selectedPractisingStatus,
                                  onchange: (value) {
                                    controller.selectedPractisingFunction(
                                        value.toString());
                                  },
                                  controller: controller),
                            ),
                            AppComponents().sizedBox30,
                            Center(
                              child: controller.isLoader
                                  ? CircularProgressIndicator()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: kAppButton(
                                        buttonText: "Update",
                                        onButtonPressed: () {
                                          if (controller
                                                  .selectedPractisingStatus !=
                                              "") {
                                            controller.updateProfile(context,
                                                parameter: "religious_practice",
                                                value: controller
                                                    .selectedPractisingStatus);
                                          } else {
                                            snackBar(
                                                context,
                                                "PLease Select Religion Practise",
                                                Colors.pink);
                                          }
                                        },
                                      ),
                                    ),
                            )
                          ],
                        )
                      : SizedBox.shrink(),
                  widget.interests
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                "Your Interests",
                                style: k25styleblack,
                              ),
                            ),
                            AppComponents().sizedBox10,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                  "Select a few of your interests and let everyone know what you’re passionate about."),
                            ),
                            AppComponents().sizedBox20,
                            Wrap(
                              direction: Axis.horizontal,
                              runAlignment: WrapAlignment.start,
                              runSpacing: 10,
                              spacing: 10,
                              children:
                                  List.generate(topicContents!.length, (index) {
                                final topic = topicContents![index];
                                controller.getListt!.forEach((element) {
                                  if (element.title == topic.title) {
                                    controller.getListt!.remove(element);
                                    controller.getListt!.add(topic);
                                  }
                                });
                                return IntrinsicWidth(
                                  child: InterestWidget(
                                    textstyle:
                                        controller.getListt!.contains(topic)
                                            ? k14styleWhite
                                            : k14styleblack,
                                    horizontalDistance: 15,
                                    borderColor:
                                        controller.getListt!.contains(topic)
                                            ? primarycolor
                                            : Colors.grey.shade300,
                                    image: topicContents![index].image!,
                                    title: topicContents![index].title,
                                    onTap: () {
                                      if (!controller.getListt!
                                          .contains(topic)) {
                                        controller.addTopics(topic);
                                      } else {
                                        controller.removeTopics(topic);
                                      }
                                    },
                                    color: controller.getListt!.contains(topic)
                                        ? primarycolor
                                        : Colors.white,
                                  ),
                                );
                              }),
                            ),
                            AppComponents().sizedBox20,
                            Center(
                              child: controller.isLoader
                                  ? CircularProgressIndicator()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: kAppButton(
                                        buttonText: "Update",
                                        onButtonPressed: () {
                                          controller.sendInteresetList();
                                          if (controller
                                              .interestsList.isNotEmpty) {
                                            controller.updateProfile(context,
                                                parameter: "hobbies",
                                                value:
                                                    controller.interestsList);
                                          } else {
                                            snackBar(
                                                context,
                                                "PLease Select Interests",
                                                Colors.pink);
                                          }
                                        },
                                      ),
                                    ),
                            )
                          ],
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
