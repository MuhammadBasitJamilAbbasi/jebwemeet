import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Utils/enums.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';
import 'package:jabwemeet/Views/Auth/Screens/Register_screns/1.Register_gender.dart';
import 'package:jabwemeet/Views/Auth/Screens/Register_screns/10.Register_email.dart';
import 'package:jabwemeet/Views/Auth/Screens/Register_screns/11.Register_name.dart';
import 'package:jabwemeet/Views/Auth/Screens/Register_screns/12.Register_password.dart';
import 'package:jabwemeet/Views/Auth/Screens/Register_screns/3.age.dart';
import 'package:jabwemeet/Views/Auth/Screens/Register_screns/4.address.dart';
import 'package:jabwemeet/Views/Auth/Screens/Register_screns/5.religion.dart';
import 'package:jabwemeet/Views/Auth/Screens/Register_screns/6.Register_caste.dart';

class Register_screen extends StatelessWidget {
  const Register_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final communityController = Get.find<RegisterController>;

    return Scaffold(
      body: SafeArea(
        child: getBody(
          context,
        ),
      ),
    );
  }

  Widget getBody(BuildContext context) {
    return SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: GetBuilder<RegisterController>(
          init: RegisterController(),
          builder: (registerController) {
            return Container(
              height: context.isPortrait
                  ? MediaQuery.of(context).size.height - 50
                  : MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          progressIndicator(
                              context: context,
                              ontap: () =>
                                  registerController.setRegisterViewPage(
                                      RegisterViewEnum.RegisterView1),
                              color: registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView1 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView3 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView4 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView5 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView6 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView10 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView11 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView12
                                  ? butoncolor
                                  : Colors.grey.shade200),
                          progressIndicator(
                              context: context,
                              ontap: () =>
                                  registerController.setRegisterViewPage(
                                      RegisterViewEnum.RegisterView3),
                              color: registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView3 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView4 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView5 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView6 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView10 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView11 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView12
                                  ? butoncolor
                                  : Colors.grey.shade200),
                          progressIndicator(
                              context: context,
                              ontap: () =>
                                  registerController.setRegisterViewPage(
                                      RegisterViewEnum.RegisterView4),
                              color: registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView4 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView5 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView6 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView10 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView11 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView12
                                  ? butoncolor
                                  : Colors.grey.shade200),
                          progressIndicator(
                              context: context,
                              ontap: () =>
                                  registerController.setRegisterViewPage(
                                      RegisterViewEnum.RegisterView5),
                              color: registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView5 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView6 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView10 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView11 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView12
                                  ? butoncolor
                                  : Colors.grey.shade200),
                          progressIndicator(
                              context: context,
                              ontap: () =>
                                  registerController.setRegisterViewPage(
                                      RegisterViewEnum.RegisterView6),
                              color: registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView6 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView10 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView11 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView12
                                  ? butoncolor
                                  : Colors.grey.shade200),
                          progressIndicator(
                              context: context,
                              ontap: () =>
                                  registerController.setRegisterViewPage(
                                      RegisterViewEnum.RegisterView10),
                              color: registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView10 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView11 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView12
                                  ? butoncolor
                                  : Colors.grey.shade200),
                          progressIndicator(
                              context: context,
                              ontap: () =>
                                  registerController.setRegisterViewPage(
                                      RegisterViewEnum.RegisterView11),
                              color: registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView11 ||
                                      registerController.getRegisterViewPage ==
                                          RegisterViewEnum.RegisterView12
                                  ? butoncolor
                                  : Colors.grey.shade200),
                          progressIndicator(
                              context: context,
                              ontap: () =>
                                  registerController.setRegisterViewPage(
                                      RegisterViewEnum.RegisterView12),
                              color: registerController.getRegisterViewPage ==
                                      RegisterViewEnum.RegisterView12
                                  ? butoncolor
                                  : Colors.grey.shade200),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      getCreateCommunity(
                          registerController.getRegisterViewPage),
                      SizedBox(
                        height: 10,
                      ),
                    ]),
              ),
            );
          },
        ));
  }

  Widget getCreateCommunity(RegisterViewEnum getView) {
    switch (getView) {
      case RegisterViewEnum.RegisterView1:
        return Register_Gender();
      // case RegisterViewEnum.RegisterView2:
      //   return Register_Martial();
      case RegisterViewEnum.RegisterView3:
        return Register_Age();
      case RegisterViewEnum.RegisterView4:
        return Register_address();
      case RegisterViewEnum.RegisterView5:
        return Register_Religion();
      case RegisterViewEnum.RegisterView6:
        return Register_caste();
      // case RegisterViewEnum.RegisterView7:
      //   return Register_Star();
      // case RegisterViewEnum.RegisterView8:
      //   return Register_Smoke();
      // case RegisterViewEnum.RegisterView9:
      //   return Register_Creativity();
      case RegisterViewEnum.RegisterView10:
        return Register_email();
      case RegisterViewEnum.RegisterView11:
        return Register_Name();
      case RegisterViewEnum.RegisterView12:
        return Register_Password();
    }
  }
}
