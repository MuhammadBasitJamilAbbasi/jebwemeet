import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Models/chatroom.model.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Home/Controllers/home_page_controller.dart';
import 'package:jabwemeet/Views/Home/Screens/Chat/messaging/personmessages.view.dart';
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
          appBar: AppBar(
            leading: Text(""),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              "Like",
              style: k16styleblack,
            ),
            elevation: 0,
          ),
          bottomNavigationBar: kCustomBottomNavBar(
            index: 1,
          ),
          resizeToAvoidBottomInset: false,
          body: user != null
              ? GetBuilder<Home_page_controller>(
                  init: Home_page_controller(),
                  builder: (controller) {
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
                          var opponentID;
                          var opponentName;
                          var opponentImage;
                          dataSnapshot.data!.docs.forEach((element) {
                            var id1;
                            var id2;
                            id1 = element["isReceiver"].toString();
                            id2 = element["isSender"].toString();
                            if (element["isReceiver"].toString() ==
                                user.uid.toString()) {
                              likeslist.add(element);
                            } else if (element['participants'][id1] == true &&
                                element['participants'][id2] == true &&
                                element['participants'][user.uid] == true) {
                              matcheslist.add(element);
                              if (id1 == user.uid) {
                                opponentID = id2;
                                opponentName =
                                    element["isSenderName"].toString();
                                opponentImage =
                                    element["isSenderImage"].toString();
                              } else if (id2 == user.uid) {
                                opponentID = id1;
                                opponentName =
                                    element["isReceiverName"].toString();
                                opponentImage =
                                    element["isReceiverImage"].toString();
                              }
                            }
                          });
                          print("Matches List" + matcheslist.length.toString());
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
                                  Text('Liked you'),
                                  Text('Matches'),
                                  Text('Favourited'),
                                ],
                                views: [
                                  likeslist.length > 0
                                      ? Expanded(
                                          child: ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: likeslist.length,
                                            itemBuilder: (context, index) {
                                              print(likeslist.length);
                                              return Column(
                                                children: [
                                                  Container(
                                                    height: 80,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 10),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors
                                                            .grey.shade100),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5,
                                                            vertical: 5),
                                                    child: ListTile(
                                                      leading: CircleAvatar(
                                                        radius: 25,
                                                        backgroundImage:
                                                            CachedNetworkImageProvider(
                                                                likeslist[index]
                                                                        [
                                                                        'isSenderImage']
                                                                    .toString()),
                                                      ),
                                                      title: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              likeslist[index][
                                                                      'isSenderName']
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      "Gilroy-Regular"),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      subtitle: Text(
                                                        "liked your profile",
                                                        style: k14styleblack,
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height -
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
                                  matcheslist.length > 0
                                      ? Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: GridView.builder(
                                                    gridDelegate:
                                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                                            maxCrossAxisExtent:
                                                                300,
                                                            childAspectRatio:
                                                                2 / 3,
                                                            crossAxisSpacing:
                                                                20,
                                                            mainAxisSpacing:
                                                                10),
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount:
                                                        matcheslist.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return InkWell(
                                                        onTap: () async {
                                                          log("1 chat room not null");
                                                          ChatRoomModel?
                                                              chatRoom =
                                                              await controller
                                                                  .getchatRoom(
                                                                      opponentID,
                                                                      context);
                                                          log("2 chat room not null");
                                                          if ((chatRoom!
                                                                  .chatRoomId !=
                                                              null)) {
                                                            log("3 chat room not null");
                                                            Get.to(() => PersonMessageView(
                                                                name:
                                                                    opponentName,
                                                                profilePicture:
                                                                    opponentImage,
                                                                uid: opponentID,
                                                                chatRoomModel:
                                                                    chatRoom));
                                                          }
                                                        },
                                                        child: Container(
                                                          height: 100,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  height: 80,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              10),
                                                                  decoration: BoxDecoration(
                                                                      image: DecorationImage(
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          image: NetworkImage(matcheslist[index]["isReceiverImage"]
                                                                              .toString())),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      color: Colors
                                                                          .grey
                                                                          .shade100),
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              5,
                                                                          vertical:
                                                                              5),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          CircleAvatar(
                                                                            radius:
                                                                                30,
                                                                            backgroundImage:
                                                                                CachedNetworkImageProvider(matcheslist[index]["isSenderImage"].toString()),
                                                                            backgroundColor:
                                                                                kBaseGrey,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              controller.userModel
                                                                          .name ==
                                                                      matcheslist[index]
                                                                              [
                                                                              "isSenderName"]
                                                                          .toString()
                                                                  ? Text(
                                                                      matcheslist[index]
                                                                              [
                                                                              "isReceiverName"]
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              Colors.black),
                                                                    )
                                                                  : Text(
                                                                      matcheslist[index]
                                                                              [
                                                                              "isSenderName"]
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Divider(
                                              height: 1,
                                            ),
                                          ],
                                        )
                                      : Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              300,
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text('No Matches Found',
                                                  style: k20styleblack),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 30),
                                                child: Text(
                                                  'When you get Macthes they’ll show up here',
                                                  style: k14styleblack,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  Center(child: Text("No data Found"))
                                ],
                                onChange: (index) {},
                              ));
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
