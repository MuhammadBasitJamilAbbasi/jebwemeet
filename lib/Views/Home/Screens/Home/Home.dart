// import 'dart:developer';
// import 'dart:ui';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:jabwemeet/Components/App_Components.dart';
// import 'package:jabwemeet/Models/UserModel.dart';
// import 'package:jabwemeet/Utils/constants.dart';
// import 'package:jabwemeet/Views/Home/Controllers/home_page_controller.dart';
// import 'package:jabwemeet/Views/Home/Screens/Home/Profile_details.dart';
// import 'package:jabwemeet/Views/Home/Screens/Home/filterScreen.dart';
// import 'package:jabwemeet/Views/Home/Screens/Tabbar.dart';
//
// class Home extends StatelessWidget {
//   final controller = Get.find<Home_page_controller>();
//
//   PageController pagecontroller = PageController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: kCustomBottomNavBar(
//         index: 0,
//       ),
//       body: SafeArea(
//           child: GetBuilder<Home_page_controller>(
//               init: Home_page_controller(),
//               builder: (controller) {
//                 return Stack(
//                   children: [
//                     StreamBuilder<QuerySnapshot>(
//                         stream: controller.queryValue,
//                         builder: (context, snapshot) {
//                           if (!snapshot.hasData) {
//                             return Center(
//                               child: CircularProgressIndicator(),
//                             );
//                           } else if (!snapshot.hasData ||
//                               snapshot.hasError ||
//                               snapshot.data == null) {
//                             return Center(
//                               child: Padding(
//                                 padding: const EdgeInsets.only(top: 68.0),
//                                 child: Text(
//                                   "No Data found...",
//                                   style: TextStyle(
//                                       fontSize: 20, color: Colors.black),
//                                 ),
//                               ),
//                             );
//                           }
//                           if (snapshot.data!.size == 0) {
//                             return Center(
//                               child: Padding(
//                                 padding: const EdgeInsets.only(top: 68.0),
//                                 child: Text(
//                                   "No Matches Yet...",
//                                   style: TextStyle(
//                                       fontSize: 20, color: Colors.black),
//                                 ),
//                               ),
//                             );
//                           }
//                           List<QueryDocumentSnapshot> userlist = [];
//                           snapshot.data!.docs.forEach((element) {
//                             if (element.get('age') >=
//                                     controller.filterlowerValue.round() &&
//                                 element.get('gender') == controller.gender) {
//                               userlist.add(element);
//                             }
//                           });
//                           print("user list length");
//                           print(userlist.length.toString());
//                           return PageView.builder(
//                             physics: BouncingScrollPhysics(),
//                             itemCount: userlist.length,
//                             controller: pagecontroller,
//                             onPageChanged: (page) {
//                               controller.selectedIndex = page;
//                               controller.update();
//                             },
//                             itemBuilder: (BuildContext context, index) {
//                               UserModel userModel = UserModel.fromMap(
//                                   userlist[index].data()
//                                       as Map<String, dynamic>);
//                               print("<===========Image Url=============>");
//                               log(userModel.imageUrl.toString());
//                               return InkWell(
//                                 onTap: () {
//                                   Get.to(() => ProfileDetails(
//                                       name: userModel.name.toString() ?? "",
//                                       martial_status:
//                                           userModel.martial_status.toString() ??
//                                               "",
//                                       work: userModel.work.toString() ?? "",
//                                       email: userModel.email.toString() ?? "",
//                                       address:
//                                           userModel.address.toString() ?? "",
//                                       age: userModel.age.toString() ?? "",
//                                       height: userModel.height.toString() ?? "",
//                                       gender: userModel.gender.toString() ?? "",
//                                       image:
//                                           userModel.imageUrl.toString() ?? "",
//                                       industry:
//                                           userModel.industry.toString() ?? "",
//                                       education:
//                                           userModel.education.toString() ?? "",
//                                       imgeList: userModel.imagesList ?? [],
//                                       about: userModel.about.toString() ?? "",
//                                       phone:
//                                           userModel.phone_number.toString() ??
//                                               "",
//                                       jobtitle: userModel.job_title ?? ""));
//                                 },
//                                 child: Card(
//                                   clipBehavior: Clip.antiAlias,
//                                   color: Colors.white,
//                                   margin: EdgeInsets.zero,
//                                   // shape: defaultCardBorder(),
//                                   child: Container(
//                                     margin: EdgeInsets.only(bottom: 10),
//                                     child: Column(
//                                       children: [
//                                         Expanded(
//                                           child: Stack(
//                                             children: [
//                                               CachedNetworkImage(
//                                                 height: MediaQuery.of(context)
//                                                     .size
//                                                     .height,
//                                                 width: MediaQuery.of(context)
//                                                     .size
//                                                     .width,
//                                                 imageUrl: userModel.imageUrl
//                                                     .toString(),
//                                                 imageBuilder:
//                                                     (context, imageProvider) =>
//                                                         Container(
//                                                   decoration: BoxDecoration(
//                                                     image: DecorationImage(
//                                                       image: imageProvider,
//                                                       fit: BoxFit.cover,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 placeholder: (context, url) =>
//                                                     Center(
//                                                   child: SizedBox(
//                                                     width: 40.0,
//                                                     height: 40.0,
//                                                     child:
//                                                         new CircularProgressIndicator(),
//                                                   ),
//                                                 ),
//                                                 errorWidget:
//                                                     (context, url, error) =>
//                                                         Icon(Icons.error),
//                                               ),
//                                               Positioned(
//                                                 bottom: 30,
//                                                 left: 0,
//                                                 right: 0,
//                                                 child: BackdropFilter(
//                                                   filter: ImageFilter.blur(
//                                                       sigmaX: 1.0, sigmaY: 0.1),
//                                                   child: Container(
//                                                     height: 150,
//                                                     alignment:
//                                                         Alignment.bottomCenter,
//                                                     child: Container(
//                                                       alignment:
//                                                           Alignment.bottomLeft,
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               7.0),
//                                                       child: Column(
//                                                         mainAxisSize:
//                                                             MainAxisSize.max,
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .end,
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           InkWell(
//                                                             onTap: () {
//                                                               // Get.to(() =>
//                                                               //     ProfileDetails());
//                                                             },
//                                                             child: Text(
//                                                               userModel.name
//                                                                   .toString(),
//                                                               style:
//                                                                   k18stylePrimary,
//                                                             ),
//                                                           ),
//                                                           Row(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceBetween,
//                                                             children: [
//                                                               Column(
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .start,
//                                                                 children: [
//                                                                   Text(
//                                                                     "Age: " +
//                                                                         userModel
//                                                                             .age
//                                                                             .toString(),
//                                                                     style:
//                                                                         k10stylePrimary,
//                                                                   ),
//                                                                   SizedBox(
//                                                                     height: 5,
//                                                                   ),
//                                                                   Text(
//                                                                     "Profession: " +
//                                                                         userModel
//                                                                             .work
//                                                                             .toString(),
//                                                                     style:
//                                                                         k10stylePrimary,
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                               /*        InkWell(
//                                                                 onTap:
//                                                                     () async {
//                                                                   log("1 chat room not null");
//                                                                   ChatRoomModel?
//                                                                       chatRoom =
//                                                                       await controller.getchatRoom(userModel.uid.toString(), context);
//                                                                   log("2 chat room not null");
//                                                                   if ((chatRoom!.chatRoomId !=
//                                                                       null)) {
//                                                                     log("3 chat room not null");
//                                                                     Get.to(() => PersonMessageView(
//                                                                         name: userModel.name.toString(),
//                                                                         profilePicture: userModel.imageUrl.toString(),
//                                                                         uid: userModel.uid.toString(),
//                                                                         chatRoomModel: chatRoom));
//                                                                   }
//                                                                 },
//                                                                 child:
//                                                                     Container(
//                                                                   height:
//                                                                       50,
//                                                                   width:
//                                                                       50,
//                                                                   padding: EdgeInsets.symmetric(
//                                                                       horizontal: 10,
//                                                                       vertical: 10),
//                                                                   decoration: BoxDecoration(
//                                                                       color: Color(0xFFFA2A39),
//                                                                       shape: BoxShape.circle),
//                                                                   child:
//                                                                       Image.asset(
//                                                                     "assets/icons/chat2.png",
//                                                                     color:
//                                                                         Colors.white,
//                                                                   ),
//                                                                 ),
//                                                               )*/
//                                                             ],
//                                                           ),
//                                                           AppComponents()
//                                                               .sizedBox10,
//                                                           Row(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceBetween,
//                                                             children: [
//                                                               Image.asset(
//                                                                 "assets/icons/cancel.png",
//                                                                 height: 50,
//                                                                 width: 50,
//                                                               ),
//                                                               InkWell(
//                                                                 onTap:
//                                                                     () async {
//                                                                   log("1");
//                                                                   userlist.remove(
//                                                                       userModel);
//                                                                 },
//                                                                 child:
//                                                                     Container(
//                                                                   height: 50,
//                                                                   width: 50,
//                                                                   padding: EdgeInsets.symmetric(
//                                                                       horizontal:
//                                                                           10,
//                                                                       vertical:
//                                                                           10),
//                                                                   decoration: BoxDecoration(
//                                                                       color: Color(
//                                                                           0xFFFA2A39),
//                                                                       shape: BoxShape
//                                                                           .circle),
//                                                                   child: Image
//                                                                       .asset(
//                                                                     "assets/icons/heart.png",
//                                                                     color: Colors
//                                                                         .white,
//                                                                   ),
//                                                                 ),
//                                                               )
//                                                             ],
//                                                           )
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           );
//                         }),
//                     Padding(
//                       padding: const EdgeInsets.all(18.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               Get.to(() => FilterScreen());
//                             },
//                             child: Image.asset(
//                               "assets/filter.png",
//                               height: 35,
//                               width: 35,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 );
//               })),
//     );
//   }
// }
