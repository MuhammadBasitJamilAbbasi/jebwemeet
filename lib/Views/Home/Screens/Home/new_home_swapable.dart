import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Models/UserModel.dart';
import 'package:jabwemeet/Models/likes_model.dart';
import 'package:jabwemeet/Utils/Dialouge_Boxes.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Utils/locations.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Home/Controllers/home_page_controller.dart';
import 'package:jabwemeet/Views/Home/Screens/Home/Home_Components.dart';
import 'package:jabwemeet/Views/Home/Screens/Home/Profile_details.dart';
import 'package:jabwemeet/Views/Home/Screens/Home/filterScreen.dart';
import 'package:jabwemeet/Views/Home/Screens/Tabbar.dart';
import 'package:like_button/like_button.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:swipable_stack/swipable_stack.dart';

class HomeSwapNew extends StatefulWidget {
  @override
  State<HomeSwapNew> createState() => _HomeSwapNewState();
}

class _HomeSwapNewState extends State<HomeSwapNew> {
  final controllerrrr = Get.find<Home_page_controller>();

  _get_to_previous() {
    stackController.canRewind
        ? stackController.rewind(duration: Duration(milliseconds: 1400))
        : null;
  }

  _update_like() {
    stackController.next(
        duration: Duration(milliseconds: 1400),
        swipeDirection: SwipeDirection.right);
    setState(() {});
  }

  int length = 0;

  _update_favourite() {
    setState(() {});
  }
  _ignore_it() async {
    stackController.next(
        duration: Duration(milliseconds: 1400),
        swipeDirection: SwipeDirection.left);
  }

  SwipableStackController stackController = SwipableStackController();
  PageController? pagecontroller = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (stackController.hasListeners) {
      print("has listem");
      stackController.removeListener(() {});
    }
    setState(() {
      stackController = SwipableStackController()..addListener(() {});
    });
    pagecontroller = PageController(initialPage: 0);
    controllerrrr.getData();
  }
  @override
  Widget build(BuildContext context) {
    Get.find<GetSTorageController>().box.write("loggedin","loggedin").toString();
    final bool isImageBlur = false;
    return Scaffold(
      bottomNavigationBar: kCustomBottomNavBar(
        index: 0,
      ),
      body: WillPopScope(
        onWillPop: () => Dialouge_Box.showExitPopup(context),
        child: SafeArea(
            child: GetBuilder<Home_page_controller>(
                init: Home_page_controller(),
                builder: (controller) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: [
                        buildFilterWidget(context),
                        Positioned(
                          top: 30,
                          left: 0,
                          right: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Discover",
                                style: k25styleblack,
                              ),
                              Text(
                                controller.userModel.address.toString()=="null"? "": controller.userModel.address.toString(),
                                style: k14styleblack,
                              ),
                            ],
                          ),
                        ),
                        controller.homeLoader==true? Center(child: CircularProgressIndicator()):  controller.userList.length > 0
                            ? Positioned(
                                left: 30,
                                right: 30,
                                top: 100,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height - 180,
                                  child: SwipableStack(
                                    detectableSwipeDirections: const {
                                      SwipeDirection.right,
                                      SwipeDirection.left,
                                    },
                                    itemCount: controller.userList.length,
                                    controller: stackController,
                                    stackClipBehaviour: Clip.none,
                                    allowVerticalSwipe: true,
                                    viewFraction: 1,
                                    builder: (context, properties) {
                                      UserModel userModel = UserModel.fromMap(
                                          controller.userList[properties.index]
                                              .data() as Map<String, dynamic>);
                                      double datainMeter =
                                          GetLocation.DistanceInMeters(
                                        double.parse(
                                            userModel.latitude.toString()),
                                        double.parse(
                                            userModel.longitude.toString()),
                                        double.parse(controller.userModel.latitude
                                            .toString()),
                                        double.parse(controller
                                            .userModel.longitude
                                            .toString()),
                                      );
                                      double kilomter = datainMeter / 1000;
                                      print("datainMeter: " +
                                          datainMeter.toString());
                                      print("datainKiloMeter: " +
                                          kilomter.toString());
                                      return Column(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(() => ProfileDetails(
                                                  caste: userModel.caste,
                                                  salary: userModel.income,
                                                  children: userModel.childerns,
                                                  r_practice: userModel.religious_practice,
                                                    religion: userModel.religion,
                                                    latitude: userModel.latitude,
                                                    longitude:
                                                        userModel.longitude,
                                                    blur: userModel.blur,
                                                    interests:
                                                        userModel.hobbies ?? [],
                                                    name: userModel.name.toString() ??
                                                        "",
                                                    martial_status: userModel
                                                            .martial_status
                                                            .toString() ??
                                                        "",
                                                    work:
                                                        userModel.work.toString() ??
                                                            "",
                                                    email: userModel.email
                                                            .toString() ??
                                                        "",
                                                    address: userModel.address
                                                            .toString() ??
                                                        "",
                                                    age: userModel.age.toString() ??
                                                        "",
                                                    model: userModel,
                                                    propertiesindex:
                                                        properties.index,
                                                    height:
                                                        userModel.height.toString() ?? "",
                                                    gender: userModel.gender.toString() ?? "",
                                                    image: userModel.imageUrl.toString() ?? "",
                                                    industry: userModel.industry.toString() ?? "",
                                                    education: userModel.education.toString() ?? "",
                                                    imgeList: userModel.imagesList ?? [],
                                                    about: userModel.about.toString() ?? "",
                                                    phone: userModel.phone_number.toString() ?? "",
                                                    jobtitle: userModel.job_title ?? ""));
                                              },
                                              child: Card(
                                                clipBehavior: Clip.antiAlias,
                                                elevation: 4.0,
                                                margin: EdgeInsets.zero,
                                                shape: defaultCardBorder(),
                                                child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: NetworkImage(
                                                                userModel.imageUrl
                                                                    .toString()),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                           userModel.blur==true?
                                                           Positioned(
                                                             top: 0,
                                                             left: 0,
                                                             right: 0,
                                                             child: BlurryContainer(
                                                               blur: 20,
                                                               height: MediaQuery.of(context).size.height,
                                                               elevation: 0,
                                                               borderRadius:
                                                               BorderRadius
                                                                   .circular(
                                                                   0),
                                                               color: Colors
                                                                   .black
                                                                   .withOpacity(
                                                                   0.5),
                                                               child: Text(""),
                                                             ),
                                                           ): Positioned(top: 0,left: 0,right: 0,child: Text(""),),
                                                            Positioned(
                                                              top: 15,
                                                              left: 15,
                                                              child:
                                                                  BlurryContainer(
                                                                blur: 8,
                                                                height: 34,
                                                                width: 86,
                                                                elevation: 0,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6),
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5),
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              2),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Image.asset(
                                                                        "assets/locnew.png",
                                                                        height:
                                                                            12,
                                                                        width: 12,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      SizedBox(width: 3,),
                                                                      Expanded(
                                                                          child:
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Text(
                                                                        kilomter
                                                                                    .round()
                                                                                    .toString() +
                                                                            " km"
                                                                                    .toString(),
                                                                        style:
                                                                            k12styleWhite,
                                                                      ),
                                                                                ],
                                                                              ))
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              bottom: 0,
                                                              left: 0,
                                                              right: 0,
                                                              child:
                                                                  BlurryContainer(
                                                                blur: 8,
                                                                height: 90,
                                                                elevation: 0,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0),
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Expanded(
                                                                      child: Padding(
                                                                        padding: const EdgeInsets
                                                                                .only(
                                                                            left:
                                                                                10),
                                                                        child: Text.rich(
                                                                            TextSpan(
                                                                                children: [
                                                                              TextSpan(
                                                                                text:
                                                                                    userModel.name.toString(),
                                                                                style:
                                                                                    k18styleWhite,
                                                                              ),
                                                                              if (userModel.age.toString() !=
                                                                                  "null")
                                                                                TextSpan(
                                                                                  text: ", " + userModel.age.toString(),
                                                                                  style: k18styleWhite,
                                                                                )
                                                                            ])),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Expanded(
                                                                      child: Padding(
                                                                        padding: const EdgeInsets
                                                                                .only(
                                                                            left:
                                                                                10),
                                                                        child: Text(
                                                                          userModel
                                                                              .job_title
                                                                              .toString(),
                                                                          overflow: TextOverflow.ellipsis,
                                                                          style:
                                                                              k16styleWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    AppComponents().sizedBox5,
                                                                    Expanded(
                                                                      child: Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                            10),
                                                                        child: Text(
                                                                          userModel
                                                                              .address
                                                                              .toString(),
                                                                          overflow: TextOverflow.ellipsis,
                                                                          style:
                                                                          k16styleWhite,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                              ),
                                            ),
                                          ),
                                          AppComponents().sizedBox20,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  Future.delayed(Duration(
                                                          milliseconds: 800))
                                                      .then((value) => {
                                                            print("asd"),
                                                            _ignore_it(),
                                                            controller.ignorswap(
                                                              visitType: "passed",
                                                                opponent_user:
                                                                    userModel)
                                                          });
                                                  return Future.value();
                                                },
                                                child: Container(
                                                    height: 60,
                                                    width: 60,
                                                    margin: EdgeInsets.only(
                                                        bottom: 20),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .grey.shade300
                                                                .withOpacity(0.6),
                                                            spreadRadius: 3,
                                                            blurRadius: 12,
                                                            offset: Offset(0,
                                                                10), // changes position of shadow
                                                          ),
                                                        ]),
                                                    child: Image.asset(
                                                      "assets/dislikenew.png",
                                                      height: 15,
                                                      width: 15,
                                                    )),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  Future.delayed(Duration(
                                                          milliseconds: 800))
                                                      .then((value) => {
                                                            print("asd"),
                                                            _update_like(),
                                                            controller.likeswap(
                                                                context,
                                                                opponent_user:
                                                                    userModel)
                                                          });
                                                  return Future.value();
                                                },
                                                child: Container(
                                                    height: 80,
                                                    width: 80,
                                                    margin: EdgeInsets.only(
                                                        bottom: 20),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Color(0xFFE94057),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .red.shade200
                                                                .withOpacity(
                                                                    0.25),
                                                            spreadRadius: 5,
                                                            blurRadius: 10,
                                                            offset: Offset(0,
                                                                4), // changes position of shadow
                                                          ),
                                                        ]),
                                                    child: Image.asset(
                                                      "assets/heartnew.png",
                                                      height: 25,
                                                      width: 30,
                                                      fit: BoxFit.fill,
                                                    )),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  Future.delayed(Duration(
                                                          milliseconds: 800))
                                                      .then((value) => {
                                                            print("asd"),
                                                            _update_favourite(),
                                                            controller
                                                                .addtofavourite(
                                                                    opponent_user:
                                                                        userModel)
                                                          });

                                                  return Future.value();
                                                },
                                                child: Container(
                                                    height: 60,
                                                    width: 60,
                                                    margin: EdgeInsets.only(
                                                        bottom: 20),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .grey.shade300
                                                                .withOpacity(0.6),
                                                            spreadRadius: 3,
                                                            blurRadius: 12,
                                                            offset: Offset(0,
                                                                10), // changes position of shadow
                                                          ),
                                                        ]),
                                                    child: Image.asset(
                                                      "assets/starnew.png",
                                                      height: 20,
                                                      width: 20,
                                                    )),
                                              ),
                                            ],
                                          )
                                        ],
                                      );
                                    },
                                    onWillMoveNext: (index, swipeDirection) {
                                      if (length < controller.userList.length) {
                                        setState(() {
                                          length++;
                                        });
                                      }
// Return true for the desired swipe direction.
                                      switch (swipeDirection) {
                                        case SwipeDirection.left:
                                          {
                                            UserModel userModel =
                                                UserModel.fromMap(controller
                                                        .userList[index]
                                                        .data()
                                                    as Map<String, dynamic>);
                                            controller.ignorswap(
                                              visitType: "passed",
                                                opponent_user: userModel,);
                                            return true;
                                          }
                                        case SwipeDirection.right:
                                          {
                                            print("====> right");
                                            UserModel userModel =
                                                UserModel.fromMap(controller
                                                        .userList[index]
                                                        .data()
                                                    as Map<String, dynamic>);
                                            controller.likeswap(context,
                                                opponent_user: userModel,
                                            );
                                            return true;
                                          }
                                        case SwipeDirection.up:
                                          {
                                            print("====> up");

                                            return true;
                                          }
                                        case SwipeDirection.down:
                                          return false;
                                      }
                                    },
                                    horizontalSwipeThreshold: 0.8,
                                    verticalSwipeThreshold: 1,
                                    overlayBuilder: (
                                      context,
                                      properties,
                                    ) =>
                                        CardOverlay(
                                      swipeProgress: properties.swipeProgress,
                                      direction: properties.direction,
                                    ),
                                  ),
                                ),
                              )
                            :  Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  Text("No Matches Found",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: textcolor),),
                                ],),
                              ),
                      ],
                    ),
                  );
                })),
      ),
    );
  }

  Positioned buildFilterWidget(BuildContext context) {
    return Positioned(
      top: 30,
      left: 0,
      right: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              Get.to(()=> FilterScreen());
             /* showMaterialModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                builder: (context) => SingleChildScrollView(
                  controller: ModalScrollController.of(context),
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(top: 50),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        child: FilterScreen(),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.7,
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
                        child: FilterScreen(),
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
              );*/
            },
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300)),
              child: Padding(
                padding: const EdgeInsets.all(11),
                child: Center(
                  child: Image.asset(
                    "assets/filter.png",
                    height: 45,
                    width: 45,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardOverlay extends StatelessWidget {
  const CardOverlay({
    required this.direction,
    required this.swipeProgress,
    Key? key,
  }) : super(key: key);
  final SwipeDirection direction;
  final double swipeProgress;

  @override
  Widget build(BuildContext context) {
    final opacity = math.min<double>(swipeProgress, 1);

    final isRight = direction == SwipeDirection.right;
    final isLeft = direction == SwipeDirection.left;
    final isUp = direction == SwipeDirection.up;
    final isDown = direction == SwipeDirection.down;
    return Stack(
      children: [
        Opacity(
          opacity: isRight ? opacity : 0,
          child: CardLabel.right(),
        ),
        Opacity(
          opacity: isLeft ? opacity : 0,
          child: CardLabel.left(),
        ),
        // Opacity(
        //   opacity: isUp ? opacity : 0,
        //   child: CardLabel.up(),
        // ),
        // Opacity(
        //   opacity: isDown ? opacity : 0,
        //   child: CardLabel.down(),
        // ),
      ],
    );
  }
}

// const _labelAngle = math.pi / 2 * 0.2;

class CardLabel extends StatelessWidget {
  const CardLabel._({
    required this.color,
    required this.height,
    required this.width,
    required this.image_asset,
    Key? key,
  }) : super(key: key);

  factory CardLabel.right() {
    return CardLabel._(
      color: textcolor,
      height: 25.0,
      width: 25.0,
      image_asset: "assets/heartnew.png",
      // angle: -_labelAngle,
    );
  }

  factory CardLabel.left() {
    return CardLabel._(
      color: Color(0xFFF27121),
      height: 15.0,
      width: 15.0,
      image_asset: "assets/dislikenew.png",
      // angle: _labelAngle,
    );
  }

  // factory CardLabel.up() {
  //   return const CardLabel._(
  //     color: Colors.blue,
  //     image_asset: "assets/icons/liked.png",
  //     // angle: 0,
  //   );
  // }

  // factory CardLabel.down() {
  //   return const CardLabel._(
  //     color: Colors.grey,
  //     label: 'DOWN',
  //     angle: -_labelAngle,
  //     alignment: Alignment(0, -0.75),
  //   );
  // }

  final Color color;
  final String image_asset;
  final height;
  final width;

  // final double angle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 180,
          left: MediaQuery.of(context).size.width / 2 - 65,
          right: MediaQuery.of(context).size.width / 2 - 65),
      child: Container(
          height: 65,
          width: 65,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 12,
                  offset: Offset(0, 10), // changes position of shadow
                ),
              ]),
          child: Image.asset(
            image_asset,
            height: height,
            width: width,
            color: color,
          )),
    );
  }
}
