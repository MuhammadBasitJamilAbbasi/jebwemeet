import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Utils/enums.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';
import 'package:jabwemeet/Views/Auth/Screens/Register_screns/Google_map.dart';

class Register_address extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppComponents().backIcon(),
              AppComponents().sizedBox50,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "I live in",
                  style: k25styleblack,
                ),
              ),
              AppComponents().sizedBox50,
              Center(
                  child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFEA7C4A),
                      Color(0xFFF1565A),
                    ],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    Get.to(() => kCustomGoogleMap());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => Text(
                            Get.find<RegisterController>().address.value != ""
                                ? Get.find<RegisterController>().address.value
                                : "Current City",
                            style: k14styleWhite)),
                        Image.asset(
                          "assets/location.png",
                          height: 24,
                          width: 24,
                        ),
                      ],
                    ),
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0.0),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: Color(0xfFf1565A)),
                      ),
                    ),
                  ),
                ),
              )),
              AppComponents().sizedBox15,
              Obx(() {
                return Get.find<RegisterController>().address.value != ""
                    ? Center(
                        child: kCustomButton(
                          label: "Continue",
                          ontap: () {
                            if (Get.find<GetSTorageController>()
                                    .box
                                    .read("loc")
                                    .toString() !=
                                "null") {
                              Get.find<GetSTorageController>().box.write(
                                  kAddress,
                                  Get.find<GetSTorageController>()
                                      .box
                                      .read("loc")
                                      .toString());
                              controller.setRegisterViewPage(
                                  RegisterViewEnum.RegisterView5);
                            } else {
                              snackBar(context, "Please Enter your age",
                                  Colors.pink);
                            }
                          },
                          isRegister: true,
                        ),
                      )
                    : SizedBox.shrink();
              })
            ],
          ),
        ),
      );
    });
  }
}
