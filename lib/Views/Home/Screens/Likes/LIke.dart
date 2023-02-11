import 'dart:developer';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Models/chatroom.model.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Home/Controllers/home_page_controller.dart';
import 'package:jabwemeet/Views/Home/Screens/Chat/messaging/personmessages.view.dart';
import 'package:jabwemeet/Views/Home/Screens/Home/Home_Components.dart';
import 'package:jabwemeet/Views/Home/Screens/Profile/profilewithid.dart';
import 'package:jabwemeet/Views/Home/Screens/Tabbar.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
    return Scaffold(
        appBar: PreferredSize(preferredSize: Size(MediaQuery.of(context).size.width, 120),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              AppComponents().sizedBox50,
              Text("Matches",style: k25styleblack,),
              SizedBox(height: 5,),
              Text("This is a list of people who have liked you and your matches.",style: k14styleblack,),
          AppComponents().sizedBox10,
            Divider(),
          ],
        ),
            )),
        bottomNavigationBar: kCustomBottomNavBar(
          index: 1,
        ),
        body: user != null
            ? SafeArea(
              child: GetBuilder<Home_page_controller>(
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
                                user.uid.toString() || element['participants'][id1] == true &&
                                element['participants'][id2] == true &&
                                element['participants'][user.uid] == true ) {
                              likeslist.add(element);
                            }
                            if (element['participants'][id1] == true &&
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
                          print("Matches List=" + matcheslist.length.toString());
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
                                  height: 30,
                                ),
                                tabs: [
                                  Text('Matches'),
                                  Text('Liked you'),
                                  Text('Favourites'),
                                ],
                                views: [
                                  matcheslist.length > 0
                                      ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AppComponents().sizedBox20,
                                      Expanded(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 15,vertical: 5),
                                          child: GridView.builder(
                                              gridDelegate:
                                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                                  maxCrossAxisExtent:
                                                  300,
                                                  childAspectRatio:
                                                  2 / 3 ,
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
                                                    ChatRoomModel?
                                                    chatRoom =
                                                    await controller
                                                        .getchatRoom(
                                                        controller.userModel.uid.toString()==matcheslist[index]["isSender"]
                                                            .toString() ?
                                                        matcheslist[index]["isReceiver"]
                                                            .toString() : matcheslist[index]["isSender"]
                                                            .toString(),
                                                        context);
                                                    log("2 chat room not null");
                                                    showMaterialModalBottomSheet(
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
                                                                child:PersonMessageView(
                                                                    name:
                                                                    controller.userModel.name.toString()==matcheslist[index]["isReceiverName"]
                                                                        .toString() ?
                                                                    matcheslist[index]["isSenderName"]
                                                                        .toString() : matcheslist[index]["isReceiverName"]
                                                                        .toString(),
                                                                    profilePicture:
                                                                    controller.userModel.imageUrl.toString()==matcheslist[index]["isSenderImage"]
                                                                        .toString() ?
                                                                    matcheslist[index]["isReceiverImage"]
                                                                        .toString() : matcheslist[index]["isSenderImage"]
                                                                        .toString(),
                                                                    uid: controller.userModel.uid.toString()==matcheslist[index]["isSender"]
                                                                        .toString() ?
                                                                    matcheslist[index]["isReceiver"]
                                                                        .toString() : matcheslist[index]["isSender"]
                                                                        .toString(),
                                                                    chatRoomModel:
                                                                    chatRoom!),
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
                                                                    name:
                                                                    controller.userModel.name.toString()==matcheslist[index]["isReceiverName"]
                                                                        .toString() ?
                                                                    matcheslist[index]["isSenderName"]
                                                                        .toString() : matcheslist[index]["isReceiverName"]
                                                                        .toString(),
                                                                    profilePicture:
                                                                    controller.userModel.imageUrl.toString()==matcheslist[index]["isSenderImage"]
                                                                        .toString() ?
                                                                    matcheslist[index]["isReceiverImage"]
                                                                        .toString() : matcheslist[index]["isSenderImage"]
                                                                        .toString(),
                                                                    uid: controller.userModel.uid.toString()==matcheslist[index]["isSender"]
                                                                        .toString() ?
                                                                    matcheslist[index]["isReceiver"]
                                                                        .toString() : matcheslist[index]["isSender"]
                                                                        .toString(),
                                                                    chatRoomModel:
                                                                    chatRoom),
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
                                                    );
                                                  },
                                                  child:
                                                  Card(
                                                    clipBehavior: Clip.antiAlias,
                                                    elevation: 4.0,
                                                    margin: EdgeInsets.zero,
                                                    shape: defaultCardBorder(),
                                                    child: Container(
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                        /// User profile image
                                                        image: DecorationImage(
                                                          //   colorFilter: controller.Listing_List[properties.index].imageBlur??false? ColorFilter.mode(Colors.black, BlendMode.xor) : null,
                                                          /// Show VIP icon if user is not vip member
                                                          image: NetworkImage(
                                                            controller.userModel.imageUrl.toString()==matcheslist[index]["isSenderImage"]
                                                                .toString() ?
                                                              matcheslist[index]["isReceiverImage"]
                                                                  .toString() : matcheslist[index]["isSenderImage"]
                                                                .toString() ),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      child: Stack(
                                                        children: [
                                                          Positioned(
                                                            bottom: 0,
                                                            left: 0,
                                                            right: 0,
                                                            child: BlurryContainer(
                                                              blur: 8,
                                                              height: 40,
                                                              elevation: 0,
                                                              borderRadius: BorderRadius.circular(0),
                                                              color: Colors
                                                                  .black.withOpacity(0.5),
                                                              child: Padding(
                                                                padding: EdgeInsets.only(left: 10,),
                                                                child:
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
                                                                          .w500,
                                                                      fontSize:
                                                                      16,
                                                                      color:
                                                                      Colors.white),
                                                                )
                                                                    : Text(
                                                                  matcheslist[index]
                                                                  [
                                                                  "isSenderName"]
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .w500,
                                                                      fontSize:
                                                                      16,
                                                                      color:
                                                                      Colors.white),
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                  )
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
                                  likeslist.length > 0
                                      ? ListView.builder(
                                        physics:
                                            NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: likeslist.length,
                                        itemBuilder: (context, index) {
                                          print(likeslist.length);
                                          return Column(
                                            children: [
                                              GestureDetector(
                                                onTap: (){
                                                  Get.to(()=> ProfileWithID(
                                                    fromNotifiPage: true,
                                                    id: controller.userModel.uid.toString()==likeslist[index]["isSender"]
                                                      .toString() ?
                                                  likeslist[index]["isReceiver"]
                                                      .toString() : likeslist[index]["isSender"]
                                                      .toString(),));
                                                },
                                                child: Container(
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
                                                              controller.userModel.imageUrl.toString()==likeslist[index]["isSenderImage"]
                                                                  .toString() ?
                                                              likeslist[index]["isReceiverImage"]
                                                                  .toString() : likeslist[index]["isSenderImage"]
                                                                  .toString()),
                                                    ),
                                                    title: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            controller.userModel.name.toString()==likeslist[index]["isSenderName"]
                                                                .toString() ?
                                                            likeslist[index]["isReceiverName"]
                                                                .toString() : likeslist[index]["isSenderName"]
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
                                                      "assets/heartnew.png",
                                                      height: 25,
                                                      width: 25,
                                                      color: textcolor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
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
                                  StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(user.uid).collection("favourites")
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (!snapshot.hasData ||
                                          snapshot.hasError ||
                                          snapshot.data == null) {
                                        return     Container(
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
                                              Text('No Favourites Found',
                                                  style: k20styleblack),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 30),
                                                child: Text(
                                                  'When you favourite profile they’ll show up here',
                                                  style: k14styleblack,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      return  Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          AppComponents().sizedBox20,
                                          Expanded(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 15,vertical: 5),
                                              child: GridView.builder(
                                                  gridDelegate:
                                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                                      maxCrossAxisExtent:
                                                      300,
                                                      childAspectRatio:
                                                      2 / 3 ,
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
                                                  snapshot.data!.size,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return InkWell(
                                                        onTap: () async {
                                                          Get.to(()=> ProfileWithID(id: snapshot.data!.docs[index]["uid"]));
                                                        },
                                                        child:
                                                        Card(
                                                          clipBehavior: Clip.antiAlias,
                                                          elevation: 4.0,
                                                          margin: EdgeInsets.zero,
                                                          shape: defaultCardBorder(),
                                                          child: Container(
                                                            alignment: Alignment.center,
                                                            decoration: BoxDecoration(
                                                              /// User profile image
                                                              image: DecorationImage(
                                                                //   colorFilter: controller.Listing_List[properties.index].imageBlur??false? ColorFilter.mode(Colors.black, BlendMode.xor) : null,
                                                                /// Show VIP icon if user is not vip member
                                                                image: NetworkImage(
                                                                    snapshot.data!.docs[index]["image"]
                                                                        .toString() ),
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                            child: Stack(
                                                              children: [
                                                                Positioned(
                                                                  bottom: 0,
                                                                  left: 0,
                                                                  right: 0,
                                                                  child: BlurryContainer(
                                                                    blur: 8,
                                                                    height: 40,
                                                                    elevation: 0,
                                                                    borderRadius: BorderRadius.circular(0),
                                                                    color: Colors
                                                                        .black.withOpacity(0.5),
                                                                    child: Padding(
                                                                      padding: EdgeInsets.only(left: 10,),
                                                                      child:Text(
                                                                      snapshot.data!.docs[index]["name"]
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .w500,
                                                                            fontSize:
                                                                            16,
                                                                            color:
                                                                            Colors.white),
                                                                      ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                Positioned(
                                                                  top: 10,
                                                                  right: 10,
                                                                  child: GestureDetector(
                                                                    onTap: (){
                                                                      controller.removefavourite(opponent_user:snapshot.data!.docs[index]["uid"]);
                                                                    },
                                                                    child: Container(
                                                                        height: 45,
                                                                        width: 45,
                                                                        alignment: Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                            color: Colors.white,
                                                                            boxShadow: [
                                                                              BoxShadow(
                                                                                color: Colors.grey.shade300.withOpacity(0.5),
                                                                                spreadRadius: 3,
                                                                                blurRadius: 12,
                                                                                offset:
                                                                                Offset(0, 10), // changes position of shadow
                                                                              ),
                                                                            ]),
                                                                        child: Image.asset(
                                                                          "assets/heartnew.png",
                                                                          height: 24,
                                                                          width: 24,
                                                                          color: textcolor,
                                                                        )),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
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
                                      );
                                    },
                                  ),

                                ],
                                onChange: (index) {},
                              ));
                        });
                  }),
            )
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
              ));
  }
}
