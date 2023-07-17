import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Components/Interest_Widget.dart';
import 'package:jabwemeet/Models/UserModel.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Utils/enums.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Home/Controllers/Edit_profile_controller.dart';
import 'package:jabwemeet/Views/Home/Screens/Profile/update_screen.dart';

class Edit_Profile extends StatelessWidget {
  UserModel userModel;

  Edit_Profile({required this.userModel});

  @override
  Widget build(BuildContext context) {
    final storage=Get.find<GetSTorageController>();

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 70),
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 45,
                  width: 45,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: AppComponents().backIcon(() {Get.back();}),
                ),
                Text("Edit Profile",style: k16styleblackBold,),
                SizedBox(width: 90,)
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: GetBuilder<EditProfileController>(
            init: EditProfileController(userModel: userModel),
            builder: (controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppComponents().sizedBox30,
                  Center(
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 160,
                          height: 160,
                          child: Center(
                            child: SizedBox(
                              width: 130,
                              height: 130,
                              child: controller.selectedImagePath
                                          .toString() ==
                                      ""
                                  ? CircleAvatar(
                                      foregroundImage: NetworkImage(
                                          userModel.imageUrl.toString()),
                                      radius: 10,
                                    )
                                  : CircleAvatar(
                                      foregroundImage: FileImage(File(
                                          controller.selectedImagePath)),
                                      radius: 10,
                                    ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 10,
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: InkWell(
                              onTap: () {
                                controller.getImage(context);
                              },
                              child: Image.asset("assets/camera.png",color: textcolor,),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  AppComponents().sizedBox20,
                  Container(
                    height: 210,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 15, right: 15, top: 0),
                    child: Stack(
                      children: [
                        Container(
                          height: 170,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 15, right: 5),
                          width: MediaQuery.of(context).size.width,
                          decoration: DottedDecoration(
                            color: textcolor,
                            shape: Shape.box,
                          ),
                          child: controller.imagesss? GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            padding:
                            EdgeInsets.symmetric(horizontal: 30),
                            children: controller.filesImages
                                .map(
                                  (e) => SizedBox(
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(5),
                                  child: Image.file(
                                    File(e.path),
                                  ),
                                ),
                              ),
                            )
                                .toList(),
                          ) : controller.multipleImagesDownloadLinks!.length == 0
                              ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/camera.png",
                                height: 35,
                                width: 35,
                                color: textcolor,
                              ),
                              AppComponents().sizedBox10,
                              Text(
                                "Tap to add more photos",
                                style: k14styleblack,
                              )
                            ],
                          )
                               : GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            padding:
                            EdgeInsets.symmetric(horizontal: 10),
                            children: controller.multipleImagesDownloadLinks!
                                .map(
                                  (e) => Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: SizedBox(
                                width: double.infinity,
                                child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(5),
                                        child: Image.network(
                                         e.toString(),
                                        ),
                                ),
                              ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: InkWell(
                                          onTap: (){
                                            controller.removepic(e, userModel.uid);
                                          },
                                          child: Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                color: textcolor,
                                                shape: BoxShape.circle
                                              ),
                                              child: Icon(Icons.clear,size: 16,color: Colors.white,)),
                                        ),
                                      )
                                    ],
                                  ),
                            )
                                .toList(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: ()async{
                                controller.filesImages.clear();
                                controller.filesImages =
                                    await controller.pickImage(multiple: true);
                                controller.update();
                                await controller.uploadImages(context).then((value) async {
                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(userModel.uid)
                                      .update({
                                    "imagesList": controller.multipleImagesDownloadLinks!,
                                  });
                                });
                              },
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  color: textcolor,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(child: Text("+",style: TextStyle(color: Colors.white,fontSize: 20),)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  AppComponents().sizedBox20,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Blur my profile",
                          style: k16styleblackBold,
                        ),
                        SizedBox(
                          height: 30,
                          child: Switch(
                            value: controller.isBlured,
                            onChanged: (value) {
                              controller.blurFunction(value);
                            },
                            activeTrackColor: Colors.deepOrange.shade200,
                            activeColor: primarycolor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(padding:
                  EdgeInsets.only(left: 30,right: 30),
                    child: Text("Blurring your media will mean you\nare seen less and receive fewer matches",style: k14styleblack,),
                  ),
                  AppComponents().sizedBox20,
                  buildEditTile(title: "Username", value: controller.nameController.text, ontap: (){Get.to(()=> Update_Screen(userModel: userModel,username: true,));}),
                  buildEditTile(title: "About", value: controller.aboutController.text, ontap: (){  Get.to(()=> Update_Screen(userModel: userModel,about: true,));}),
                  buildEditTile(title: "Education", value:storage.box.read(kEducation).toString() , ontap: (){  Get.to(()=> Update_Screen(userModel: userModel,education: true,));}),
                   buildEditTile(title: "Martial Status", value: storage.box.read(kMartial_Statius).toString(), ontap: (){  Get.to(()=> Update_Screen(userModel: userModel,martial_status: true,));}),
                  storage.box.read(kMartial_Statius).toString()=="Never Married"? SizedBox.shrink() : buildEditTile(title: "Childrens", value: storage.box.read(kchildern).toString()=="null"? "0": storage.box.read(kchildern).toString() , ontap: (){  Get.to(()=> Update_Screen(userModel: userModel,childs: true,));}),
                  buildEditTile(title: "Caste", value: storage.box.read(kCaste), ontap: (){  Get.to(()=> Update_Screen(userModel: userModel,caste: true,));}),
                  buildEditTile(title: "City", value:  storage.box.read(kAddress), ontap: (){  Get.to(()=> Update_Screen(userModel: userModel,city: true,));}),
                  buildEditTile(title: "Religion", value:  storage.box.read(kReligion), ontap: (){  Get.to(()=> Update_Screen(userModel: userModel,religion: true,));}),
                  buildEditTile(title: "Religion Practise", value: storage.box.read(kReligiousPractice), ontap: (){  Get.to(()=> Update_Screen(userModel: userModel,religion_practise: true,));}),
                  buildEditTile(title: "Job title", value: controller.jobtitleController.text, ontap: (){  Get.to(()=> Update_Screen(userModel: userModel,job_title: true,));}),
                  InkWell(
                    onTap: (){
                      Get.to(()=> Update_Screen(userModel: userModel,interests: true,));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:30,vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Interests",
                            style: k16styleblackBold,
                          ),
                          Icon(Icons.arrow_forward_ios_outlined,color: textcolor,size: 20,)

                        ],
                      ),
                    ),
                  ),
                  AppComponents().sizedBox10,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Wrap(
                      direction: Axis.horizontal,
                      runAlignment: WrapAlignment.start,
                      runSpacing: 10,
                      spacing: 10,
                      children:
                      List.generate(controller.getListt!.length, (index) {
                        return IntrinsicWidth(
                          child: InterestWidget(
                            textstyle:k14styleblack,
                            horizontalDistance: 15,
                            image:  controller.getListt![index].image!,
                            borderColor:  Colors.grey.shade300,
                            onlyTilte: false,
                            title: controller.getListt![index].title,
                            onTap: () {
                            },
                            color:Colors.white,
                          ),
                        );
                      }),
                    ),
                  ),
                  AppComponents().sizedBox30,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: kAppButton(
                        buttonstyleSmall: true,
                        buttonText: "Delete your account", onButtonPressed: (){
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
                                    Center(child: Text("Are you sure you want to delete your account?")),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () async{
                                              User current=FirebaseAuth.instance.currentUser!;
                                              bool step1 = true ;
                                              bool step2 = false ;
                                              bool step3 = false ;
                                              bool step4 = false ;
                                              while(true){

                                                if(step1){
                                                  //delete user info in the database
                                                  // var delete = await FirebaseFirestore.instance
                                                  //     .collection('users')
                                                  //     .doc(current.uid)
                                                  //     .delete();
                                                  step1 = false;
                                                  step2 = true;
                                                }

                                                if(step2){
                                                  //delete user
                                                  current.delete();
                                                  step2 = false ;
                                                  step3 = true;
                                                }

                                                if(step3){
                                                  await FirebaseAuth.instance.signOut();
                                                  step3 = false;
                                                  step4 = true ;

                                                }

                                                if(step4){
                                                  //go to sign up log in page
                                                  Get.find<GetSTorageController>().removeStorage();
                                                  step4 = false ;
                                                }

                                                if(!step1 && !step2 && !step3 && !step4 ) {
                                                  break;
                                                }
                                              }
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
                    }),
                  ),
                  AppComponents().sizedBox20,
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Padding buildEditTile({required String title,required String value,required ontap}) {
    return Padding(
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                child: InkWell(
                  onTap: ontap,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                title,
                                style: k16styleblackBold,
                              ),
                              AppComponents().sizedBox15,
                              Text(
                                value,
                                style: k14styleblack,
                              ),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios_outlined,color: textcolor,size: 20,)

                        ],
                      ),
                      AppComponents().sizedBox10,
                      Divider()
                    ],
                  ),
                ),
              );
  }
}
