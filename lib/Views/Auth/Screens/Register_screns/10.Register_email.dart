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
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return GetBuilder<RegisterController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: key,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppComponents().backIcon(() {
                  controller
                      .setRegisterViewPage(RegisterViewEnum.RegisterView5);
                }),
                AppComponents().sizedBox50,
                Get.find<GetSTorageController>().box.read("isPhone") ==
                        "isPhone"
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "My email is",
                          style: k25styleblack,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "My Phone Number is",
                          style: k25styleblack,
                        ),
                      ),
                AppComponents().sizedBox50,
                Get.find<GetSTorageController>().box.read("isPhone") ==
                        "isPhone"
                    ? Center(
                        child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: kCustomTextField(
                            hinttext: "johndoe@gmail.com",
                            labeltext: "Email",
                            controller: controller.emailController,
                            validator: (value) {
                              return "";
                            }),
                      ))
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: IntlPhoneField(
                          showDropdownIcon: false,
                          autofocus: true,
                          flagsButtonMargin: EdgeInsets.only(left: 10),
                          style:
                          TextStyle(
                              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            filled: true,
                            isCollapsed: true,
                            contentPadding: EdgeInsets.only(
                                top: 20, bottom: 20, left: 1),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(16),
                                borderSide: BorderSide(
                                    color: Colors.grey.shade300,width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(16),
                                borderSide: BorderSide(
                                    color: textcolor)),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(16),
                                borderSide: BorderSide(
                                    color: Colors.grey.shade300,width: 1)),
                          ),
                          validator: (value) {
                            if (value!.completeNumber.isEmpty) {
                              snackBar(
                                  context,
                                  "Please Enter Your Phone Number",
                                  Colors.pink);
                            }
                          },
                          initialCountryCode: 'PK',
                          onChanged: (phone) {
                            print(phone.completeNumber);
                            Get.find<GetSTorageController>()
                                .box
                                .write(kPhone, phone.completeNumber);
                          },
                        )),
                AppComponents().sizedBox30,
                Get.find<GetSTorageController>().box.read("isPhone") ==
                        "isPhone"
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: kAppButton(
                            buttonText: "Continue",
                            onButtonPressed: () {
                              if (controller
                                      .emailController.value.text.isNotEmpty &&
                                  controller.emailController.value.text.isEmail !=
                                      false) {
                                Get.find<GetSTorageController>().box.write(kEmail,
                                    controller.emailController.value.text);
                                controller.setRegisterViewPage(
                                    RegisterViewEnum.RegisterView7);
                              } else {
                                snackBar(context, "Please Enter Valid Email",
                                    Colors.pink);
                              }
                            },
                          ),
                        ),
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: kAppButton(
                            buttonText: "Continue",
                            onButtonPressed: () {
                              controller.setRegisterViewPage(
                                  RegisterViewEnum.RegisterView7);
                            },
                          buttonstyleSmall: true,
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
      );
    });
  }
}
