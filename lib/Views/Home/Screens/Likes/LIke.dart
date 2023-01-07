import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Home/Controllers/home_page_controller.dart';
import 'package:jabwemeet/Views/Home/Screens/Tabbar.dart';

class LikesView extends StatefulWidget {
  const LikesView({Key? key}) : super(key: key);

  @override
  State<LikesView> createState() => _LikesViewState();
}

class _LikesViewState extends State<LikesView> {
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
    log("Inside Likes View:");
    FirebaseAuth _firebaseInstance = FirebaseAuth.instance;

    User? user = _firebaseInstance.currentUser;
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: kCustomBottomNavBar(
            index: 1,
          ),
          resizeToAvoidBottomInset: false,
          body: user != null
              ? GetBuilder<Home_page_controller>(
                  init: Home_page_controller(),
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
                          }

                          print(dataSnapshot.data!.docs.length);
                          List<QueryDocumentSnapshot> matcheslist = [];
                          List<QueryDocumentSnapshot> likeslist = [];
                          dataSnapshot.data!.docs.forEach((element) {
                            var id1;
                            var id2;
                            id1 = element["isReceiver"].toString();
                            id2 = element["isSender"].toString();
                            if (element['participants'][id1] == true &&
                                element['participants'][id1] == true &&
                                element['participants'][user.uid] == true) {
                              matcheslist.add(element);
                            } else if (element["isReceiver"].toString() ==
                                user.uid.toString()) {
                              likeslist.add(element);
                            }
                          });
                          return Column(
                            children: [
                              matcheslist.length > 0
                                  ? Container(
                                      margin: EdgeInsets.only(top: 20),
                                      height: 100,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Your Matches Found",
                                            style: k20styleblack,
                                          ),
                                          Divider(
                                            height: 1,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                                physics:
                                                    BouncingScrollPhysics(),
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: matcheslist.length,
                                                itemBuilder: (context, index) {
                                                  return AvatarWidget(
                                                      imageWidget: CircleAvatar(
                                                        radius: 15,
                                                        backgroundImage:
                                                            CachedNetworkImageProvider(
                                                                matcheslist[index]
                                                                        [
                                                                        "isSenderImage"]
                                                                    .toString()),
                                                        backgroundColor:
                                                            kBaseGrey,
                                                      ),
                                                      backgroundColor:
                                                          Colors.grey.shade200,
                                                      profileImg: matcheslist[
                                                                  index][
                                                              "isReceiverImage"]
                                                          .toString());
                                                }),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Divider(
                                            height: 1,
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox.shrink(),
                              likeslist.length > 0
                                  ? Expanded(
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: likeslist.length,
                                        itemBuilder: (context, index) {
                                          print(likeslist.length);
                                          return Column(
                                            children: [
                                              Container(
                                                height: 80,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color:
                                                        Colors.grey.shade200),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5,
                                                    vertical: 10),
                                                child: ListTile(
                                                  leading: CircleAvatar(
                                                    radius: 25,
                                                    backgroundImage:
                                                        CachedNetworkImageProvider(
                                                            likeslist[index][
                                                                    'isSenderImage']
                                                                .toString()),
                                                  ),
                                                  title: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          likeslist[index][
                                                                  'isSenderName']
                                                              .toString(),
                                                          style:
                                                              k14stylePrimary,
                                                        ),
                                                      ),
                                                      Text(
                                                        " Liked your profile",
                                                        style: k14styleblack,
                                                      ),
                                                    ],
                                                  ),
                                                  trailing: Image.asset(
                                                    "assets/icons/liked.png",
                                                    height: 25,
                                                    width: 25,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    )
                                  : Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              300,
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text('No Likes yet',
                                              style: k20styleblack),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 30),
                                            child: Text(
                                              'When you get Likes they’ll show up here',
                                              style: k14styleblack,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ],
                          );
                        });
                  })
              : Container(
                  height: MediaQuery.of(context).size.height - 300,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                          'When you get Likes they’ll show up here',
                          style: k14styleblack,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }
}
