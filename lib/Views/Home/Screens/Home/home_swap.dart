// import 'dart:math' as math;
// import 'dart:ui';
//
// import 'package:blur/blur.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:jabwemeet/Components/App_Components.dart';
// import 'package:jabwemeet/Models/UserModel.dart';
// import 'package:jabwemeet/Utils/constants.dart';
// import 'package:jabwemeet/Views/Home/Controllers/home_page_controller.dart';
// import 'package:jabwemeet/Views/Home/Screens/Home/Home_Components.dart';
// import 'package:jabwemeet/Views/Home/Screens/Home/filterScreen.dart';
// import 'package:jabwemeet/Views/Home/Screens/Tabbar.dart';
// import 'package:like_button/like_button.dart';
// import 'package:swipable_stack/swipable_stack.dart';
//
// class HomeSwap extends StatefulWidget {
//   @override
//   State<HomeSwap> createState() => _HomeSwapState();
// }
//
// class _HomeSwapState extends State<HomeSwap> {
//   final controller = Get.find<Home_page_controller>();
//   _get_to_previous() {
//     stackController.canRewind
//         ? stackController.rewind(duration: Duration(milliseconds: 1400))
//         : null;
//   }
//
//   _update_like() {
//     //  widget.user!.isLiked = true;
//     stackController.next(
//         duration: Duration(milliseconds: 1400),
//         swipeDirection: SwipeDirection.right);
//
//     setState(() {});
//     // if (!widget.user!.isLiked!) {
//     //  all_CRUD_user_operation().add_user_to_interest(widget.user!);
//     // }
//   }
//
//   int length = 0;
//   _update_Follow() {
//     stackController.next(
//         duration: Duration(milliseconds: 700),
//         swipeDirection: SwipeDirection.up);
//
//     // if (!widget.user!.isFollow!) {
//     //   all_CRUD_user_operation().unfollow_user(widget.user!);
//     // } else {
//     //   all_CRUD_user_operation().add_user_to_follow(widget.user!);
//     // }
//     setState(() {});
//   }
//
//   _ignore_it() async {
//     stackController.next(
//         duration: Duration(milliseconds: 1400),
//         swipeDirection: SwipeDirection.left);
//     //  bool val = await all_CRUD_user_operation().add_user_to_ignore(widget.user!);
//
//     // print(val);
//   }
//
//   SwipableStackController stackController = SwipableStackController();
//   PageController? pagecontroller = PageController();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     if (stackController.hasListeners) {
//       print("has listem");
//       stackController.removeListener(() {});
//     }
//     setState(() {
//       stackController = SwipableStackController()..addListener(() {});
//     });
//     pagecontroller = PageController(initialPage: 0);
//   }
//
//   // PageController pagecontroller = PageController();
//   @override
//   Widget build(BuildContext context) {
//     final bool isImageBlur = false;
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
//
//                           UserModel userModell = UserModel.fromMap(
//                               snapshot.data!.docs[length].data()
//                                   as Map<String, dynamic>);
//                           controller.Listing_List.add(userModell);
//
//                           return controller.Listing_List.value.length > 0
//                               ? SwipableStack(
//                                   detectableSwipeDirections: const {
//                                     SwipeDirection.right,
//                                     SwipeDirection.left,
//                                   },
//                                   itemCount: controller.Listing_List.length,
//                                   controller: stackController,
//                                   stackClipBehaviour: Clip.none,
//                                   allowVerticalSwipe: true,
//                                   builder: (context, properties) {
//                                     print("Length ");
//                                     print(controller.Listing_List.length
//                                         .toString());
//                                     // UserModel userModel = UserModel.fromMap(
//                                     //     snapshot.data!.docs[properties.index]
//                                     //         .data() as Map<String, dynamic>);
//                                     // print(
//                                     //     "<===========Image Url=============>");
//                                     return InkWell(
//                                       onTap: () async {},
//                                       child: Blur(
//                                         colorOpacity: isImageBlur ? 0.5 : 0,
//                                         blurColor: Colors.transparent,
//                                         blur: isImageBlur ? 20 : 0,
//                                         overlay: Container(
//                                           alignment: Alignment.bottomCenter,
//                                           padding: const EdgeInsets.all(10.0),
//                                           child: Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             children: [
//                                               Text.rich(TextSpan(children: [
//                                                 TextSpan(
//                                                   text:
//                                                       "${controller.Listing_List[properties.index].name.toString()}",
//                                                   style: k16styleWhite,
//                                                 ),
//                                                 if (controller
//                                                         .Listing_List[
//                                                             properties.index]
//                                                         .age
//                                                         .toString() !=
//                                                     "null")
//                                                   TextSpan(
//                                                     text: ", " +
//                                                         controller
//                                                             .Listing_List[
//                                                                 properties
//                                                                     .index]
//                                                             .age
//                                                             .toString(),
//                                                     style: k16styleWhiteBold,
//                                                   )
//                                               ])),
//                                               Container(
//                                                 child: Wrap(
//                                                   spacing: 10,
//                                                   children: [
//                                                     if (controller
//                                                             .Listing_List[
//                                                                 properties
//                                                                     .index]
//                                                             .work
//                                                             .toString() !=
//                                                         "null")
//                                                       SizedBox(
//                                                         width: 20,
//                                                       ),
//                                                     if (controller
//                                                             .Listing_List[
//                                                                 properties
//                                                                     .index]
//                                                             .religion
//                                                             .toString() !=
//                                                         "null")
//                                                       outlined_button(
//                                                         txt: controller
//                                                             .Listing_List[
//                                                                 properties
//                                                                     .index]
//                                                             .religion
//                                                             .toString(),
//                                                         ontap: () {},
//                                                         icon: Icon(Icons.map),
//                                                       ),
//                                                     if (controller
//                                                             .Listing_List[
//                                                                 properties
//                                                                     .index]
//                                                             .address
//                                                             .toString() !=
//                                                         "null")
//                                                       outlined_button(
//                                                         txt: controller
//                                                             .Listing_List[
//                                                                 properties
//                                                                     .index]
//                                                             .address
//                                                             .toString(),
//                                                         ontap: () {},
//                                                         icon: Icon(Icons.map),
//                                                       ),
//                                                     if (controller
//                                                             .Listing_List[
//                                                                 properties
//                                                                     .index]
//                                                             .work
//                                                             .toString() !=
//                                                         "null")
//                                                       outlined_button(
//                                                         txt: controller
//                                                             .Listing_List[
//                                                                 properties
//                                                                     .index]
//                                                             .work
//                                                             .toString(),
//                                                         ontap: () {},
//                                                         icon: Icon(Icons.work),
//                                                       ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 height: 5,
//                                               ),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   LikeButton(
//                                                     onTap: (_) async {
//                                                       controller
//                                                           .Listing_List.value
//                                                           .remove(
//                                                               properties.index);
//                                                       setState(() {});
//                                                       Future.delayed(Duration(
//                                                               milliseconds:
//                                                                   800))
//                                                           .then((value) => {
//                                                                 _ignore_it(),
//                                                               });
//
//                                                       return Future.value(_);
//                                                     },
//                                                     size: 50,
//                                                     isLiked: null,
//                                                     circleColor: CircleColor(
//                                                       start:
//                                                           Colors.red.shade400,
//                                                       end: Colors.red.shade100,
//                                                     ),
//                                                     bubblesColor: BubblesColor(
//                                                       dotPrimaryColor:
//                                                           Colors.red,
//                                                       dotSecondaryColor:
//                                                           Colors.white,
//                                                     ),
//                                                     likeBuilder:
//                                                         (bool isLiked) {
//                                                       return CircleAvatar(
//                                                         backgroundColor:
//                                                             Colors.white,
//                                                         radius: 28,
//                                                         child: Image.asset(
//                                                           "assets/icons/passed.png",
//                                                           height: 29,
//                                                         ),
//                                                       );
//                                                     },
//
//                                                     // likeCountPadding: const EdgeInsets.only(left: 15.0),
//                                                   ),
//                                                   //LIKE button
//                                                   LikeButton(
//                                                     onTap: (_) async {
//                                                       print("HITTING HE");
//                                                       Future.delayed(Duration(
//                                                               milliseconds:
//                                                                   800))
//                                                           .then((value) =>
//                                                               {_update_like()});
//
//                                                       return Future.value(_);
//                                                     },
//                                                     size: 50,
//                                                     isLiked: null,
//                                                     circleColor: CircleColor(
//                                                       start:
//                                                           Colors.green.shade400,
//                                                       end:
//                                                           Colors.green.shade100,
//                                                     ),
//                                                     bubblesColor: BubblesColor(
//                                                       dotPrimaryColor:
//                                                           Colors.green,
//                                                       dotSecondaryColor:
//                                                           Colors.white,
//                                                     ),
//                                                     likeBuilder:
//                                                         (bool isLiked) {
//                                                       return CircleAvatar(
//                                                         backgroundColor:
//                                                             Colors.white,
//                                                         radius: 28,
//                                                         child: Image.asset(
//                                                           "assets/icons/liked.png",
//                                                           height: 29,
//                                                           color: primarycolor,
//                                                         ),
//                                                       );
//                                                     },
//
//                                                     // likeCountPadding: const EdgeInsets.only(left: 15.0),
//                                                   ),
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         child: Card(
//                                           clipBehavior: Clip.antiAlias,
//                                           elevation: 4.0,
//                                           margin: EdgeInsets.zero,
//                                           shape: defaultCardBorder(),
//                                           child: Container(
//                                             alignment: Alignment.center,
//                                             decoration: BoxDecoration(
//                                               /// User profile image
//                                               image: DecorationImage(
//                                                 //   colorFilter: controller.Listing_List[properties.index].imageBlur??false? ColorFilter.mode(Colors.black, BlendMode.xor) : null,
//                                                 /// Show VIP icon if user is not vip member
//                                                 image: NetworkImage(controller
//                                                     .Listing_List[
//                                                         properties.index]
//                                                     .imageUrl
//                                                     .toString()),
//                                                 fit: BoxFit.cover,
//                                               ),
//                                             ),
//                                             child: Container(
//                                               /// BoxDecoration to make user info visible
//                                               decoration: BoxDecoration(
//                                                 gradient: LinearGradient(
//                                                     begin:
//                                                         Alignment.bottomRight,
//                                                     colors: [
//                                                       Colors.black87,
//                                                       Colors.transparent
//                                                     ]),
//                                               ),
//
//                                               /// User info container
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   onWillMoveNext: (index, swipeDirection) {
//                                     if (length < snapshot.data!.docs.length) {
//                                       setState(() {
//                                         length++;
//                                       });
//                                       UserModel userModell = UserModel.fromMap(
//                                           snapshot.data!.docs[length].data()
//                                               as Map<String, dynamic>);
//                                       controller.Listing_List.add(userModell);
//                                     }
// // Return true for the desired swipe direction.
//                                     switch (swipeDirection) {
//                                       case SwipeDirection.left:
//                                         {
//                                           controller.Listing_List.value
//                                               .remove(index--);
//                                           setState(() {});
//                                           return true;
//                                         }
//                                       case SwipeDirection.right:
//                                         {
//                                           print("====> right");
//                                           controller.Listing_List.value
//                                               .remove(index--);
//                                           setState(() {});
//                                           return true;
//                                         }
//                                       case SwipeDirection.up:
//                                         {
//                                           print("====> up");
//                                           controller.Listing_List.value
//                                               .remove(index--);
//                                           setState(() {});
//
//                                           return true;
//                                         }
//                                       case SwipeDirection.down:
//                                         return false;
//                                     }
//                                   },
//                                   horizontalSwipeThreshold: 0.8,
//                                   verticalSwipeThreshold: 1,
//                                   overlayBuilder: (
//                                     context,
//                                     properties,
//                                   ) =>
//                                       CardOverlay(
//                                     swipeProgress: properties.swipeProgress,
//                                     direction: properties.direction,
//                                   ),
//                                 )
//                               : Text("Your Free Version is expire");
//
//                           /*PageView.builder(
//                             physics: BouncingScrollPhysics(),
//                             itemCount: snapshot.data!.docs.length,
//                             controller: pagecontroller,
//                             onPageChanged: (page) {
//                               controller.selectedIndex = page;
//                               controller.update();
//                             },
//                             itemBuilder: (BuildContext context, index) {
//                               userModel userModel = userModel.fromMap(
//                                   snapshot.data!.docs[index].data()
//                                   as Map<String, dynamic>);
//                               print("<===========Image Url=============>");
//                               log(userModel.imageUrl.toString());
//                               return Card(
//                                 clipBehavior: Clip.antiAlias,
//                                 color: Colors.white,
//                                 margin: EdgeInsets.zero,
//                                 // shape: defaultCardBorder(),
//                                 child: Container(
//                                   margin: EdgeInsets.only(bottom: 10),
//                                   child: Column(
//                                     children: [
//                                       Expanded(
//                                         child: Stack(
//                                           children: [
//                                             CachedNetworkImage(
//                                               height: MediaQuery.of(context)
//                                                   .size
//                                                   .height,
//                                               width: MediaQuery.of(context)
//                                                   .size
//                                                   .width,
//                                               imageUrl:
//                                               userModel.imageUrl.toString(),
//                                               imageBuilder:
//                                                   (context, imageProvider) =>
//                                                   Container(
//                                                     decoration: BoxDecoration(
//                                                       image: DecorationImage(
//                                                         image: imageProvider,
//                                                         fit: BoxFit.cover,
//                                                       ),
//                                                     ),
//                                                   ),
//                                               placeholder: (context, url) =>
//                                                   Center(
//                                                     child: SizedBox(
//                                                       width: 40.0,
//                                                       height: 40.0,
//                                                       child:
//                                                       new CircularProgressIndicator(),
//                                                     ),
//                                                   ),
//                                               errorWidget:
//                                                   (context, url, error) =>
//                                                   Icon(Icons.error),
//                                             ),
//                                             Positioned(
//                                               bottom: 0,
//                                               left: 0,
//                                               right: 0,
//                                               child: BackdropFilter(
//                                                 filter: ImageFilter.blur(
//                                                     sigmaX: 0.0, sigmaY: 0.1),
//                                                 child: Container(
//                                                   height: 150,
//                                                   alignment:
//                                                   Alignment.bottomCenter,
//                                                   child: Container(
//                                                     alignment:
//                                                     Alignment.bottomLeft,
//                                                     padding:
//                                                     const EdgeInsets.all(
//                                                         7.0),
//                                                     child: Column(
//                                                       mainAxisSize:
//                                                       MainAxisSize.max,
//                                                       mainAxisAlignment:
//                                                       MainAxisAlignment.end,
//                                                       crossAxisAlignment:
//                                                       CrossAxisAlignment
//                                                           .start,
//                                                       children: [
//                                                         InkWell(
//                                                           onTap: () {
//                                                             // Get.to(() =>
//                                                             //     ProfileDetails());
//                                                           },
//                                                           child: Text(
//                                                             userModel.name
//                                                                 .toString(),
//                                                             style:
//                                                             k18stylePrimary,
//                                                           ),
//                                                         ),
//                                                         Row(
//                                                           mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                           children: [
//                                                             Column(
//                                                               crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                               children: [
//                                                                 Text(
//                                                                   "Age: " +
//                                                                       userModel
//                                                                           .age
//                                                                           .toString(),
//                                                                   style:
//                                                                   k10stylePrimary,
//                                                                 ),
//                                                                 SizedBox(
//                                                                   height: 5,
//                                                                 ),
//                                                                 Text(
//                                                                   "Profession: " +
//                                                                       userModel
//                                                                           .work
//                                                                           .toString(),
//                                                                   style:
//                                                                   k10stylePrimary,
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                             */
//                           /*        InkWell(
//                                                               onTap:
//                                                                   () async {
//                                                                 log("1 chat room not null");
//                                                                 ChatRoomModel?
//                                                                     chatRoom =
//                                                                     await controller.getchatRoom(userModel.uid.toString(), context);
//                                                                 log("2 chat room not null");
//                                                                 if ((chatRoom!.chatRoomId !=
//                                                                     null)) {
//                                                                   log("3 chat room not null");
//                                                                   Get.to(() => PersonMessageView(
//                                                                       name: userModel.name.toString(),
//                                                                       profilePicture: userModel.imageUrl.toString(),
//                                                                       uid: userModel.uid.toString(),
//                                                                       chatRoomModel: chatRoom));
//                                                                 }
//                                                               },
//                                                               child:
//                                                                   Container(
//                                                                 height:
//                                                                     50,
//                                                                 width:
//                                                                     50,
//                                                                 padding: EdgeInsets.symmetric(
//                                                                     horizontal: 10,
//                                                                     vertical: 10),
//                                                                 decoration: BoxDecoration(
//                                                                     color: Color(0xFFFA2A39),
//                                                                     shape: BoxShape.circle),
//                                                                 child:
//                                                                     Image.asset(
//                                                                   "assets/icons/chat2.png",
//                                                                   color:
//                                                                       Colors.white,
//                                                                 ),
//                                                               ),
//                                                             )*/ /*
//                                                           ],
//                                                         ),
//                                                         AppComponents()
//                                                             .sizedBox10,
//                                                         Row(
//                                                           mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                           children: [
//                                                             Image.asset(
//                                                               "assets/icons/cancel.png",
//                                                               height: 50,
//                                                               width: 50,
//                                                             ),
//                                                             InkWell(
//                                                               onTap: () async {
//                                                                 log("1");
//                                                                 LikesModel?
//                                                                 chatRoom =
//                                                                 await controller.getLikes(
//                                                                     userModel
//                                                                         .uid
//                                                                         .toString(),
//                                                                     userModel
//                                                                         .fcm_token
//                                                                         .toString(),
//                                                                     context);
//                                                                 log("2");
//                                                                 if ((chatRoom !=
//                                                                     null)) {
//                                                                   */ /* snackBar(
//                                                                       context,
//                                                                       "Your Like the ${userModel.name}",
//                                                                       Colors.pink);*/ /*
//                                                                 }
//                                                               },
//                                                               child: Container(
//                                                                 height: 50,
//                                                                 width: 50,
//                                                                 padding: EdgeInsets
//                                                                     .symmetric(
//                                                                     horizontal:
//                                                                     10,
//                                                                     vertical:
//                                                                     10),
//                                                                 decoration: BoxDecoration(
//                                                                     color: Color(
//                                                                         0xFFFA2A39),
//                                                                     shape: BoxShape
//                                                                         .circle),
//                                                                 child:
//                                                                 Image.asset(
//                                                                   "assets/icons/heart.png",
//                                                                   color: Colors
//                                                                       .white,
//                                                                 ),
//                                                               ),
//                                                             )
//                                                           ],
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           );*/
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
//
// class CardOverlay extends StatelessWidget {
//   const CardOverlay({
//     required this.direction,
//     required this.swipeProgress,
//     Key? key,
//   }) : super(key: key);
//   final SwipeDirection direction;
//   final double swipeProgress;
//
//   @override
//   Widget build(BuildContext context) {
//     final opacity = math.min<double>(swipeProgress, 1);
//
//     final isRight = direction == SwipeDirection.right;
//     final isLeft = direction == SwipeDirection.left;
//     final isUp = direction == SwipeDirection.up;
//     final isDown = direction == SwipeDirection.down;
//     return Stack(
//       children: [
//         Opacity(
//           opacity: isRight ? opacity : 0,
//           child: CardLabel.right(),
//         ),
//         Opacity(
//           opacity: isLeft ? opacity : 0,
//           child: CardLabel.left(),
//         ),
//         Opacity(
//           opacity: isUp ? opacity : 0,
//           child: CardLabel.up(),
//         ),
//         // Opacity(
//         //   opacity: isDown ? opacity : 0,
//         //   child: CardLabel.down(),
//         // ),
//       ],
//     );
//   }
// }
//
// const _labelAngle = math.pi / 2 * 0.2;
//
// class CardLabel extends StatelessWidget {
//   const CardLabel._({
//     required this.color,
//     required this.image_asset,
//     required this.angle,
//     required this.alignment,
//     Key? key,
//   }) : super(key: key);
//
//   factory CardLabel.right() {
//     return const CardLabel._(
//       color: Colors.green,
//       image_asset: "assets/icons/liked.png",
//       angle: -_labelAngle,
//       alignment: Alignment.topLeft,
//     );
//   }
//
//   factory CardLabel.left() {
//     return const CardLabel._(
//       color: Colors.red,
//       image_asset: "assets/icons/passed.png",
//       angle: _labelAngle,
//       alignment: Alignment.topRight,
//     );
//   }
//
//   factory CardLabel.up() {
//     return const CardLabel._(
//       color: Colors.blue,
//       image_asset: "assets/icons/liked.png",
//       angle: 0,
//       alignment: Alignment.topCenter,
//     );
//   }
//
//   // factory CardLabel.down() {
//   //   return const CardLabel._(
//   //     color: Colors.grey,
//   //     label: 'DOWN',
//   //     angle: -_labelAngle,
//   //     alignment: Alignment(0, -0.75),
//   //   );
//   // }
//
//   final Color color;
//   final String image_asset;
//   final double angle;
//   final Alignment alignment;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: alignment,
//       padding: const EdgeInsets.symmetric(
//         vertical: 36,
//         horizontal: 36,
//       ),
//       child: Transform.rotate(
//         angle: angle,
//         child: Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: color,
//               width: 4,
//             ),
//             color: Colors.white,
//           ),
//           padding: const EdgeInsets.all(6),
//           child: CircleAvatar(
//             backgroundColor: Colors.white,
//             radius: 20,
//             child: IconButton(
//               onPressed: null,
//               icon: Image.asset(
//                 image_asset,
//                 height: 22,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
