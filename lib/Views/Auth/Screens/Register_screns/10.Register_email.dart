import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Utils/enums.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';

class Register_email extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return GetBuilder<RegisterController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppComponents().backIcon(),
              AppComponents().sizedBox50,
              Get.find<GetSTorageController>().box.read("isPhone") == "isPhone"
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        "My email is",
                        style: k25styleblack,
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        "My Phone Number is",
                        style: k25styleblack,
                      ),
                    ),
              AppComponents().sizedBox50,
              Get.find<GetSTorageController>().box.read("isPhone") == "isPhone"
                  ? Center(
                      child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: kCustomTextField(
                          hinttext: "Email",
                          controller: controller.emailController,
                          validator: (value) {
                            return "";
                          }),
                    ))
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: IntlPhoneField(
                        style: k16styleblack,
                        dropdownTextStyle: k16styleblack,
                        textAlignVertical: TextAlignVertical.center,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          floatingLabelStyle: k14styleblack,
                          labelStyle: k16styleblack,
                          helperStyle: k16styleblack,
                          hintStyle: k16styleblack,
                          prefixStyle: k16styleblack,
                          suffixStyle: k16styleblack,
                          counterStyle: k14styleblack,
                          filled: true,
                          contentPadding:
                              EdgeInsets.only(top: 10, bottom: 10, left: 10),
                          fillColor: Color(0xFFF4F0EE),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200)),
                        ),
                        initialCountryCode: 'PK',
                        onChanged: (phone) {
                          print(phone.completeNumber);
                          Get.find<GetSTorageController>()
                              .box
                              .write(kPhone, phone.completeNumber);
                        },
                      )),
              AppComponents().sizedBox15,
              Get.find<GetSTorageController>().box.read("isPhone") == "isPhone"
                  ? Center(
                      child: kCustomButton(
                        label: "Continue",
                        ontap: () {
                          if (controller
                                  .emailController.value.text.isNotEmpty &&
                              controller.emailController.value.text.isEmail !=
                                  false) {
                            Get.find<GetSTorageController>().box.write(
                                kEmail, controller.emailController.value.text);
                            controller.setRegisterViewPage(
                                RegisterViewEnum.RegisterView11);
                          } else {
                            snackBar(context, "Please Enter Valid Email",
                                Colors.pink);
                          }
                        },
                        isRegister: true,
                      ),
                    )
                  : Center(
                      child: kCustomButton(
                        label: "Continue",
                        ontap: () {
                          controller.setRegisterViewPage(
                              RegisterViewEnum.RegisterView11);
                        },
                        isRegister: true,
                      ),
                    )
            ],
          ),
        ),
      );
    });
  }
}
