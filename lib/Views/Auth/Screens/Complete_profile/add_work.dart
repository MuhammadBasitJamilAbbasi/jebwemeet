import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';

class Add_Work extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storageController = Get.find<GetSTorageController>();

    return Scaffold(body: GetBuilder<RegisterController>(
      builder: (controller) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppComponents().sizedBox30,
                  AppComponents().backIcon(),
                  AppComponents().sizedBox20,
                  AppComponents().sizedBox10,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "My Occupation Sector is",
                      style: k25styleblack,
                    ),
                  ),
                  AppComponents().sizedBox50,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: Row(
                          children: [
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                'Select Occupation Sector',
                                style: k14styleWhite,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: kWorkList!
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: k14styleWhite,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        value: controller.selectedwork,
                        onChanged: (value) {
                          controller.selectedWorkFunction(value);
                        },
                        icon: Icon(
                          Icons.arrow_drop_down_outlined,
                        ),
                        dropdownMaxHeight: 350,
                        iconSize: 24,
                        iconEnabledColor: Colors.white,
                        iconDisabledColor: Colors.grey,
                        buttonHeight: 50,
                        offset: Offset(0, -20),
                        buttonWidth: MediaQuery.of(context).size.width,
                        buttonPadding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        buttonDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: butoncolor,
                        ),
                        itemHeight: 40,
                        itemPadding: const EdgeInsets.only(left: 14, right: 14),
                        dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: butoncolor),
                        scrollbarRadius: const Radius.circular(40),
                        scrollbarThickness: 6,
                        scrollbarAlwaysShow: true,
                      ),
                    ),
                  ),
                  AppComponents().sizedBox30,
                  controller.selectedwork != "Select Occupation Sector"
                      ? Center(
                          child: kCustomButton(
                            label: "Save",
                            ontap: () {
                              if (controller.selectedwork.toString() !=
                                  "Select Occupation Sector") {
                                Get.find<GetSTorageController>().box.write(
                                    kWork, controller.selectedwork.toString());
                                Get.back();
                              } else {
                                snackBar(
                                    context,
                                    "Please Select your Occupation Sector",
                                    Colors.pink);
                              }
                            },
                            isRegister: true,
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
