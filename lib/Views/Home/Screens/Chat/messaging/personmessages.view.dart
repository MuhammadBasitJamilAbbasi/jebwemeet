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
      automaticallyImplyLeading: true,
      iconTheme: IconThemeData(color: Colors.black),
      title: Row(
        children: [
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
          Text(
            widget.name,
            style: k14styleblack,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

//body
  Widget getBody(
    MessageController messageController,
    BuildContext context,
  ) {
    UserModel? userModel;

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
              return Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height,
                  child: ContainedTabBarView(
                    tabBarProperties: TabBarProperties(
                      unselectedLabelColor: Colors.grey,
                      labelColor: Colors.black,
                      indicatorColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 2,
                      labelStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      unselectedLabelStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                      height: 50,
                    ),
                    tabs: [
                      Text('Chat'),
                      Text('Profile'),
                    ],
                    views: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                              child: StreamBuilder<QuerySnapshot?>(
                                  stream: Get.find<MessageController>()
                                      .listeningForMessages(
                                          widget.chatRoomModel),
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
                                          padding:
                                              const EdgeInsets.only(top: 68.0),
                                          child: Text(
                                            "No Messages Yet...",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                        ),
                                      );
                                    }
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 20),
                                      child: SingleChildScrollView(
                                        key: PageStorageKey<String>(
                                            'messagesScrollKey'),
                                        controller:
                                            messageController.newMessageScroll,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            listenForChat == null
                                                ? SizedBox()
                                                : ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    padding: EdgeInsets.zero,
                                                    itemCount: listenForChat
                                                        .data!.docs.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      MessageModel
                                                          currentMessage =
                                                          MessageModel.fromMap(
                                                              listenForChat
                                                                      .data!
                                                                      .docs[index]
                                                                      .data()
                                                                  as Map<String,
                                                                      dynamic>);
                                                      return currentMessage
                                                                  .sender !=
                                                              widget.uid
                                                          ? Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                vertical: 10,
                                                              ),
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .bottomRight,
                                                                child: IntrinsicWidth(
                                                                    child: Container(
                                                                        alignment: Alignment.center,
                                                                        padding: Uri.parse(currentMessage.message.toString()).isAbsolute ? EdgeInsets.zero : EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                                                        decoration: BoxDecoration(color: Uri.parse(currentMessage.message.toString()).isAbsolute ? Colors.transparent : butoncolor, borderRadius: Uri.parse(currentMessage.message.toString()).isAbsolute ? BorderRadius.circular(10) : BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.circular(15), bottomRight: Radius.circular(0))),
                                                                        child: Text(
                                                                          currentMessage
                                                                              .message
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: 12,
                                                                              color: Colors.white),
                                                                        )
                                                                        //bodyStyle4KPrimary,
                                                                        )),
                                                              ),
                                                            )
                                                          : Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                vertical: 5,
                                                              ),
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .bottomLeft,
                                                                child:
                                                                    IntrinsicWidth(
                                                                  child:
                                                                      Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            20,
                                                                        vertical:
                                                                            10),
                                                                    decoration: BoxDecoration(
                                                                        color: Uri.parse(currentMessage.message.toString()).isAbsolute
                                                                            ? Colors
                                                                                .transparent
                                                                            : Colors
                                                                                .grey.shade200,
                                                                        borderRadius: Uri.parse(currentMessage.message.toString()).isAbsolute
                                                                            ? BorderRadius.circular(
                                                                                4)
                                                                            : BorderRadius.only(
                                                                                topLeft: Radius.circular(15),
                                                                                topRight: Radius.circular(15),
                                                                                bottomLeft: Radius.circular(0),
                                                                                bottomRight: Radius.circular(15))),
                                                                    child: Text(currentMessage
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
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5,
                                                              top: 15,
                                                              bottom: 15),
                                                      child: Text("Typing..."),
                                                    ),
                                                  )
                                                : typingList.length == 1 &&
                                                        typingList.contains(
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid) ==
                                                            false
                                                    ? Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5,
                                                                  top: 15,
                                                                  bottom: 15),
                                                          child:
                                                              Text("Typing..."),
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
                                          color: Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Row(
                                        children: [
                                          GetBuilder<MessageController>(
                                              init: MessageController(),
                                              builder: (controller) => Expanded(
                                                  child: kChatTextField(
                                                      onChanged: (value) async {
                                                        if (value.isNotEmpty) {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "chatrooms")
                                                              .doc(widget
                                                                  .chatRoomModel
                                                                  .chatRoomId)
                                                              .update({
                                                            "typing": FieldValue
                                                                .arrayUnion([
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid
                                                            ]),
                                                          });
                                                        } else {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "chatrooms")
                                                              .doc(widget
                                                                  .chatRoomModel
                                                                  .chatRoomId)
                                                              .update({
                                                            "typing": FieldValue
                                                                .arrayRemove([
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid
                                                            ]),
                                                          });
                                                        }
                                                      },
                                                      maxlines: null,
                                                      fillColor:
                                                          Colors.grey.shade100,
                                                      isFilled: true,
                                                      isPassword: false,
                                                      inputType:
                                                          TextInputType.text,
                                                      hintText:
                                                          'Type your message',
                                                      controller: messageController
                                                          .messagetextfieldController,
                                                      borderColor: Colors
                                                          .grey.shade100))),
                                          TextButton(
                                              onPressed: () async {
                                                // context.read<MessageController>().sendMessage(
                                                //     context, widget.chatRoomModel.chatRoomId);
                                                await sendMessage(context);
                                                messageController
                                                    .newMessageScroll
                                                    .animateTo(
                                                        messageController
                                                            .newMessageScroll
                                                            .position
                                                            .maxScrollExtent,
                                                        duration: Duration(
                                                            milliseconds: 500),
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
                                                    fontWeight:
                                                        FontWeight.w600),
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
                      ),
                      StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .doc(widget.uid)
                            .snapshots(),
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
                                padding: const EdgeInsets.only(top: 68.0),
                                child: Text(
                                  "No data Yet...",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                            );
                          }
                          userModel = UserModel.fromMap(
                              snapshot.data!.data() as Map<String, dynamic>);
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  AppComponents().sizedBox30,
                                  // Container(
                                  //   height: 300,
                                  //   child: Stack(children: [
                                  //     CarouselSlider(
                                  //       options: CarouselOptions(
                                  //         autoPlay: true,
                                  //         viewportFraction: 1,
                                  //         aspectRatio: 1.5,
                                  //         enlargeCenterPage: true,
                                  //         onPageChanged: (index, reason) {},
                                  //       ),
                                  //       items: userModel!.imagesList!
                                  //           .map(
                                  //             (item) => Padding(
                                  //               padding:
                                  //                   const EdgeInsets.only(top: 8),
                                  //               child: ClipRRect(
                                  //                 borderRadius: BorderRadius.all(
                                  //                   Radius.circular(10.0),
                                  //                 ),
                                  //                 child: GestureDetector(
                                  //                   onTap: () {},
                                  //                   child: Container(
                                  //                     height: 300,
                                  //                     width:
                                  //                         MediaQuery.of(context)
                                  //                             .size
                                  //                             .width,
                                  //                     decoration: BoxDecoration(
                                  //                         borderRadius:
                                  //                             BorderRadius
                                  //                                 .circular(15.0),
                                  //                         gradient:
                                  //                             LinearGradient(
                                  //                           begin:
                                  //                               Alignment.topLeft,
                                  //                           end: Alignment
                                  //                               .bottomRight,
                                  //                           colors: [
                                  //                             butoncolor
                                  //                                 .withOpacity(
                                  //                                     0.3),
                                  //                             butoncolor
                                  //                                 .withOpacity(
                                  //                                     0.1),
                                  //                           ],
                                  //                         )),
                                  //                     child: Image.network(
                                  //                       item,
                                  //                       fit: BoxFit.fill,
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           )
                                  //           .toList(),
                                  //     ),
                                  //     Positioned(
                                  //       top: 120,
                                  //       left: 20,
                                  //       right: 20,
                                  //       child: Center(
                                  //         child: AvatarGlow(
                                  //           glowColor:
                                  //               Color.fromARGB(255, 15, 233, 106),
                                  //           endRadius: 90.0,
                                  //           duration:
                                  //               Duration(milliseconds: 2000),
                                  //           repeat: true,
                                  //           showTwoGlows: true,
                                  //           repeatPauseDuration:
                                  //               Duration(milliseconds: 100),
                                  //           child: Center(
                                  //             child: SizedBox(
                                  //               width: 130,
                                  //               height: 130,
                                  //               child: CircleAvatar(
                                  //                 foregroundImage: NetworkImage(
                                  //                     userModel!.imageUrl
                                  //                         .toString()),
                                  //                 radius: 10,
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     )
                                  //   ]),
                                  // ),
                                  userModel!.about.toString() == "null"
                                      ? SizedBox.shrink()
                                      : Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "About",
                                            style: k18styleblack,
                                          ),
                                        ),
                                  userModel!.about.toString() != "null"
                                      ? Detail_Profile_Tile(
                                          value: userModel!.about.toString(),
                                          ontap: () {},
                                        )
                                      : SizedBox.shrink(),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Name",
                                      style: k18styleblack,
                                    ),
                                  ),
                                  Detail_Profile_Tile(
                                    value: userModel!.name.toString(),
                                    ontap: () {},
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Occupation",
                                      style: k18styleblack,
                                    ),
                                  ),
                                  Detail_Profile_Tile(
                                    value: userModel!.work.toString(),
                                    ontap: () {},
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Job Title",
                                      style: k18styleblack,
                                    ),
                                  ),
                                  Detail_Profile_Tile(
                                    value: userModel!.job_title.toString(),
                                    ontap: () {},
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Age",
                                      style: k18styleblack,
                                    ),
                                  ),
                                  Detail_Profile_Tile(
                                    value: userModel!.age.toString(),
                                    ontap: () {},
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Martial Status",
                                      style: k18styleblack,
                                    ),
                                  ),
                                  Detail_Profile_Tile(
                                    value: userModel!.martial_status.toString(),
                                    ontap: () {},
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Address",
                                      style: k18styleblack,
                                    ),
                                  ),
                                  Detail_Profile_Tile(
                                    value: userModel!.address.toString(),
                                    ontap: () {},
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Height",
                                      style: k18styleblack,
                                    ),
                                  ),
                                  Detail_Profile_Tile(
                                    value: userModel!.height.toString(),
                                    ontap: () {},
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Education",
                                      style: k18styleblack,
                                    ),
                                  ),
                                  Detail_Profile_Tile(
                                    value: userModel!.education.toString(),
                                    ontap: () {},
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                    onChange: (index) {},
                  ));
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
