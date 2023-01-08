import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jabwemeet/Models/chatroom.model.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Utils/time.calculation.dart';
import 'package:jabwemeet/Views/Home/Controllers/message_controller.dart';
import 'package:jabwemeet/Views/Home/Screens/Chat/messaging.widgets/getmessages.list.widget.dart';
import 'package:jabwemeet/Views/Home/Screens/Chat/messaging.widgets/nomessage.widget.dart';
import 'package:jabwemeet/Views/Home/Screens/Chat/messaging/personmessages.view.dart';
import 'package:jabwemeet/Views/Home/Screens/Tabbar.dart';

class MessageView extends StatefulWidget {
  MessageView({Key? key}) : super(key: key);

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var getUserchat;
  @override
  void initState() {
    getUserchat = Get.find<MessageController>().getAllChats();
    super.initState();
  }

  final timeCal = TimeCalculation();

  @override
  Widget build(BuildContext context) {
    User? user = _firebaseAuth.currentUser;

    return Scaffold(
      bottomNavigationBar: kCustomBottomNavBar(
        index: 2,
      ),
      appBar: AppBar(
        shape: Border(
            bottom: BorderSide(
          color: kBaseGrey.withOpacity(0.5),
        )),
        automaticallyImplyLeading: false,
        title: Text(
          'Messages',
          style: k18styleblack,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: user == null
          ? NoMessageWidget()
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chatrooms')
                  .where('participants.${user.uid}', isEqualTo: true)
                  .snapshots(),
              //  messageController.getMessages(),
              builder: (context, dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator.adaptive());
                } else if (dataSnapshot.hasError) {
                  return Center(
                    child: Text('An error occured'),
                  );
                } else if (dataSnapshot.hasData) {
                  QuerySnapshot dataQuery = dataSnapshot.data as QuerySnapshot;
                  return dataQuery.docs.length == 0
                      ? NoMessageWidget()
                      : ListView.separated(
                          separatorBuilder: (context, index) => Column(
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Divider(
                                    color: kBaseGrey,
                                  )
                                ],
                              ),
                          primary: false,
                          shrinkWrap: true,
                          itemCount: dataQuery.docs.length,
                          itemBuilder: (context, index) {
                            ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
                                dataQuery.docs[index].data()
                                    as Map<String, dynamic>);

                            Map<String, dynamic> participants =
                                chatRoomModel.participants!;
                            List<String> participantKeys =
                                participants.keys.toList();
                            log("<==========Is READ GET===========>");
                            return StreamBuilder<DocumentSnapshot?>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(participantKeys[1])
                                    .snapshots(),
                                builder: (
                                  context,
                                  messageValue,
                                ) {
                                  if (!messageValue.hasData) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (!messageValue.hasData ||
                                      messageValue.hasError ||
                                      messageValue.data == null) {
                                    return Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 68.0),
                                        child: Text(
                                          "No Message Yet...",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      ),
                                    );
                                  }
                                  DateFormat date = DateFormat.Hm();
                                  return messageValue == null
                                      ? SizedBox()
                                      : GetMessageList(
                                          ontap: () {
                                            Get.find<MessageController>()
                                                .seeMsg(
                                                    dataQuery.docs[index].id,
                                                    messageValue.data!['uid']);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PersonMessageView(
                                                          chatRoomModel:
                                                              chatRoomModel,
                                                          name: messageValue
                                                              .data!['name']
                                                              .toString(),
                                                          profilePicture:
                                                              messageValue
                                                                  .data![
                                                                      'imageUrl']
                                                                  .toString(),
                                                          uid: messageValue
                                                              .data!['uid']
                                                              .toString(),
                                                        )));
                                          },
                                          isRead: chatRoomModel
                                                      .lastMesgUserId ==
                                                  FirebaseAuth
                                                      .instance.currentUser!.uid
                                              ? chatRoomModel.isReadSender!
                                              : chatRoomModel.isReadReceiver!,
                                          message: chatRoomModel.lastMessage
                                              .toString(),
                                          name: messageValue.data!
                                              .get("name")
                                              .toString(),
                                          profileImage:
                                              messageValue.data!['imageUrl'],
                                          time: chatRoomModel.lastMessageTime ==
                                                  null
                                              ? ""
                                              : date
                                                  .format(chatRoomModel
                                                      .lastMessageTime!)
                                                  .toString(),
                                        );
                                });
                          });
                } else {
                  return Text('Something wrong happened');
                }
              }),
    );
  }
}
