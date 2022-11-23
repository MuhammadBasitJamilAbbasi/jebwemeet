// import 'package:eat_central_customers/Components/App_Components.dart';
// import 'package:eat_central_customers/Components/KCommonText.dart';
// import 'package:eat_central_customers/Components/kCommonOtp.dart';
// import 'package:eat_central_customers/Components/kCommonPadding.dart';
// import 'package:eat_central_customers/Utils/constants.dart';
// import 'package:eat_central_customers/Utils/kCommonSizedBox.dart';
// import 'package:eat_central_customers/Views/Auth/Controllers/OtpVerification_Controller.dart';
// import 'package:eat_central_customers/Views/Auth/Screens/ResetPassword.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../../../Components/kCommonButton.dart';
//
// class OtpVerification extends StatelessWidget {
//   OtpVerification_Controller controller =
//       Get.find<OtpVerification_Controller>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primarycolor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//             physics: NeverScrollableScrollPhysics(),
//             child: Column(
//               children: [
//                 kCommonPadding(
//                   top: 57.h,
//                   left: 20.w,
//                   right: 00.w,
//                   bottom: 25.40.h,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           Get.back();
//                         },
//                         child: Icon(
//                           Icons.arrow_back_ios,
//                           color: whitecolor,
//                         ),
//                       ),
//                       Expanded(
//                         child: Container(
//                           padding: EdgeInsets.only(right: 40.w),
//                           alignment: Alignment.center,
//                           child: Image.asset(
//                             "Assets/Images/logoo2.png",
//                             width: context.isPortrait
//                                 ? MediaQuery.of(context).size.height * .3
//                                 : 0,
//                             height: context.isPortrait
//                                 ? MediaQuery.of(context).size.width * .3
//                                 : 0,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: context.isPortrait
//                       ? MediaQuery.of(context).size.height
//                       : MediaQuery.of(context).size.height - 50,
//                   decoration: BoxDecoration(
//                       color: whitecolor,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(30.sp),
//                         topRight: Radius.circular(30.sp),
//                       )),
//                   child: kCommonPadding(
//                       top: 24.h,
//                       left: 20.w,
//                       right: 20.w,
//                       bottom: 0.h,
//                       child: SingleChildScrollView(
//                         physics: ScrollPhysics(),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             KCommonText(
//                                 text: "OTP Verfication",
//                                 combination: 2,
//                                 fontweight: FontWeight.w400,
//                                 fontsize: 30,
//                                 color: blackcolor),
//                             kCommonSizedBox(height: 18.h, width: 0),
//                             KCommonText(
//                                 text:
//                                     "Enter the code you recieved on your phone number",
//                                 fontweight: FontWeight.w400,
//                                 fontsize: 15,
//                                 color: normaltextcolor),
//                             kCommonSizedBox(height: 50.h, width: 0),
//                             kCommonOtp(otpcode: controller.otpcode),
//                             AppComponents().sizedBox10,
//                             context.isPortrait
//                                 ? kCommonSizedBox(height: 218.h, width: 0)
//                                 : SizedBox.shrink(),
//                             kCommonButton(
//                               ontap: () {
//                                 Get.to(() => ResetPassword());
//                               },
//                               text: "Verify",
//                             ),
//                             kCommonSizedBox(height: 55.h, width: 0),
//                             InkWell(
//                               onTap: () {},
//                               child: Center(
//                                 child: RichText(
//                                     text: TextSpan(
//                                         style: TextStyle(
//                                             color: primarycolor,
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w600),
//                                         children: <TextSpan>[
//                                       TextSpan(
//                                           text: "Dont Recieve Code? ",
//                                           style: TextStyle(
//                                               fontSize: 14, color: blackcolor)),
//                                       TextSpan(
//                                         text: "Resend Code",
//                                       ),
//                                     ])),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )),
//                 ),
//               ],
//             )),
//       ),
//     );
//   }
// }
