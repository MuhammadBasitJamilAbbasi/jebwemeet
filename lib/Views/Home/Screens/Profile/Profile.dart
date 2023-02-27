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
                            AppComponents().sizedBox30,
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
                                        userModel!.job_title.toString(),
                                        style: k14styleblack,
                                      ),
                                    ],
                                  ),
                                ),
                                // Expanded(
                                //   flex: 1,
                                //   child: Container(
                                //     height: 45,
                                //     width: 45,
                                //     decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(15),
                                //         color: Colors.white,
                                //         border:
                                //         Border.all(color: Colors.grey.shade300)),
                                //     child: Padding(
                                //       padding: EdgeInsets.all(12),
                                //       child: Image.asset("assets/arrownew.png"),
                                //     ),
                                //   ),
                                // )
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
                                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: textcolor)
                                    ),
                                    child: Text(userModel!.hobbies![index].title.toString()+"  "+userModel!.hobbies![index].image.toString()),
                                  );
                                }),
                              ),
                            ),
                            AppComponents().sizedBox20,
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Caste",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            AppComponents().sizedBox10,

                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                userModel!.caste.toString(),
                                style: k14styleblack,
                              ),
                            ),
                            AppComponents().sizedBox20,
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Religion",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            AppComponents().sizedBox10,
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                userModel!.religion.toString(),
                                style: k14styleblack,
                              ),
                            ),
                            AppComponents().sizedBox20,
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Religion Practise",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            AppComponents().sizedBox10,
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                userModel!.religious_practice.toString(),
                                style: k14styleblack,
                              ),
                            ),
                            AppComponents().sizedBox20,
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Martial Status",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            AppComponents().sizedBox10,
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                userModel!.martial_status.toString(),
                                style: k14styleblack,
                              ),
                            ),
                            AppComponents().sizedBox20,
                            userModel!.martial_status.toString()=="Never Married"? SizedBox.shrink():   Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Children",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            userModel!.martial_status.toString()=="Never Married"? SizedBox.shrink():   AppComponents().sizedBox10,
                            userModel!.martial_status.toString()=="Never Married"? SizedBox.shrink():  Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                userModel!.childerns.toString(),
                                style: k14styleblack,
                              ),
                            ),
                            AppComponents().sizedBox20,
                          userModel!.imagesList!.length>0?  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Gallery",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                // Text("See All",style: TextStyle(color: textcolor,fontSize: 16,fontWeight: FontWeight.w600),)
                              ],
                            ) : SizedBox.shrink(),
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
                                    height: index==0 || index==1 ? 170 : 122,
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
                  top:  MediaQuery.of(context).size.height/2 - 30,
                  right: 25,
                  child: Column(
                    children: [
                    Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){
                          Get.to(()=> Edit_Profile(userModel: userModel!));
                        },
                        child: Container(
                            height: 50,
                            width: 50,
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
                            child: Icon(
                              Icons.edit,
                              size: 30,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                    ]),),
                Positioned(
                  top: 40,
                  right: 20,
                  child: GestureDetector(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Container(
                                height: 180,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/appicon.png",
                                      height: 45,
                                      width: 45,
                                    ),
                                    SizedBox(height: 20),
                                    Center(child: Text("Are you sure you want to logout?")),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              print('yes selected');
                                              Get.find<GetSTorageController>().removeStorage();
                                             },
                                            child: Container(
                                                height: 35,
                                                child: Center(child: Text("Yes"))),
                                            style: ElevatedButton.styleFrom(primary: textcolor),
                                          ),
                                        ),
                                        SizedBox(width: 15),
                                        Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                print('no selected');
                                                Navigator.of(context).pop();
                                              },
                                              child:
                                              Container(
                                                  height:35,
                                                  child: Center(child: Text("No", style: TextStyle(color: Colors.white)))),
                                              style: ElevatedButton.styleFrom(
                                                primary: textcolor,
                                              ),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
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
