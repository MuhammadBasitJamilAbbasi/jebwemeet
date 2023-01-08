import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Models/chatroom.model.dart';
import 'package:jabwemeet/Models/messaging.model/messages.model.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Home/Controllers/message_controller.dart';
import 'package:jabwemeet/Views/Home/Screens/Chat/messaging.widgets/load.image.dart';
import 'package:uuid/uuid.dart';

final bucket = PageStorageBucket();

class PersonMessageView extends StatefulWidget {
  const PersonMessageView(
      {Key? key,
      required this.name,
      required this.profilePicture,
      required this.uid,
      required this.chatRoomModel})
      : super(key: key);

  final String name;
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

  @override
  Widget build(BuildContext context) {
    final messageController = Get.find<MessageController>();

    return Scaffold(
        // bottomNavigationBar: kCustomBottomNavBar(index: 2,),
        appBar: getAppbar(),
        body: PageStorage(
          bucket: bucket,
          child: getBody(
            messageController,
            context,
          ),
        ));
  }

//Appbar
  PreferredSizeWidget getAppbar() {
    return AppBar(
      shape: Border(
          bottom: BorderSide(
        color: kBaseGrey.withOpacity(0.5),
      )),
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: Colors.black),
      title: Row(
        children: [
          InkWell(
            child:
                Container(height: 40, width: 40, child: Icon(Icons.arrow_back)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            width: 10,
          ),
          widget.profilePicture == ''
              ? CircleAvatar(
                  backgroundColor: kBaseGrey,
                  backgroundImage: AssetImage('Assets/images/user.png'))
              : CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      CachedNetworkImageProvider(widget.profilePicture),
                ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: k14styleblack,
              ),
              Text(
                'Active now',
                style: k12styleblack,
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

//body
  Widget getBody(
    MessageController messageController,
    BuildContext context,
  ) {
    return StreamBuilder<DocumentSnapshot>(
        stream: messageController.getMesssages,
        builder: (context, typingSnap) {
          if (typingSnap.connectionState == ConnectionState.waiting ||
              typingSnap.connectionState == ConnectionState.waiting) {
          } else if (typingSnap.connectionState == ConnectionState.active ||
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
                  Expanded(
                      child: StreamBuilder<QuerySnapshot?>(
                          stream: Get.find<MessageController>()
                              .listeningForMessages(widget.chatRoomModel),
                          builder: (
                            context,
                            listenForChat,
                          ) {
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
                                    style: TextStyle(fontSize: 20, color: Colors.black),
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
                                                                padding: Uri.parse(currentMessage.message.toString())
                                                                        .isAbsolute
                                                                    ? EdgeInsets
                                                                        .zero
                                                                    : EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            20,
                                                                        vertical:
                                                                            10),
                                                                decoration: BoxDecoration(
                                                                    color: Uri.parse(currentMessage.message.toString())
                                                                            .isAbsolute
                                                                        ? Colors
                                                                            .transparent
                                                                        : butoncolor,
                                                                    borderRadius: Uri.parse(currentMessage.message.toString())
                                                                            .isAbsolute
                                                                        ? BorderRadius.circular(
                                                                            10)
                                                                        : BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(15),
                                                                            topRight: Radius.circular(15),
                                                                            bottomLeft: Radius.circular(15),
                                                                            bottomRight: Radius.circular(0))),
                                                                child: Text(
                                                                  currentMessage
                                                                      .message
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .white),
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
                                                                color: Uri.parse(currentMessage.message.toString())
                                                                        .isAbsolute
                                                                    ? Colors
                                                                        .transparent
                                                                    : Colors
                                                                        .grey
                                                                        .shade200,
                                                                borderRadius: Uri.parse(currentMessage
                                                                            .message
                                                                            .toString())
                                                                        .isAbsolute
                                                                    ? BorderRadius
                                                                        .circular(
                                                                            4)
                                                                    : BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        topRight: Radius.circular(15),
                                                                        bottomLeft: Radius.circular(0),
                                                                        bottomRight: Radius.circular(15))),
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
                                                  left: 5,top: 15,bottom: 15),
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
                                                          left: 5,top: 15,bottom: 15),
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
                          GestureDetector(
                            onTap: () async {
                              await Get.find<MessageController>()
                                  .messagingImage(widget.chatRoomModel);
                            },
                            child: Icon(Icons.photo),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.30),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Row(
                                children: [
                                  GetBuilder<MessageController>(
                                      init: MessageController(),
                                      builder: (controller) => Expanded(
                                          child: kChatTextField(
                                              onChanged: (value) async {
                                                if (value.isNotEmpty) {
                                                  FirebaseFirestore.instance
                                                      .collection("chatrooms")
                                                      .doc(widget.chatRoomModel
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
                                                      .collection("chatrooms")
                                                      .doc(widget.chatRoomModel
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
                                              fillColor: Colors.grey.shade200,
                                              isFilled: false,
                                              isPassword: false,
                                              inputType: TextInputType.text,
                                              hintText: 'Type your message',
                                              controller: messageController
                                                  .messagetextfieldController,
                                              borderColor:
                                                  Colors.grey.shade100))),
                                  TextButton(
                                      onPressed: () async {
                                        // context.read<MessageController>().sendMessage(
                                        //     context, widget.chatRoomModel.chatRoomId);
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
                                        // messageController.writtenMessage.trim().isEmpty
                                        //     ? null
                                        //     : messageController.uploadMessage(
                                        //         messageController.writtenMessage, true);
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
            } else if (typingSnap.hasError) {
            } else {}
          }
          return SizedBox.shrink();
        });
  }

  sendMessage(BuildContext context) async {
    String message =
        Get.find<MessageController>().messagetextfieldController.text.trim();
    Get.find<MessageController>().messagetextfieldController.clear();

    if (message == '') {
    } else {
      FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
      User? user = _firebaseAuth.currentUser;

      MessageModel messagesModel = MessageModel(
        sender: user!.uid,
        message: message,
        createTime: DateTime.now(),
        messageId: Uuid().v1(),
      );

      await FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(widget.chatRoomModel.chatRoomId)
          .collection('messages')
          .doc(messagesModel.messageId)
          .set(messagesModel.toMap());

      widget.chatRoomModel.lastMessage = message;
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
