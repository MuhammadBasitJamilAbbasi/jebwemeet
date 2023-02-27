import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Models/chatroom.model.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Utils/time.calculation.dart';
import 'package:jabwemeet/Views/Home/Controllers/home_page_controller.dart';
import 'package:jabwemeet/Views/Home/Controllers/message_controller.dart';
import 'package:jabwemeet/Views/Home/Screens/Chat/messaging.widgets/getmessages.list.widget.dart';
import 'package:jabwemeet/Views/Home/Screens/Chat/messaging.widgets/nomessage.widget.dart';
import 'package:jabwemeet/Views/Home/Screens/Chat/messaging/inbox.dart';
import 'package:jabwemeet/Views/Home/Screens/Tabbar.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
      backgroundColor: Colors.white,
      bottomNavigationBar: kCustomBottomNavBar(
        index: 2,
      ),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 100),
        child: Column(
          children: [
            AppComponents().sizedBox50,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text("Your Chats",style: k25styleblack,)),
                  // Container(
                  //   height: 45,
                  //   width: 45,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(15),
                  //       color: Colors.white,
                  //       border: Border.all(color: Colors.grey.shade300)),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(11),
                  //     child: Center(
                  //       child: Image.asset(
                  //         "assets/filter.png",
                  //         height: 45,
                  //         width: 45,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            AppComponents().sizedBox10,
            Divider()
          ],
        ),
      ),
      body: user == null
          ? SafeArea(child: NoMessageWidget()) 
          : SafeArea(
            child: StreamBuilder<QuerySnapshot>(
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
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 30),
                                      child: Divider(),
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
                              var opponentuser;
                              if(participantKeys[0]==Get.find<Home_page_controller>().userModel.uid){
                                 opponentuser=participantKeys[1];
                              }
                              else{
                                 opponentuser=participantKeys[0];
                              }
                              log("<==========Is READ GET===========>");
                              return StreamBuilder<DocumentSnapshot?>(
                                  stream: FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(opponentuser)
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
                                              Get.to(()=> PersonMessageView(
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
                                                age: messageValue
                                                    .data!['age'],
                                                location: messageValue
                                                    .data!['address']
                                                    .toString(),
                                              ));
                                                /*showMaterialModalBottomSheet(
                                                  context: context,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.only(
                                                          topLeft: Radius.circular(50),
                                                          topRight: Radius.circular(50))),
                                                  builder: (context) => Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(context).viewInsets.bottom),
                                                    child: SingleChildScrollView(
                                                      controller: ModalScrollController.of(context),
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            height: MediaQuery.of(context).size.height * 0.85,
                                                            width: MediaQuery.of(context).size.width,
                                                            padding: EdgeInsets.only(top: 50),
                                                            decoration: BoxDecoration(
                                                                color: Colors.black,
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius.circular(50),
                                                                    topRight: Radius.circular(50))),
                                                            child: PersonMessageView(
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
                                                            ),
                                                          ),
                                                          Container(
                                                            height: MediaQuery.of(context).size.height * 0.85,
                                                            width: MediaQuery.of(context).size.width,
                                                            padding: EdgeInsets.only(top: 10),
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                  image: AssetImage("assets/crop.png"),
                                                                  fit: BoxFit.fill,
                                                                ),
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius.circular(50),
                                                                    topRight: Radius.circular(50))),
                                                            child:PersonMessageView(
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
                                                            ),
                                                          ),
                                                          Center(
                                                            child: Image.asset(
                                                              "assets/c.png",
                                                              width: 47,
                                                              height: 25,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );*/
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
          ),
    );
  }
}
