import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';

class Add_Education extends StatelessWidget {
  const Add_Education({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storageController = Get.find<GetSTorageController>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppComponents().sizedBox30,
                AppComponents().backIcon(),
                AppComponents().sizedBox20,
                Center(
                    child: Image.asset(
                  "assets/education.png",
                  height: 41,
                  width: 48,
                )),
                AppComponents().sizedBox10,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Center(
                    child: Text(
                      "Education",
                      style: k25styleblack,
                    ),
                  ),
                ),
                AppComponents().sizedBox50,
                Center(
                    child: kCustomButton(
                  label: "High School",
                  ontap: () {
                    storageController.box.write(kEducation, "High School");
                    Get.back();
                  },
                  isRegister: true,
                )),
                AppComponents().sizedBox15,
                Center(
                    child: kCustomButton(
                  label: "Diploma",
                  ontap: () {
                    storageController.box.write(kEducation, "Diploma");
                    Get.back();
                  },
                  isRegister: true,
                )),
                AppComponents().sizedBox15,
                Center(
                    child: kCustomButton(
                  label: "Bachelor’s degree",
                  ontap: () {
                    storageController.box
                        .write(kEducation, "Bachelor’s degree");
                    Get.back();
                  },
                  isRegister: true,
                )),
                AppComponents().sizedBox15,
                Center(
                    child: kCustomButton(
                  label: "Master’s degree",
                  ontap: () {
                    storageController.box.write(kEducation, "Master’s degree");
                    Get.back();
                  },
                  isRegister: true,
                )),
                AppComponents().sizedBox15,
                Center(
                    child: kCustomButton(
                  label: "PhD",
                  ontap: () {
                    storageController.box.write(kEducation, "PhD");
                    Get.back();
                  },
                  isRegister: true,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
