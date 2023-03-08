import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Models/UserModel.dart';
import 'package:jabwemeet/Models/chatroom.model.dart';
import 'package:jabwemeet/Models/messaging.model/messages.model.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Home/Controllers/home_page_controller.dart';
import 'package:jabwemeet/Views/Home/Controllers/message_controller.dart';
import 'package:jabwemeet/Views/Home/Screens/Chat/messaging.widgets/load.image.dart';
import 'package:jabwemeet/Views/Home/Screens/Chat/messaging/chatlist.dart';
import 'package:jabwemeet/Views/Home/Screens/Profile/profilewithid.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:uuid/uuid.dart';

final bucket = PageStorageBucket();

class PersonMessageView extends StatefulWidget {
  const PersonMessageView({Key? key,
    required this.name,
    required this.age,
    required this.location,
    required this.profilePicture,
    required this.uid,
    required this.chatRoomModel})
      : super(key: key);

  final String name;
  final int age;
  final String location;
  final String profilePicture;
  final String uid;
  final ChatRoomModel chatRoomModel;

  @override
  State<PersonMessageView> createState() => _PersonMessageViewState();
}

class _PersonMessageViewState extends State<PersonMessageView> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? postStreamQuery;
  Stream<QuerySnapshot<Map<String, dynamic>>>? communityStreamQuery;

  @override
  void initState() {
    final controller = Get.find<MessageController>();
    controller.getMesssages =
        controller.getMessages(widget.chatRoomModel.chatRoomId!);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey _menuKey = GlobalKey();
  final filter = ProfanityFilter();

  @override
  Widget build(BuildContext context) {
    final messageController = Get.find<MessageController>();
    final controller = Get.find<Home_page_controller>();
    return Scaffold(
      body: PageStorage(
          bucket: bucket,
          child: getBody(
            messageController,
            controller,
            context,
          )),
    );
  }

//body
  Widget getBody(MessageController messageController,
      Home_page_controller controller,
      BuildContext context,) {
    UserModel? userModel;
    final button = Center(
      child: PopupMenuButton(
          key: _menuKey,
          iconSize: 24,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          itemBuilder: (_) =>
          const <PopupMenuItem<String>>[
            PopupMenuItem<String>(
                child: Text('Profile details'), value: 'Profile details'),
            PopupMenuItem<String>(child: Text('UnMatch'), value: 'UnMatch'),
            PopupMenuItem<String>(child: Text('Block'), value: 'Block'),
          ],
          onSelected: (_) {}),
    );
    return StreamBuilder<DocumentSnapshot>(
        stream: messageController.getMesssages,
        builder: (context, typingSnap) {
          if (typingSnap.connectionState == ConnectionState.waiting ||
              typingSnap.connectionState == ConnectionState.waiting) {} else
          if (typingSnap.connectionState == ConnectionState.active ||
              typingSnap.connectionState == ConnectionState.active) {
            if (typingSnap.hasData || typingSnap.hasData) {
              DocumentSnapshot typinngQuery =
              typingSnap.data as DocumentSnapshot;
              ChatRoomModel chatmodel = ChatRoomModel.fromMap(
                  typinngQuery.data() as Map<String, dynamic>);

              List? typingList = chatmodel.typing;

              messageController.postsIds.clear();
              messageController.communityIds.clear();
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppComponents().sizedBox40,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        SizedBox(
                            height: 30,
                            width: 30,
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.arrow_back_ios_rounded,
                                color: textcolor,
                                size: 20,
                              ),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        widget.profilePicture == ''
                            ? CircleAvatar(
                            backgroundColor: kBaseGrey,
                            backgroundImage:
                            AssetImage('Assets/images/user.png'))
                            : CircleAvatar(
                          radius: 20,
                          backgroundImage: CachedNetworkImageProvider(
                              widget.profilePicture),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.name.capitalizeFirst.toString() +
                                    ", " +
                                    widget.age.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              AppComponents().sizedBox5,
                              Text(
                                widget.location.toString(),
                                style: k14styleblack,
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showAlertDialog(
                                context,
                                profileTap: () {
                                  Get.back();
                                  Get.to(() => ProfileWithID(id: widget.uid));
                                },
                                unmatchTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Container(
                                            height: 180,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/appicon.png",
                                                  height: 45,
                                                  width: 45,
                                                ),
                                                SizedBox(height: 20),
                                                Center(
                                                    child: Text(
                                                        "Are you sure you wish to unmatch from ${widget
                                                            .name}")),
                                                SizedBox(height: 20),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          Get.off(() =>
                                                              MessageView());
                                                          controller
                                                              .getLikes(
                                                              isSenderAddress:
                                                              controller
                                                                  .userModel
                                                                  .address,
                                                              isReceiverAddress:
                                                              widget
                                                                  .location,
                                                              isReceiverAge:
                                                              widget.age,
                                                              isRecName:
                                                              widget.name,
                                                              isRecImage: widget
                                                                  .profilePicture,
                                                              opponent_id:
                                                              widget.uid,
                                                              fcm_token: controller
                                                                  .userModel
                                                                  .fcm_token,
                                                              context: context,
                                                              isSenderImage:
                                                              controller
                                                                  .userModel
                                                                  .imageUrl,
                                                              isSenderName:
                                                              controller
                                                                  .userModel
                                                                  .name,
                                                              isSenderAge:
                                                              controller
                                                                  .userModel
                                                                  .age!)
                                                              .then((
                                                              value) async {
                                                            QuerySnapshot
                                                            snapshotData =
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                'chatrooms')
                                                                .where(
                                                                'participants.${controller
                                                                    .userModel
                                                                    .uid}',
                                                                isEqualTo:
                                                                true)
                                                                .where(
                                                                'participants.${widget
                                                                    .uid}',
                                                                isEqualTo:
                                                                true)
                                                                .get();

                                                            if (snapshotData
                                                                .docs.length >
                                                                0) {
                                                              snapshotData.docs
                                                                  .forEach(
                                                                      (
                                                                      element) async {
                                                                    await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                        'chatrooms')
                                                                        .doc(
                                                                        element
                                                                            .id)
                                                                        .delete();
                                                                  });
                                                            }
                                                          });
                                                        },
                                                        child: Container(
                                                            height: 35,
                                                            child: Center(
                                                                child:
                                                                Text("Yes"))),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                            primary: textcolor),
                                                      ),
                                                    ),
                                                    SizedBox(width: 15),
                                                    Expanded(
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            print(
                                                                'no selected');
                                                            Navigator.of(
                                                                context).pop();
                                                          },
                                                          child: Container(
                                                              height: 35,
                                                              child: Center(
                                                                  child: Text(
                                                                      "No",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white)))),
                                                          style:
                                                          ElevatedButton
                                                              .styleFrom(
                                                            primary: textcolor,
                                                          ),
                                                        ))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                blockTap: () async {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Container(
                                            height: 180,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/appicon.png",
                                                  height: 45,
                                                  width: 45,
                                                ),
                                                SizedBox(height: 20),
                                                Center(
                                                    child: Text(
                                                        "Are you sure you wish to block ${widget
                                                            .name}")),
                                                SizedBox(height: 20),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          QuerySnapshot
                                                          snapshotData =
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                              'chatrooms')
                                                              .where(
                                                              'participants.${controller
                                                                  .userModel
                                                                  .uid}',
                                                              isEqualTo:
                                                              true)
                                                              .where(
                                                              'participants.${widget
                                                                  .uid}',
                                                              isEqualTo:
                                                              true)
                                                              .get();
                                                          if (snapshotData
                                                              .docs.length >
                                                              0) {
                                                            snapshotData.docs
                                                                .forEach(
                                                                    (
                                                                    element) async {
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                      'chatrooms')
                                                                      .doc(
                                                                      element
                                                                          .id)
                                                                      .delete();
                                                                });

                                                            Get.off(() =>
                                                                MessageView());
                                                            controller.block(
                                                                opponent_userid: widget
                                                                    .uid,
                                                                image: widget
                                                                    .profilePicture,
                                                                name: widget
                                                                    .name,
                                                                visitType: "block");
                                                          }
                                                        },
                                                        child: Container(
                                                            height: 35,
                                                            child: Center(
                                                                child:
                                                                Text("Yes"))),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                            primary: textcolor),
                                                      ),
                                                    ),
                                                    SizedBox(width: 15),
                                                    Expanded(
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            print(
                                                                'no selected');
                                                            Navigator.of(
                                                                context).pop();
                                                          },
                                                          child: Container(
                                                              height: 35,
                                                              child: Center(
                                                                  child: Text(
                                                                      "No",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white)))),
                                                          style:
                                                          ElevatedButton
                                                              .styleFrom(
                                                            primary: textcolor,
                                                          ),
                                                        ))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey.shade300)),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 11),
                                  child: Image.asset(
                                    "assets/dots.png",
                                    height: 15,
                                    width: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppComponents().sizedBox10,
                  Divider(),
                  AppComponents().sizedBox10,
                  Expanded(
                      child: StreamBuilder<QuerySnapshot?>(
                          stream: Get.find<MessageController>()
                              .listeningForMessages(widget.chatRoomModel),
                          builder: (context,
                              listenForChat,) {
                            if (!listenForChat.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (!listenForChat.hasData ||
                                listenForChat.hasError ||
                                listenForChat.data == null) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 68.0),
                                  child: Text(
                                    "No Messages Yet...",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ),
                              );
                            }
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 20),
                              child: SingleChildScrollView(
                                key:
                                PageStorageKey<String>('messagesScrollKey'),
                                controller: messageController.newMessageScroll,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    listenForChat == null
                                        ? SizedBox()
                                        : ListView.builder(
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemCount:
                                        listenForChat.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          MessageModel currentMessage =
                                          MessageModel.fromMap(
                                              listenForChat
                                                  .data!.docs[index]
                                                  .data()
                                              as Map<String,
                                                  dynamic>);
                                          return currentMessage.sender !=
                                              widget.uid
                                              ? Padding(
                                            padding:
                                            EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            child: Align(
                                              alignment: Alignment
                                                  .bottomRight,
                                              child: IntrinsicWidth(
                                                  child: Container(
                                                      alignment:
                                                      Alignment
                                                          .center,
                                                      padding: Uri
                                                          .parse(currentMessage
                                                          .message
                                                          .toString())
                                                          .isAbsolute
                                                          ? EdgeInsets
                                                          .zero
                                                          : EdgeInsets
                                                          .symmetric(
                                                          horizontal:
                                                          20,
                                                          vertical:
                                                          10),
                                                      decoration: BoxDecoration(
                                                          color: Uri
                                                              .parse(
                                                              currentMessage
                                                                  .message
                                                                  .toString())
                                                              .isAbsolute
                                                              ? Colors
                                                              .transparent
                                                              : Color(
                                                              0xFFF3F3F3),
                                                          borderRadius: Uri
                                                              .parse(
                                                              currentMessage
                                                                  .message
                                                                  .toString())
                                                              .isAbsolute
                                                              ? BorderRadius
                                                              .circular(
                                                              10)
                                                              : BorderRadius
                                                              .only(
                                                              topLeft: Radius
                                                                  .circular(15),
                                                              topRight: Radius
                                                                  .circular(15),
                                                              bottomLeft: Radius
                                                                  .circular(15),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                  0))),
                                                      child: Text(
                                                        currentMessage
                                                            .message
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .w400,
                                                            fontSize:
                                                            14,
                                                            color: Colors
                                                                .black),
                                                      )
                                                    //bodyStyle4KPrimary,
                                                  )),
                                            ),
                                          )
                                              : Padding(
                                            padding:
                                            EdgeInsets.symmetric(
                                              vertical: 5,
                                            ),
                                            child: Align(
                                              alignment: Alignment
                                                  .bottomLeft,
                                              child: IntrinsicWidth(
                                                child: Container(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  padding: EdgeInsets
                                                      .symmetric(
                                                      horizontal:
                                                      20,
                                                      vertical:
                                                      10),
                                                  decoration: BoxDecoration(
                                                      color: Uri
                                                          .parse(
                                                          currentMessage.message
                                                              .toString())
                                                          .isAbsolute
                                                          ? Colors
                                                          .transparent
                                                          : Color(0xFFE94057)
                                                          .withOpacity(
                                                          0.07),
                                                      borderRadius: Uri
                                                          .parse(currentMessage
                                                          .message
                                                          .toString())
                                                          .isAbsolute
                                                          ? BorderRadius
                                                          .circular(
                                                          4)
                                                          : BorderRadius.only(
                                                          topLeft:
                                                          Radius.circular(15),
                                                          topRight: Radius
                                                              .circular(15),
                                                          bottomLeft: Radius
                                                              .circular(0),
                                                          bottomRight: Radius
                                                              .circular(15))),
                                                  child: Text(
                                                      currentMessage
                                                          .message
                                                          .toString()),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                    LoadImage(),
                                    typingList!.length == 2
                                        ? Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, top: 15, bottom: 15),
                                        child: Text("Typing..."),
                                      ),
                                    )
                                        : typingList.length == 1 &&
                                        typingList.contains(FirebaseAuth
                                            .instance
                                            .currentUser!
                                            .uid) ==
                                            false
                                        ? Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            left: 5,
                                            top: 15,
                                            bottom: 15),
                                        child: Text("Typing..."),
                                      ),
                                    )
                                        : SizedBox.shrink(),
                                  ],
                                ),
                              ),
                            );
                          })),
                  Container(
                    height: 77,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          // GestureDetector(
                          //   onTap: () async {
                          //     await Get.find<MessageController>()
                          //         .messagingImage(widget.chatRoomModel);
                          //   },
                          //   child: Container(
                          //     height: 45,
                          //       width: 45,
                          //       decoration: BoxDecoration(
                          //         border:Border.all(color: Colors.grey.shade200),
                          //         borderRadius: BorderRadius.circular(10)
                          //       ),
                          //       child: Icon(Icons.photo,color: textcolor,)),
                          // ),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                  Border.all(color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  GetBuilder<MessageController>(
                                      init: MessageController(),
                                      builder: (controller) =>
                                          Expanded(
                                              child: kChatTextField(
                                                  onChanged: (value) async {
                                                    if (value.isNotEmpty) {
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                          "chatrooms")
                                                          .doc(
                                                          widget.chatRoomModel
                                                              .chatRoomId)
                                                          .update({
                                                        "typing":
                                                        FieldValue.arrayUnion([
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid
                                                        ]),
                                                      });
                                                    } else {
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                          "chatrooms")
                                                          .doc(
                                                          widget.chatRoomModel
                                                              .chatRoomId)
                                                          .update({
                                                        "typing":
                                                        FieldValue.arrayRemove([
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid
                                                        ]),
                                                      });
                                                    }
                                                  },
                                                  maxlines: null,
                                                  fillColor: Colors.white,
                                                  isFilled: true,
                                                  isPassword: false,
                                                  inputType: TextInputType.text,
                                                  hintText: 'Your message',
                                                  controller: messageController
                                                      .messagetextfieldController,
                                                  borderColor:
                                                  Colors.grey.shade100))),
                                  TextButton(
                                      onPressed: () async {
                                        // context.read<MessageController>().sendMessage(
                                        //     context, widget.chatRoomModel.chatRoomId);
                                        // if(filter.hasProfanity( messageController
                                        //     .messagetextfieldController.text)==false) {
                                        await sendMessage(context);
                                        messageController.newMessageScroll
                                            .animateTo(
                                            messageController
                                                .newMessageScroll
                                                .position
                                                .maxScrollExtent,
                                            duration:
                                            Duration(milliseconds: 500),
                                            curve: Curves.linear);
                                        // }
                                        // else{
                                        //   showDialog(
                                        //       context: context,
                                        //       builder: (builder) {
                                        //         return AlertDialog(
                                        //           shape: Border.all(
                                        //             color: Colors.red,
                                        //           ),
                                        //           title: const Text('Alert'),
                                        //           content: Text("Don't use abusive langauge"),
                                        //           icon: Image.asset(
                                        //             "assets/appicon.png",
                                        //             height: 40,
                                        //             width: 40,
                                        //           ),
                                        //         );
                                        //       });
                                        //   messageController
                                        //       .messagetextfieldController.clear();
                                        // }
                                      },
                                      child: Text(
                                        'Send',
                                        style: TextStyle(
                                            color: butoncolor,
                                            fontWeight: FontWeight.w600),
                                      )),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else if (typingSnap.hasError) {} else {}
          }
          return SizedBox.shrink();
        });
  }

  sendMessage(BuildContext context) async {
    String message =
    Get
        .find<MessageController>()
        .messagetextfieldController
        .text
        .trim();
    Get
        .find<MessageController>()
        .messagetextfieldController
        .clear();
    final filter = ProfanityFilter();
    if (message == '') {} else {
      FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
      User? user = _firebaseAuth.currentUser;

      MessageModel messagesModel = MessageModel(
        sender: user!.uid,
        message: filter.censor(message).toString(),
        createTime: DateTime.now(),
        messageId: Uuid().v1(),
      );

      await FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(widget.chatRoomModel.chatRoomId)
          .collection('messages')
          .doc(messagesModel.messageId)
          .set(messagesModel.toMap());

      widget.chatRoomModel.lastMessage = filter.censor(message).toString();
      widget.chatRoomModel.lastMessageTime = DateTime.now();
      widget.chatRoomModel.isReadSender = true;
      widget.chatRoomModel.isReadReceiver = false;
      widget.chatRoomModel.lastMesgUserId = user.uid.toString();

      await FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(widget.chatRoomModel.chatRoomId)
          .set(widget.chatRoomModel.toMap());
    }
  }
}

showAlertDialog(BuildContext context,
    {required unmatchTap, required profileTap, required blockTap}) {
  AlertDialog alert = AlertDialog(
    insetPadding: EdgeInsets.symmetric(horizontal: 50),
    contentPadding: EdgeInsets.zero,
    content: Container(
      height: 200,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45,
            color: textcolor,
            child: Stack(
              children: [
                Center(
                  child: Text(
                    "Profile Actions",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 10,
                  bottom: 5,
                  child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 20,
                      )),
                )
              ],
            ),
          ),
          Container(
            height: 120,
            padding: EdgeInsets.symmetric(horizontal: 20,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppComponents().sizedBox20,
                GestureDetector(
                  onTap: unmatchTap,
                  child: Text(
                    "Unmatch",
                    style: k16styleblack,
                  ),
                ),
                AppComponents().sizedBox20,
                GestureDetector(
                  onTap: profileTap,
                  child: Text(
                    "Profile details",
                    style: k16styleblack,
                  ),
                ),
                AppComponents().sizedBox20,
                GestureDetector(
                  onTap: blockTap,
                  child: Text(
                    "Block",
                    style: k16styleblack,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
