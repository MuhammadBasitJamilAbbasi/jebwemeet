import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Home/Controllers/Notifications_controller.dart';
import 'package:jabwemeet/Views/Home/Screens/Tabbar.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  Stream<QuerySnapshot>? snapShotData;
  List docId = [];
  var getFriendRequests;

  @override
  void initState() {
    // getFriendRequests = getRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("Inside Notification View:");
    final notificationController = Get.find<NotificationController>();
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: kCustomBottomNavBar(
          index: 1,
        ),
        resizeToAvoidBottomInset: false,
        body: getBody(notificationController),
      ),
    );
  }

//body
  Widget getBody(NotificationController notificationController) {
    FirebaseAuth _firebaseInstance = FirebaseAuth.instance;

    User? user = _firebaseInstance.currentUser;

    return user != null
        ? GetBuilder<NotificationController>(
            init: NotificationController(),
            builder: (notificationController) {
              return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("likes")
                      .snapshots(),
                  builder: (context, dataSnapshot) {
                    if (dataSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator.adaptive());
                    } else if (dataSnapshot.connectionState ==
                            ConnectionState.active ||
                        dataSnapshot.connectionState ==
                            ConnectionState.active) {
                      if (dataSnapshot.hasError) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('An error occurred'),
                              Text(dataSnapshot.error.toString()),
                            ],
                          ),
                        );
                      }
                      final List storeDocs = [];
                      dataSnapshot.data!.docs.map((DocumentSnapshot document) {
                        Map a = document.data() as Map<String, dynamic>;
                        storeDocs.add(a);
                        a['id'] = document.id;
                      }).toList();
                      return docId.length < 1
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Text('No Likes yet', style: k20styleblack),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: Text(
                                    'When you get notification they’ll show up here',
                                    style: k14styleblack,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: storeDocs.length,
                              itemBuilder: (context, index) {
                                // Timestamp timestamp =
                                //     dataSnapshot.data?.docs[index]['createdOn'];
                                // DateTime dateTime = timestamp.toDate();
                                // String time = DateFormat.jms().format(dateTime);

                                return Column(
                                  children: [
                                    Text(storeDocs[index]['isSender'])
                                    /* OtherNotificationWidget(
                                  notificationId: storeDocs[index]['id'],
                                  receiverUserId: storeDocs[index]
                                      ["receiverUserID"],
                                  profileImg: storeDocs[index]['userImage'],
                                  color: (storeDocs[index]['type'] == 'like')
                                      ? Colors.red
                                      : Colors.pinkAccent,
                                  text: storeDocs[index]['sender_name'],
                                  // postedTime: "Time",
                                  // '${dateTime.isAfter(DateTime.now().subtract(Duration(days: 1))) ? 'today' : DateFormat.yMd().format(dateTime)} at $time',
                                  pic: ((storeDocs[index]['type'] == 'like')
                                      ? FaIcon(
                                          FontAwesomeIcons.solidHeart,
                                          color: Colors.white,
                                        )
                                      : Icon(
                                          FontAwesomeIcons.solidHeart,
                                          color: Colors.white,
                                        )),
                                  message: storeDocs[index]['message'],
                                ),*/
                                    ,
                                    Divider(
                                      color: kBaseGrey,
                                      thickness: 1,
                                    ),
                                  ],
                                );
                              });
                    }
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dataSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          // Timestamp timestamp =
                          //     dataSnapshot.data?.docs[index]['createdOn'];
                          // DateTime dateTime = timestamp.toDate();
                          // String time = DateFormat.jms().format(dateTime);

                          return Column(
                            children: [
                              Text(dataSnapshot.data!.docs[index]['isSender'])
                              /* OtherNotificationWidget(
                                  notificationId: storeDocs[index]['id'],
                                  receiverUserId: storeDocs[index]
                                      ["receiverUserID"],
                                  profileImg: storeDocs[index]['userImage'],
                                  color: (storeDocs[index]['type'] == 'like')
                                      ? Colors.red
                                      : Colors.pinkAccent,
                                  text: storeDocs[index]['sender_name'],
                                  // postedTime: "Time",
                                  // '${dateTime.isAfter(DateTime.now().subtract(Duration(days: 1))) ? 'today' : DateFormat.yMd().format(dateTime)} at $time',
                                  pic: ((storeDocs[index]['type'] == 'like')
                                      ? FaIcon(
                                          FontAwesomeIcons.solidHeart,
                                          color: Colors.white,
                                        )
                                      : Icon(
                                          FontAwesomeIcons.solidHeart,
                                          color: Colors.white,
                                        )),
                                  message: storeDocs[index]['message'],
                                ),*/
                              ,
                              Divider(
                                color: kBaseGrey,
                                thickness: 1,
                              ),
                            ],
                          );
                        });
                  });
            })
        : Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Text('No Notifications yet', style: k20styleblack),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'When you get notification they’ll show up here',
                  style: k14styleblack,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ); //  If teh User is not Signed In
  }
}
