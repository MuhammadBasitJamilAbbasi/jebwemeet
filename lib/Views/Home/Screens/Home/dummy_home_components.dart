// import 'dart:developer';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:jabwemeet/Components/App_Components.dart';
// import 'package:jabwemeet/Models/UserModel.dart';
// import 'package:jabwemeet/Models/chatroom.model.dart';
// import 'package:jabwemeet/Utils/constants.dart';
// import 'package:jabwemeet/Views/Home/Controllers/home_page_controller.dart';
// import 'package:jabwemeet/Views/Home/Screens/Chat/messaging/personmessages.view.dart';
// import 'package:jabwemeet/Views/Home/Screens/Home/filterScreen.dart';
// //import 'package:marry_muslim/models/listing_custom_model.dart';;
// import 'package:swipable_stack/swipable_stack.dart';
// import 'package:uuid/uuid.dart';
//
// class ProfileCard extends StatefulWidget {
//   @override
//   State<ProfileCard> createState() => _ProfileCardState();
// }
//
// class _ProfileCardState extends State<ProfileCard> {
//   _get_to_previous() {
//     Get.find<Home_page_controller>().stackController.canRewind
//         ? Get.find<Home_page_controller>()
//         .stackController
//         .rewind(duration: Duration(milliseconds: 1400))
//         : null;
//   }
//
//   _update_like() {
//     //  widget.user!.isLiked = true;
//     Get.find<Home_page_controller>().stackController.next(
//         duration: Duration(milliseconds: 1400),
//         swipeDirection: SwipeDirection.right);
//
//     setState(() {});
//     // if (!widget.user!.isLiked!) {
//     //  all_CRUD_user_operation().add_user_to_interest(widget.user!);
//     // }
//   }
//
//   _update_Follow() {
//     /* print(
//         "updating follow current is : ${widget.user!.isFollow = !widget.user!.isFollow!}");
//     widget.user!.isFollow = !widget.user!.isFollow!;
//     print(
//         "updating follow current is : ${widget.user!.isFollow = !widget.user!.isFollow!}");
// */
//     Get.find<Home_page_controller>().stackController.next(
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
//     Get.find<Home_page_controller>().stackController.next(
//         duration: Duration(milliseconds: 1400),
//         swipeDirection: SwipeDirection.left);
//     //  bool val = await all_CRUD_user_operation().add_user_to_ignore(widget.user!);
//
//     // print(val);
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // print("is BLUR =====> ${widget.user!.imageBlur}");
//     // final bool isImageBlur  = true;
//     final bool isImageBlur = false;
//     User? user = FirebaseAuth.instance.currentUser;
//     return Stack(
//       children: [
//         StreamBuilder<QuerySnapshot>(
//             stream: FirebaseFirestore.instance
//                 .collection("users")
//                 .where("age", isGreaterThanOrEqualTo: 18)
//                 .where("martial_status", isEqualTo: "Never Married")
//                 .where("address", isEqualTo: "Rawalpindi")
//                 .where("caste", isEqualTo: "Ansari")
//                 .where("religion", isEqualTo: "Islam")
//                 .snapshots(),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else if (!snapshot.hasData ||
//                   snapshot.hasError ||
//                   snapshot.data == null) {
//                 return Center(
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 68.0),
//                     child: Text(
//                       "No Data found...",
//                       style: TextStyle(fontSize: 20, color: Colors.black),
//                     ),
//                   ),
//                 );
//               }
//               return Container(
//                 height: MediaQuery.of(context).size.height,
//                 child: ListView.builder(
//                   physics: BouncingScrollPhysics(),
//                   padding: EdgeInsets.zero,
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (BuildContext context, index) {
//                     UserModel userModel = UserModel.fromMap(
//                         snapshot.data!.docs[index].data()
//                         as Map<String, dynamic>);
//                     print("<===========Image Url=============>");
//                     return Padding(
//                       padding: const EdgeInsets.all(0.0),
//                       child: Card(
//                         clipBehavior: Clip.antiAlias,
//                         color: Colors.white,
//                         margin: EdgeInsets.zero,
//                         // shape: defaultCardBorder(),
//                         child: Container(
//                           height: MediaQuery.of(context).size.height - 80,
//                           margin: EdgeInsets.only(bottom: 10),
//                           child: Column(
//                             children: [
//                               Expanded(
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                       image: NetworkImage(
//                                         userModel.imageUrl.toString(),
//                                       ),
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                   child: Container(
//                                     alignment: Alignment.bottomLeft,
//                                     padding: const EdgeInsets.all(7.0),
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.max,
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           userModel.name.toString(),
//                                           style: k18stylePrimary,
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Column(
//                                               crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   "Age: " +
//                                                       userModel.age.toString(),
//                                                   style: k10stylePrimary,
//                                                 ),
//                                                 SizedBox(
//                                                   height: 5,
//                                                 ),
//                                                 Text(
//                                                   "Profession: " +
//                                                       userModel.work.toString(),
//                                                   style: k10stylePrimary,
//                                                 ),
//                                               ],
//                                             ),
//                                             InkWell(
//                                               onTap: () async {
//                                                 log("1 chat room not null");
//                                                 ChatRoomModel? chatRoom =
//                                                 await getchatRoom(userModel
//                                                     .uid
//                                                     .toString());
//                                                 log("2 chat room not null");
//                                                 if ((chatRoom != null)) {
//                                                   log("3 chat room not null");
//                                                   Get.to(() =>
//                                                       PersonMessageView(
//                                                           name: userModel.name
//                                                               .toString(),
//                                                           profilePicture:
//                                                           userModel.imageUrl
//                                                               .toString(),
//                                                           uid: userModel.uid
//                                                               .toString(),
//                                                           chatRoomModel:
//                                                           chatRoom));
//                                                 }
//                                               },
//                                               child: Container(
//                                                 height: 50,
//                                                 width: 50,
//                                                 padding: EdgeInsets.symmetric(
//                                                     horizontal: 10,
//                                                     vertical: 10),
//                                                 decoration: BoxDecoration(
//                                                     color: Color(0xFFFA2A39),
//                                                     shape: BoxShape.circle),
//                                                 child: Image.asset(
//                                                   "assets/icons/chat2.png",
//                                                   color: Colors.white,
//                                                 ),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                         AppComponents().sizedBox10,
//                                         Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Image.asset(
//                                               "assets/icons/cancel.png",
//                                               height: 50,
//                                               width: 50,
//                                             ),
//                                             Container(
//                                               height: 50,
//                                               width: 50,
//                                               padding: EdgeInsets.symmetric(
//                                                   horizontal: 10, vertical: 10),
//                                               decoration: BoxDecoration(
//                                                   color: Color(0xFFFA2A39),
//                                                   shape: BoxShape.circle),
//                                               child: Image.asset(
//                                                 "assets/icons/heart.png",
//                                                 color: Colors.white,
//                                               ),
//                                             )
//                                           ],
//                                         )
//                                         /* Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                           CircleAvatar(
//                             backgroundColor: Colors.white,
//                             radius: 20,
//                             child: IconButton(
//                               onPressed: () {
//                                 _get_to_previous();
//                                 // Get.find<home_page_controller>()
//                                 //     .fetch_listing_data();
//                               },
//                               icon: Image.asset(
//                                 "assets/icons/restore.png",
//                                 color: Colors.orange,
//                                 height: 22,
//                               ),
//                             ),
//                           ),
//                           LikeButton(
//                             onTap: (_) async {
//                               Future.delayed(Duration(milliseconds: 800))
//                                   .then((value) => {
//                                         _ignore_it(),
//                                       });
//
//                               return Future.value(_);
//                             },
//                             size: 30,
//                             isLiked: null,
//                             circleColor: CircleColor(
//                               start: Colors.red.shade400,
//                               end: Colors.red.shade100,
//                             ),
//                             bubblesColor: BubblesColor(
//                               dotPrimaryColor: Colors.red,
//                               dotSecondaryColor: Colors.white,
//                             ),
//                             likeBuilder: (bool isLiked) {
//                               return CircleAvatar(
//                                 backgroundColor: Colors.white,
//                                 radius: 28,
//                                 child: Image.asset(
//                                   "assets/icons/passed.png",
//                                   height: 29,
//                                 ),
//                               );
//                             },
//
//                             // likeCountPadding: const EdgeInsets.only(left: 15.0),
//                           ),
//                           //ignore it
//
//                           // CircleAvatar(
//                           //   backgroundColor: Colors.white,
//                           //   radius: 20,
//                           //   child: IconButton(
//                           //     onPressed: () async {
//                           //       _update_Follow();
//                           //     },
//                           //     icon: Image.asset(
//                           //       "assets/icons/star.png",
//                           //       height: 22,
//                           //       color: !widget.user!.isFollow!
//                           //           ? Colors.blue
//                           //           : Colors.grey,
//                           //     ),
//                           //   ),
//                           // ),
//                           LikeButton(
//                             padding: EdgeInsets.zero,
//
//                             onTap: (_) async {
//                               Future.delayed(Duration(milliseconds: 800))
//                                   .then((value) =>
//                                       {print("asd"), _update_Follow()});
//
//                               return Future.value(_);
//                             },
//                             size: 30,
//                             isLiked: null,
//                             circleColor: CircleColor(
//                               start: Colors.transparent,
//                               end: Colors.transparent,
//                             ),
//                             bubblesColor: BubblesColor(
//                               dotPrimaryColor: Colors.blue,
//                               dotSecondaryColor: Colors.lightBlueAccent,
//                             ),
//                             likeBuilder: (bool isLiked) {
//                               return CircleAvatar(
//                                 backgroundColor: Colors.white,
//                                 radius: 20,
//                                 child: Image.asset(
//                                   "assets/icons/star.png",
//                                   height: 22,
//                                   color: Colors.blue,
//                                 ),
//                               );
//                             },
//
//                             // likeCountPadding: const EdgeInsets.only(left: 15.0),
//                           ), // follow
//                           // CircleAvatar(
//                           //   backgroundColor: Colors.white,
//                           //   radius: 28,
//                           //   child: IconButton(
//                           //     onPressed: () async {
//                           //       _update_like();
//                           //     },
//                           //     icon: Image.asset(
//                           //       "assets/icons/liked.png",
//                           //       height: 29,
//                           //       color: !widget.user!.isLiked!
//                           //           ? Colors.green
//                           //           : Colors.grey,
//                           //     ),
//                           //   ),
//                           // ),
//                           //LIKE button
//                           LikeButton(
//                             onTap: (_) async {
//                               print("HITTING HE");
//                               Future.delayed(Duration(milliseconds: 800))
//                                   .then((value) => {_update_like()});
//
//                               return Future.value(_);
//                             },
//                             size: 30,
//                             isLiked: null,
//                             circleColor: CircleColor(
//                               start: Colors.green.shade400,
//                               end: Colors.green.shade100,
//                             ),
//                             bubblesColor: BubblesColor(
//                               dotPrimaryColor: Colors.green,
//                               dotSecondaryColor: Colors.white,
//                             ),
//                             likeBuilder: (bool isLiked) {
//                               return CircleAvatar(
//                                 backgroundColor: Colors.white,
//                                 radius: 28,
//                                 child: Image.asset(
//                                   "assets/icons/liked.png",
//                                   height: 29,
//                                   // color: !widget.user!.isLiked!
//                                   //     ? Colors.green
//                                   //     : Colors.grey,
//                                 ),
//                               );
//                             },
//
//                             // likeCountPadding: const EdgeInsets.only(left: 15.0),
//                           ),
//                           //above is like
//                           // Get.find<storage_controller>().userModel.value.data!.membership.toString() == "1"? false : true;
//                           LikeButton(
//                             onTap: (_) async {},
//                             size: 30,
//                             isLiked: null,
//                             circleColor: CircleColor(
//                               start: Colors.transparent,
//                               end: Colors.transparent,
//                             ),
//                             bubblesColor: BubblesColor(
//                               dotPrimaryColor: Colors.purple,
//                               dotSecondaryColor: Colors.white,
//                             ),
//                             likeBuilder: (bool isLiked) {
//                               return CircleAvatar(
//                                 backgroundColor: Colors.white,
//                                 radius: 20,
//                                 child: Image.asset(
//                                   "assets/icons/flush.png",
//                                   height: 22,
//                                 ),
//                               );
//                             },
//                           ) //above is message
//                       ],
//                       )*/
//
//                                         // this.page == 'discover'
//                                         //     ? SizedBox(height: 70)
//                                         //     : Container(width: 0, height: 0),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             }),
//         Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               InkWell(
//                 onTap: () {
//                   Get.to(() => FilterScreen());
//                 },
//                 child: Image.asset(
//                   "assets/filter.png",
//                   height: 30,
//                   width: 30,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   //Function to check whether the chatroom between the current user and reciver is created or not
//   Future<ChatRoomModel?> getchatRoom(var opponent_id) async {
//     ChatRoomModel chatRoom = ChatRoomModel();
//     User? user = FirebaseAuth.instance.currentUser;
//     QuerySnapshot snapshotData = await FirebaseFirestore.instance
//         .collection('chatrooms')
//         .where('participants.${user!.uid}', isEqualTo: true)
//         .where('participants.${opponent_id}', isEqualTo: true)
//         .get();
//
//     if (snapshotData.docs.length > 0) {
//       var chatRoomData = snapshotData.docs[0].data();
//       ChatRoomModel exisitingChatRoom =
//       ChatRoomModel.fromMap(chatRoomData as Map<String, dynamic>);
//
//       chatRoom = exisitingChatRoom;
//
//       log('you have already a chatromm');
//     } else {
//       ChatRoomModel newChatRoom = ChatRoomModel(
//           chatRoomId: Uuid().v1(),
//           typing: [],
//           participants: {
//             user.uid: true,
//             opponent_id: true,
//           },
//           isReadSender: true,
//           isReadReceiver: false,
//           lastMessage: '',
//           lastMesgUserId: FirebaseAuth.instance.currentUser!.uid.toString());
//
//       await FirebaseFirestore.instance
//           .collection('chatrooms')
//           .doc(newChatRoom.chatRoomId)
//           .set(newChatRoom.toMap());
//       chatRoom = newChatRoom;
//
//       log('Hurrah!new chat room created!');
//     }
//
//     return chatRoom;
//   }
// }
//
// RoundedRectangleBorder defaultCardBorder() {
//   return RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//         bottomLeft: Radius.circular(28.0),
//         topRight: Radius.circular(28.0),
//         topLeft: Radius.circular(28.0),
//         bottomRight: Radius.circular(28.0),
//       ));
// }
