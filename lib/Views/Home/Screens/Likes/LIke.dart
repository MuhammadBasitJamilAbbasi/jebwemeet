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
              Center(child: Text("Explore",style: k25styleblack,)),
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
                                  labelColor: textcolor,
                                  indicatorColor: textcolor,

                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicatorWeight: 2,
                                  labelPadding: EdgeInsets.symmetric(horizontal: 20),
                                  isScrollable: true,
                                  labelStyle: TextStyle(
                                      fontSize: 15,
                                      color: textcolor,
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
                                  Text('Liked'),
                                  Text('Passed'),
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
                                                    Get.to(()=> PersonMessageView(
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
                                                        chatRoom!));
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
                                                                  overflow: TextOverflow.ellipsis,
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
                                                                  overflow: TextOverflow.ellipsis,
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
                                                            overflow: TextOverflow.ellipsis,
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
                                          snapshot.data == null || snapshot.data!.size==0) {
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
                                                                        overflow: TextOverflow.ellipsis,
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
                                                                  top: 2,
                                                                  right: 1,
                                                                  child: GestureDetector(
                                                                    onTap: (){
                                                                      controller.removefavourite(opponent_user:snapshot.data!.docs[index]["uid"]);
                                                                    },
                                                                    child: Container(
                                                                        height: 35,
                                                                        width: 35,
                                                                        alignment: Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                            color: Colors.white.withOpacity(0.5),
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
                                                                          height: 20,
                                                                          width: 20,
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
                                  //Liked
                                  StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(user.uid).collection("visits")
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (!snapshot.hasData ||
                                          snapshot.hasError ||
                                          snapshot.data == null) {
                                        return Container(
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
                                              Text('No Liked yet',
                                                  style: k20styleblack),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 30),
                                                child: Text(
                                                  'When you liked profile they’ll show up here',
                                                  style: k14styleblack,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      print(snapshot.data!.docs.length);
                                      List<QueryDocumentSnapshot> youlikedList = [];
                                      snapshot.data!.docs.forEach((element) {
                                        if(element["visitType"]=="like"){
                                          youlikedList.add(element);
                                        }
                                      });
                                      return youlikedList.length>0?  Column(
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
                                                  youlikedList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return InkWell(
                                                        onTap: () async {
                                                          Get.to(()=> ProfileWithID(id: youlikedList[index]["uid"]));
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
                                                                    youlikedList[index]["image"]
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
                                                                        youlikedList[index]["name"]
                                                                            .toString(),
                                                                        overflow: TextOverflow.ellipsis,
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
                                                                  top: 2,
                                                                  right: 1,
                                                                  child: GestureDetector(
                                                                    onTap: (){
                                                                      controller.removeLiked(opponent_user:youlikedList[index]["uid"]);
                                                                    },
                                                                    child: Container(
                                                                        height: 35,
                                                                        width: 35,
                                                                        alignment: Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                            color: Colors.white.withOpacity(0.5),
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
                                                                          height: 20,
                                                                          width: 20,
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
                                      ) :  Container(
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
                                            Text('No Liked yet',
                                                style: k20styleblack),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 30),
                                              child: Text(
                                                'When you liked profile they’ll show up here',
                                                style: k14styleblack,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  //Ignor
                                  StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(user.uid).collection("visits")
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (!snapshot.hasData ||
                                          snapshot.hasError ||
                                          snapshot.data == null) {
                                        return Container(
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
                                              Text('No Liked yet',
                                                  style: k20styleblack),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 30),
                                                child: Text(
                                                  'When you passed profile they’ll show up here',
                                                  style: k14styleblack,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      print(snapshot.data!.docs.length);
                                      List<QueryDocumentSnapshot> ignorList = [];
                                      snapshot.data!.docs.forEach((element) {
                                        if(element["visitType"]=="passed"){
                                          ignorList.add(element);
                                        }
                                      });
                                      return ignorList.length>0 ? Column(
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
                                                  ignorList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return InkWell(
                                                        onTap: () async {
                                                          Get.to(()=> ProfileWithID(id: ignorList[index]["uid"]));
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
                                                                    ignorList[index]["image"]
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
                                                                        ignorList[index]["name"]
                                                                            .toString(),
                                                                        overflow: TextOverflow.ellipsis,
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
                                                                  top: 2,
                                                                  right: 1,
                                                                  child: GestureDetector(
                                                                    onTap: (){
                                                                      controller.removeLiked(opponent_user:ignorList[index]["uid"]);
                                                                    },
                                                                    child: Container(
                                                                        height: 35,
                                                                        width: 35,
                                                                        alignment: Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                            color: Colors.white.withOpacity(0.5),
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
                                                                          "assets/dislikenew.png",
                                                                          height: 15,
                                                                          width: 15,
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
                                      ) :  Container(
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
                                            Text('No Passed yet',
                                                style: k20styleblack),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 30),
                                              child: Text(
                                                'When you passed profile they’ll show up here',
                                                style: k14styleblack,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
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
