import 'dart:developer';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Models/UserModel.dart';
import 'package:jabwemeet/Models/chatroom.model.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Home/Controllers/home_page_controller.dart';
import 'package:jabwemeet/Views/Home/Screens/Chat/messaging/personmessages.view.dart';
import 'package:jabwemeet/Views/Home/Screens/Home/filterScreen.dart';
import 'package:jabwemeet/Views/Home/Screens/Tabbar.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:uuid/uuid.dart';
//import 'package:marry_muslim/models/listing_custom_model.dart';

class Home extends StatelessWidget {
  final controller = Get.find<Home_page_controller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: kCustomBottomNavBar(
        index: 0,
      ),
      body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Expanded(
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: GetBuilder<Home_page_controller>(
                        init: Home_page_controller(),
                        builder: (controller) {
                          return Stack(
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                  stream: controller.queryValue,
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (!snapshot.hasData ||
                                        snapshot.hasError ||
                                        snapshot.data == null) {
                                      return Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 68.0),
                                          child: Text(
                                            "No Data found...",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                        ),
                                      );
                                    }
                                    if (snapshot.data!.size == 0) {
                                      return Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 68.0),
                                          child: Text(
                                            "No Matches Yet...",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                        ),
                                      );
                                    }
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          UserModel userModel =
                                              UserModel.fromMap(snapshot
                                                      .data!.docs[index]
                                                      .data()
                                                  as Map<String, dynamic>);
                                          print(
                                              "<===========Image Url=============>");
                                          log(userModel.imageUrl.toString());
                                          return Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Card(
                                              clipBehavior: Clip.antiAlias,
                                              color: Colors.white,
                                              margin: EdgeInsets.zero,
                                              // shape: defaultCardBorder(),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height -
                                                    80,
                                                margin:
                                                    EdgeInsets.only(bottom: 10),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child: Stack(
                                                        children: [
                                                          CachedNetworkImage(
                                                            height:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            imageUrl: userModel
                                                                .imageUrl
                                                                .toString(),
                                                            imageBuilder: (context,
                                                                    imageProvider) =>
                                                                Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            placeholder:
                                                                (context,
                                                                        url) =>
                                                                    Center(
                                                              child: SizedBox(
                                                                width: 40.0,
                                                                height: 40.0,
                                                                child:
                                                                    new CircularProgressIndicator(),
                                                              ),
                                                            ),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error),
                                                          ),
                                                          // CachedNetworkImage(
                                                          //   height:
                                                          //       MediaQuery.of(
                                                          //               context)
                                                          //           .size
                                                          //           .height,
                                                          //   width:
                                                          //       MediaQuery.of(
                                                          //               context)
                                                          //           .size
                                                          //           .width,
                                                          //   imageUrl: userModel
                                                          //       .imageUrl
                                                          //       .toString(),
                                                          //   fit: BoxFit.cover,
                                                          //   progressIndicatorBuilder:
                                                          //       (context, url,
                                                          //               downloadProgress) =>
                                                          //           Container(
                                                          //     height: 50,
                                                          //     width: 50,
                                                          //     child: CircularProgressIndicator(
                                                          //         value: downloadProgress
                                                          //             .progress),
                                                          //   ),
                                                          //   errorWidget:
                                                          //       (context, url,
                                                          //               error) =>
                                                          //           Icon(Icons
                                                          //               .error),
                                                          // ),
                                                          Container(
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            /*    decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image: NetworkImage(
                                                                  userModel.imageUrl
                                                                      .toString(),
                                                                ),
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),*/
                                                            child: Container(
                                                              alignment: Alignment
                                                                  .bottomLeft,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(7.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    userModel
                                                                        .name
                                                                        .toString(),
                                                                    style:
                                                                        k18stylePrimary,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            "Age: " +
                                                                                userModel.age.toString(),
                                                                            style:
                                                                                k10stylePrimary,
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            "Profession: " +
                                                                                userModel.work.toString(),
                                                                            style:
                                                                                k10stylePrimary,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          log("1 chat room not null");
                                                                          ChatRoomModel?
                                                                              chatRoom =
                                                                              await getchatRoom(userModel.uid.toString());
                                                                          log("2 chat room not null");
                                                                          if ((chatRoom !=
                                                                              null)) {
                                                                            log("3 chat room not null");
                                                                            Get.to(() => PersonMessageView(
                                                                                name: userModel.name.toString(),
                                                                                profilePicture: userModel.imageUrl.toString(),
                                                                                uid: userModel.uid.toString(),
                                                                                chatRoomModel: chatRoom));
                                                                          }
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              50,
                                                                          width:
                                                                              50,
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal: 10,
                                                                              vertical: 10),
                                                                          decoration: BoxDecoration(
                                                                              color: Color(0xFFFA2A39),
                                                                              shape: BoxShape.circle),
                                                                          child:
                                                                              Image.asset(
                                                                            "assets/icons/chat2.png",
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  AppComponents()
                                                                      .sizedBox10,
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        "assets/icons/cancel.png",
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            50,
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            50,
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10,
                                                                            vertical:
                                                                                10),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Color(0xFFFA2A39),
                                                                            shape: BoxShape.circle),
                                                                        child: Image
                                                                            .asset(
                                                                          "assets/icons/heart.png",
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(() => FilterScreen());
                                      },
                                      child: Image.asset(
                                        "assets/filter.png",
                                        height: 30,
                                        width: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        })))
          ])),
    );
  }

  Future<ChatRoomModel?> getchatRoom(var opponent_id) async {
    ChatRoomModel chatRoom = ChatRoomModel();
    User? user = FirebaseAuth.instance.currentUser;
    QuerySnapshot snapshotData = await FirebaseFirestore.instance
        .collection('chatrooms')
        .where('participants.${user!.uid}', isEqualTo: true)
        .where('participants.${opponent_id}', isEqualTo: true)
        .get();

    if (snapshotData.docs.length > 0) {
      var chatRoomData = snapshotData.docs[0].data();
      ChatRoomModel exisitingChatRoom =
          ChatRoomModel.fromMap(chatRoomData as Map<String, dynamic>);

      chatRoom = exisitingChatRoom;

      log('you have already a chatromm');
    } else {
      ChatRoomModel newChatRoom = ChatRoomModel(
          chatRoomId: Uuid().v1(),
          typing: [],
          participants: {
            user.uid: true,
            opponent_id: true,
          },
          isReadSender: true,
          isReadReceiver: false,
          lastMessage: '',
          lastMesgUserId: FirebaseAuth.instance.currentUser!.uid.toString());

      await FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(newChatRoom.chatRoomId)
          .set(newChatRoom.toMap());
      chatRoom = newChatRoom;

      log('Hurrah!new chat room created!');
    }

    return chatRoom;
  }
}

class CardOverlay extends StatelessWidget {
  const CardOverlay({
    required this.direction,
    required this.swipeProgress,
    Key? key,
  }) : super(key: key);
  final SwipeDirection direction;
  final double swipeProgress;

  @override
  Widget build(BuildContext context) {
    final opacity = math.min<double>(swipeProgress, 1);

    final isRight = direction == SwipeDirection.right;
    final isLeft = direction == SwipeDirection.left;
    final isUp = direction == SwipeDirection.up;
    final isDown = direction == SwipeDirection.down;
    return Stack(
      children: [
        Opacity(
          opacity: isRight ? opacity : 0,
          child: CardLabel.right(),
        ),
        Opacity(
          opacity: isLeft ? opacity : 0,
          child: CardLabel.left(),
        ),
        Opacity(
          opacity: isUp ? opacity : 0,
          child: CardLabel.up(),
        ),
        // Opacity(
        //   opacity: isDown ? opacity : 0,
        //   child: CardLabel.down(),
        // ),
      ],
    );
  }
}

const _labelAngle = math.pi / 2 * 0.2;

class CardLabel extends StatelessWidget {
  const CardLabel._({
    required this.color,
    required this.image_asset,
    required this.angle,
    required this.alignment,
    Key? key,
  }) : super(key: key);

  factory CardLabel.right() {
    return const CardLabel._(
      color: Colors.green,
      image_asset: "assets/icons/liked.png",
      angle: -_labelAngle,
      alignment: Alignment.topLeft,
    );
  }

  factory CardLabel.left() {
    return const CardLabel._(
      color: Colors.red,
      image_asset: "assets/icons/passed.png",
      angle: _labelAngle,
      alignment: Alignment.topRight,
    );
  }

  factory CardLabel.up() {
    return const CardLabel._(
      color: Colors.blue,
      image_asset: "assets/icons/star.png",
      angle: 0,
      alignment: Alignment.topCenter,
    );
  }

  // factory CardLabel.down() {
  //   return const CardLabel._(
  //     color: Colors.grey,
  //     label: 'DOWN',
  //     angle: -_labelAngle,
  //     alignment: Alignment(0, -0.75),
  //   );
  // }

  final Color color;
  final String image_asset;
  final double angle;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(
        vertical: 36,
        horizontal: 36,
      ),
      child: Transform.rotate(
        angle: angle,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: color,
              width: 4,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.all(6),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: IconButton(
              onPressed: null,
              icon: Image.asset(
                image_asset,
                height: 22,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
