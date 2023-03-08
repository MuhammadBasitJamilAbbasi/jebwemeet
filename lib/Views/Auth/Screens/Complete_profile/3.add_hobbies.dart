import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Components/Interest_Widget.dart';
import 'package:jabwemeet/Models/Hobbies_Model.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/Profile_Controller.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/completeProfile/view/completeprofilescreen.dart';


class Add_Hoobies extends StatefulWidget {
  const Add_Hoobies({Key? key}) : super(key: key);

  @override
  State<Add_Hoobies> createState() => _Add_HoobiesState();
}

class _Add_HoobiesState extends State<Add_Hoobies> {
  @override
  Widget build(BuildContext context) {
    final storageController = Get.find<GetSTorageController>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<ProfileController>(
            builder: (controller) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppComponents().sizedBox30,
                    AppComponents().backIcon(() {
                      Get.back();
                    }),
                    AppComponents().sizedBox20,
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
                      child: Text("Select a few of your interests and let everyone know what you’re passionate about."),
                    )
                    ,AppComponents().sizedBox20,
                    Wrap(
                      direction: Axis.horizontal,
                      runAlignment: WrapAlignment.start,
                      runSpacing: 10,
                      spacing: 10,
                      children:
                          List.generate(topicContents!.length, (index) {
                        final topic = topicContents![index];
                        return IntrinsicWidth(
                          child: InterestWidget(
                            textstyle: controller.getList!.contains(topic)
                                ? k14styleWhite
                                : k14styleblack,
                            horizontalDistance: 15,
                            borderColor: controller.getList!.contains(topic)
                                ? primarycolor
                                : Colors.grey.shade300,
                            image: topicContents![index].image!,
                            title: topicContents![index].title,
                            onTap: () {
                                if (!controller.getList!.contains(topic)) {
                                  controller.addTopics(topic);
                                } else {
                                  controller.removeTopics(topic);
                                }
                            },
                            color: controller.getList!.contains(topic)
                                ? primarycolor
                                : Colors.white,
                          ),
                        );
                      }),
                    ),
                    AppComponents().sizedBox20,
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: kAppButton(
                            buttonText: "Continue",
                            onButtonPressed: () {
                              if (controller.getList!.length == 0) {
                                snackBar(
                                    context, "Select Interests", Colors.pink);
                              } else
                                Get.off(() => Complete_Profile1());
                            }),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
