import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Models/UserModel.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Home/Screens/Profile/Edit_Profile.dart';
import 'package:jabwemeet/Views/Home/Screens/Tabbar.dart';
import 'package:readmore/readmore.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    UserModel? userModel;
    return Scaffold(
      bottomNavigationBar: kCustomBottomNavBar(
        index: 3,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(user!.uid)
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
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              );
            }
            userModel = UserModel.fromMap(
                snapshot.data!.data() as Map<String, dynamic>);
            return Stack(
              children: [
                GestureDetector(
                  onTap: (){
                    Get.to(()=> kFullScreenImageViewer(userModel!.imageUrl.toString()));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(userModel!.imageUrl.toString()), fit: BoxFit.cover)),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height/2,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height - 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            AppComponents().sizedBox50,
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        userModel!.name!.toString() + ", " + userModel!.age.toString(),
                                        style: TextStyle(
                                            fontSize: 24, fontWeight: FontWeight.w600),
                                      ),
                                      AppComponents().sizedBox10,
                                      Text(
                                        userModel!.work.toString(),
                                        style: k14styleblack,
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                        border:
                                        Border.all(color: Colors.grey.shade300)),
                                    child: Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Image.asset("assets/arrownew.png"),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            AppComponents().sizedBox20,
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Location" ,
                                        style: TextStyle(
                                            fontSize: 16, fontWeight: FontWeight.w600),
                                      ),
                                      AppComponents().sizedBox10,
                                      Text(
                                        userModel!.address.toString(),
                                        style: k14styleblack,
                                      )
                                    ],
                                  ),
                                ),
                                // Expanded(
                                //   flex: 2,
                                //   child: Container(
                                //     height: 34,
                                //     width: 82,
                                //     decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(10),
                                //       color: Color(0xFFE94057).withOpacity(0.1),),
                                //     child: Padding(
                                //       padding: EdgeInsets.only(left: 8),
                                //       child: Row(
                                //         children: [
                                //           Image.asset("assets/locnew.png",height: 12,width: 12,),
                                //           SizedBox(width: 5,),
                                //           Expanded(child: Text(kilomter.round().toString()+" km".toString(),style: k12styleblack,))
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                            AppComponents().sizedBox20,
                            userModel!.about.toString() == "null"
                                ? SizedBox.shrink()
                                : Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "About",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            AppComponents().sizedBox10,
                            userModel!.about.toString() != "null"
                                ? Align(
                              alignment: Alignment.centerLeft,
                                  child: ReadMoreText(
                              userModel!.about.toString(),
                              trimLines: 3,
                              colorClickableText: textcolor,
                              trimMode: TrimMode.Line,
                              textAlign: TextAlign.start,
                              style: k14styleblack,
                              trimCollapsedText: ' Read more',
                              trimExpandedText: ' Show less',
                              moreStyle: TextStyle(color: textcolor,fontWeight: FontWeight.w600),
                            ),
                                )
                                : SizedBox.shrink(),
                            AppComponents().sizedBox20,
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Interests",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            AppComponents().sizedBox10,
                            SizedBox(
                              width: double.infinity,
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                runAlignment: WrapAlignment.start,
                                runSpacing: 8,
                                spacing: 8,
                                children: List.generate(userModel!.hobbies!.length, (index) {
                                  return Container(
                                    height: 32,
                                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),

                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: textcolor)
                                    ),
                                    child: Text(userModel!.hobbies![index].toString()),
                                  );
                                }),
                              ),
                            ),
                            AppComponents().sizedBox20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Gallery",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text("See All",style: TextStyle(color: textcolor,fontSize: 16,fontWeight: FontWeight.w600),)
                              ],
                            ),
                            AppComponents().sizedBox10,
                            /* Wrap(
                  runSpacing: 8,
                  spacing: 8,
                  children: List.generate(imgeList!.length, (index) {
                    return Container(
                      width: MediaQuery.of(context).size.width/2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),),
                      child: Image.network(imgeList![index].toString()),
                    );
                  }),
                ),*/
                            Wrap(
                                children: List.generate(userModel!.imagesList!.length, (index) =>  GestureDetector(
                                  onTap: (){
                                    Get.to(()=> kFullScreenImageViewer(userModel!.imagesList![index]));
                                  },
                                  child: Container(
                                    height: index==0 || index==1 ? 190 : 122,
                                    width: index==0 || index==1 ? 142 : 92,
                                    margin: EdgeInsets.only(right: 5,bottom: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                            image: NetworkImage(userModel!.imagesList![index]),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),),)
                            ),
                            AppComponents().sizedBox30,
                            AppComponents().sizedBox50,
                            AppComponents().sizedBox20,
                            AppComponents().sizedBox20,

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top:  MediaQuery.of(context).size.height/2 - 40,
                  left: 50,
                  right: 50,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                            },
                            child: Container(
                                height: 50,
                                width: 50,
                                margin: EdgeInsets.only(bottom: 20),
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
                                  "assets/dislikenew.png",
                                  height: 15,
                                  width: 15,
                                )),
                          ),
                          Container(
                              height: 70,
                              width: 70,
                              margin: EdgeInsets.only(bottom: 20),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFE94057),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.red.shade200.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 10,
                                      offset:
                                      Offset(0, 4), // changes position of shadow
                                    ),
                                  ]),
                              child: Image.asset(
                                "assets/heartnew.png",
                                height: 25,
                                width: 30,
                                fit: BoxFit.fill,
                              )),
                          Container(
                              height: 50,
                              width: 50,
                              margin: EdgeInsets.only(bottom: 20),
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
                                "assets/starnew.png",
                                height: 20,
                                width: 20,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 20,
                  child: GestureDetector(
                    onTap: (){
                      Get.find<GetSTorageController>().removeStorage();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                        child: Center(
                          child: Icon(
                            Icons.logout_rounded,
                            color: textcolor,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
