import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Utils/enums.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';

class Register_Smoke extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppComponents().backIcon(),
              AppComponents().sizedBox50,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Do you smoke",
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
                            'Do you smoke?',
                            style: k14styleWhite,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: ksmokeList!
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: k14styleWhite,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: controller.selectedSmoke,
                    onChanged: (value) {
                      controller.selectedSmokeFunction(value);
                    },
                    icon: Icon(
                      Icons.arrow_drop_down_outlined,
                    ),
                    dropdownMaxHeight: 300,
                    iconSize: 24,
                    iconEnabledColor: Colors.white,
                    iconDisabledColor: Colors.grey,
                    buttonHeight: 50,
                    buttonWidth: MediaQuery.of(context).size.width,
                    buttonPadding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: butoncolor,
                    ),
                    offset: Offset(0, -20),
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
              controller.selectedSmoke != "Do you smoke?"
                  ? Center(
                      child: kCustomButton(
                        label: "Continue",
                        ontap: () {
                          if (controller.selectedSmoke.toString() !=
                              "Do you smoke?") {
                            Get.find<GetSTorageController>().box.write(
                                kSmoke, controller.selectedSmoke.toString());
                            controller.setRegisterViewPage(
                                RegisterViewEnum.RegisterView9);
                          } else {
                            snackBar(context, "Please Select the answer",
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
      );
    });
  }
}
