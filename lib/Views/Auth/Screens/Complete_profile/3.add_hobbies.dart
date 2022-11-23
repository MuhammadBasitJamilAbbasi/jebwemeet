import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Components/Interest_Widget.dart';
import 'package:jabwemeet/Models/Hobbies_Model.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/Profile_Controller.dart';

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
          child: GetBuilder<ProfileConytroller>(
            builder: (controller) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppComponents().sizedBox30,
                    AppComponents().backIcon(),
                    AppComponents().sizedBox20,
                    Center(
                        child: Image.asset(
                      "assets/hobby.png",
                      height: 41,
                      width: 48,
                    )),
                    AppComponents().sizedBox10,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Center(
                        child: Text(
                          "Interests",
                          style: k25styleblack,
                        ),
                      ),
                    ),
                    AppComponents().sizedBox20,
                    Wrap(
                      direction: Axis.horizontal,
                      runAlignment: WrapAlignment.start,
                      runSpacing: 10,
                      spacing: 10,
                      children:
                          List.generate(controller.allTopics.length, (index) {
                        final topic = controller.allTopics[index];
                        return IntrinsicWidth(
                          child: InterestWidget(
                            textstyle: controller.selectedList.contains(topic)
                                ? k14styleWhite
                                : k14styleblack,
                            horizontalDistance: 15,
                            image: topicContents[index].image,
                            title: topicContents[index].title,
                            onTap: () {
                              setState(() {
                                if (!controller.selectedItems.contains(topic)) {
                                  controller.addTopics(topic);
                                } else {
                                  controller.removeTopics(topic);
                                }
                              });
                            },
                            color: controller.selectedList.contains(topic)
                                ? butoncolor
                                : Colors.grey.shade300,
                          ),
                        );
                      }),
                    ),
                    AppComponents().sizedBox20,
                    Center(
                      child: kCustomButton(
                          label: "Continue",
                          ontap: () {
                            if (controller.selectedList.length == 0) {
                              snackBar(
                                  context, "Select Interests", Colors.pink);
                            } else
                              Get.back();
                          }),
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
