import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/Profile_Controller.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/completeProfile/view/completeprofilescreen.dart';


class Add_Languages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storageController = Get.find<GetSTorageController>();

    return Scaffold(body: GetBuilder<ProfileController>(
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
                    Get.find<ProfileController>().scrollAnimate();
                    Get.back();
                  }),
                  AppComponents().sizedBox50,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "My Languages is",
                      style: k25styleblack,
                    ),
                  ),
                  AppComponents().sizedBox30,
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 5,
                    runSpacing: 15,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runAlignment: WrapAlignment.start,
                    children: kLanguageList!.map((String document) {
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
                                    : textcolor),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  AppComponents().sizedBox30,
                  controller.kList!.length > 0
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal:20 ),
                            child: kAppButton(
                              buttonText: "Save",
                              onButtonPressed: () {
                                Get.off(() => Complete_Profile1());
                              },
                            ),
                          ),
                        )
                      : SizedBox.shrink()
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
