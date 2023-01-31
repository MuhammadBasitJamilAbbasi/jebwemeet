import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Models/UserModel.dart';
import 'package:jabwemeet/Models/likes_model.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Home/Controllers/home_page_controller.dart';
import 'package:jabwemeet/Views/Home/Screens/Home/Profile_details.dart';
import 'package:jabwemeet/Views/Home/Screens/Home/filterScreen.dart';
import 'package:jabwemeet/Views/Home/Screens/Tabbar.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late AnimationController controllerr;
  final controller = Get.find<Home_page_controller>();

  PageController pagecontroller = PageController();
  @override
  void initState() {
    // TODO: implement initState
    controller.userList.clear();
    controller.getUserDetails();
    controller.getData();
    controllerr = BottomSheet.createAnimationController(this);
    controllerr.duration = Duration(seconds: 1);
    super.initState();

  }
  @override
  void dispose() {
    controllerr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: kCustomBottomNavBar(
        index: 0,
      ),
      body: SafeArea(
          child: GetBuilder<Home_page_controller>(
              init: Home_page_controller(),
              builder: (controller) {
                return Stack(
                  children: [
                    controller.userList.length == 0
                        ? Center(
                            child: Lottie.asset('assets/json/nodata.json'),
                          )
                        : PageView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: controller.userList.length,
                            controller: pagecontroller,
                            onPageChanged: (page) {
                              controller.selectedIndex = page;
                              controller.update();
                            },
                            itemBuilder: (BuildContext context, index) {
                              UserModel userModel = UserModel.fromMap(
                                  controller.userList[index].data()
                                      as Map<String, dynamic>);
                              print("<===========Image Url=============>");
                              log(userModel.imageUrl.toString());
                              return Card(
                                clipBehavior: Clip.antiAlias,
                                color: Colors.white,
                                margin: EdgeInsets.zero,
                                // shape: defaultCardBorder(),
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Stack(
                                    children: [
                                      CachedNetworkImage(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        imageUrl: userModel.imageUrl.toString(),
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) => Center(
                                          child: SizedBox(
                                            width: 40.0,
                                            height: 40.0,
                                            child:
                                                new CircularProgressIndicator(),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                      userModel.blur!
                                          ? ClipRRect(
                                              // Clip it cleanly.
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaX: 20, sigmaY: 20),
                                                child: Container(
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                  alignment: Alignment.center,
                                                  child: Text(''),
                                                ),
                                              ),
                                            )
                                          : SizedBox.shrink(),
                                      Positioned(
                                        bottom: 30,
                                        left: 0,
                                        right: 0,
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 1.0, sigmaY: 0.1),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      Get.to(() => ProfileDetails(
                                                        latitude: userModel.latitude,
                                                          longitude: userModel.longitude,
                                                          interests: userModel.hobbies??[],
                                                          name: userModel.name
                                                                  .toString() ??
                                                              "",
                                                          martial_status: userModel
                                                                  .martial_status
                                                                  .toString() ??
                                                              "",
                                                          work: userModel.work
                                                                  .toString() ??
                                                              "",
                                                          email: userModel.email
                                                                  .toString() ??
                                                              "",
                                                          address: userModel
                                                                  .address
                                                                  .toString() ??
                                                              "",
                                                          age: userModel.age
                                                                  .toString() ??
                                                              "",
                                                          height: userModel.height.toString() ?? "",
                                                          gender: userModel.gender.toString() ?? "",
                                                          image: userModel.imageUrl.toString() ?? "",
                                                          industry: userModel.industry.toString() ?? "",
                                                          education: userModel.education.toString() ?? "",
                                                          imgeList: userModel.imagesList ?? [],
                                                          about: userModel.about.toString() ?? "",
                                                          phone: userModel.phone_number.toString() ?? "",
                                                          jobtitle: userModel.job_title ?? ""));
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  height: 150,
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              userModel.name
                                                                  .toString(),
                                                              style:
                                                                  k18stylePrimary,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            // userModel.subscribe!
                                                            //     ? Image.asset(
                                                            //         "assets/icons/check.png",
                                                            //         height: 20,
                                                            //         width: 20,
                                                            //       )
                                                            //     : SizedBox
                                                            //         .shrink()
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Age: " +
                                                                      userModel
                                                                          .age
                                                                          .toString(),
                                                                  style:
                                                                      k10stylePrimary,
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  "Profession: " +
                                                                      userModel
                                                                          .work
                                                                          .toString(),
                                                                  style:
                                                                      k10stylePrimary,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        AppComponents()
                                                            .sizedBox10,
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            InkWell(
                                                              onTap: () async {
                                                                print(controller
                                                                    .userList
                                                                    .length
                                                                    .toString());
                                                                print(
                                                                    "Remove tap");
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "users")
                                                                    .doc(controller
                                                                        .userModel
                                                                        .uid)
                                                                    .collection(
                                                                        "visits")
                                                                    .doc(userModel
                                                                        .uid
                                                                        .toString())
                                                                    .set({
                                                                  "uid": userModel
                                                                      .uid
                                                                      .toString()
                                                                });
                                                                controller
                                                                    .userList
                                                                    .remove(controller
                                                                            .userList[
                                                                        index]);
                                                                print(controller
                                                                    .userList
                                                                    .length
                                                                    .toString());
                                                                controller
                                                                    .update();
                                                              },
                                                              child:
                                                                  Image.asset(
                                                                "assets/icons/cancel.png",
                                                                height: 50,
                                                                width: 50,
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () async {
                                                                log("1");
                                                                LikesModel? chatRoom = await controller
                                                                    .getLikes(
                                                                        opponent_id: userModel
                                                                            .uid
                                                                            .toString(),
                                                                        fcm_token: userModel
                                                                            .fcm_token
                                                                            .toString(),
                                                                        context:
                                                                            context,
                                                                        isSenderImage: controller
                                                                            .userModel
                                                                            .imageUrl
                                                                            .toString(),
                                                                        isSenderName: controller
                                                                            .userModel
                                                                            .name
                                                                            .toString(),
                                                                        isRecImage: userModel
                                                                            .imageUrl
                                                                            .toString(),
                                                                        isRecName: userModel
                                                                            .name
                                                                            .toString())
                                                                    .then(
                                                                        (value) async {
                                                                  print(
                                                                      "Remove tap");
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "users")
                                                                      .doc(controller
                                                                          .userModel
                                                                          .uid)
                                                                      .collection(
                                                                          "visits")
                                                                      .doc(userModel
                                                                          .uid
                                                                          .toString())
                                                                      .set({
                                                                    "uid": userModel
                                                                        .uid
                                                                        .toString()
                                                                  });
                                                                });
                                                                log("2");
                                                                if ((chatRoom !=
                                                                    null)) {
                                                                  /* snackBar(
                                                                        context,
                                                                        "Your Like the ${userModel.name}",
                                                                        Colors.pink);*/
                                                                }
                                                              },
                                                              child: Container(
                                                                height: 50,
                                                                width: 50,
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            10),
                                                                decoration: BoxDecoration(
                                                                    color: Color(
                                                                        0xFFFA2A39),
                                                                    shape: BoxShape
                                                                        .circle),
                                                                child:
                                                                    Image.asset(
                                                                  "assets/icons/heart.png",
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            )
                                                          ],
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
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){
                              showMaterialModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50))
                                ),
                                builder: (context) => SingleChildScrollView(
                                  controller: ModalScrollController.of(context),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: MediaQuery.of(context).size.height*0.7,
                                        width: MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.only(top: 50),
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50))
                                        ),
                                        child: FilterScreen(),
                                      ),
                                      Container(
                                        height: MediaQuery.of(context).size.height*0.7,
                                        width: MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.only(top: 10),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage("assets/crop.png"),
                                            fit: BoxFit.fill,
                                          ),
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50))
                                        ),
                                        child: FilterScreen(),
                                      ),
                                      Center(
                                        child: Image.asset("assets/c.png",width: 47,height: 25,),
                                      )
                                    ],
                                  ),
                                ),
                              );
                              // showModalBottomSheet(
                              //     elevation: 0.8,
                              //     isScrollControlled: true,
                              //     isDismissible: true,
                              //     transitionAnimationController: controllerr,
                              //     shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.only(
                              //             topLeft: Radius.circular(50),
                              //             topRight: Radius.circular(50))),
                              //     context: context,
                              //     builder: (context) {
                              //       return FractionallySizedBox(
                              //           heightFactor: 0.85,
                              //           child: FilterScreen());
                              //     });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey.shade300)),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                                child: Center(
                                  child: Image.asset(
                                    "assets/filter.png",
                                    height: 35,
                                    width: 35,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              })),
    );
  }
}
