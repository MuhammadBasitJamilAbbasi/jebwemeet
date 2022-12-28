// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:jabwemeet/Components/App_Components.dart';
// import 'package:jabwemeet/Utils/constants.dart';
// import 'package:jabwemeet/Utils/enums.dart';
// import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
// import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';
//
// class Register_Star extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<RegisterController>(builder: (controller) {
//       return SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               AppComponents().backIcon(),
//               AppComponents().sizedBox50,
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 30),
//                 child: Text(
//                   "My Star Sign is",
//                   style: k25styleblack,
//                 ),
//               ),
//               AppComponents().sizedBox50,
//               Center(
//                 child: buildRegisterDropDown(
//                     text: "Select Star",
//                     list: kstarList!,
//                     value: controller.selectedStar,
//                     onchange: (value) {
//                       controller.selectedStarFunction(value);
//                     },
//                     controller: controller),
//               ),
//               AppComponents().sizedBox30,
//               controller.selectedStar != "Select Star"
//                   ? Center(
//                       child: kCustomButton(
//                         label: "Continue",
//                         ontap: () {
//                           if (controller.selectedStar.toString() !=
//                               "Select Star") {
//                             Get.find<GetSTorageController>().box.write(
//                                 kStar_sign, controller.selectedStar.toString());
//                             controller.setRegisterViewPage(
//                                 RegisterViewEnum.RegisterView8);
//                           } else {
//                             snackBar(context, "Please Enter your star sign",
//                                 Colors.pink);
//                           }
//                         },
//                         isRegister: true,
//                       ),
//                     )
//                   : SizedBox.shrink()
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
