import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Models/chatroom.model.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Home/Controllers/home_page_controller.dart';
import 'package:jabwemeet/Views/Home/Screens/Chat/messaging/inbox.dart';
import 'package:jabwemeet/Views/Home/Screens/Home/new_home_swapable.dart';
import 'package:jabwemeet/Views/Home/Screens/Likes/Likes_screens.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MatchScreen extends StatelessWidget {
  final opponent_image;
  final opponent_name;
  final opponent_age;
  final user_age;
  final opponent_address;
  final user_address;
  final opponent_id;
  final user_image;
  final username;
  final userid;
   MatchScreen({required this.opponent_image,required this.user_age,required this.user_address,required this.opponent_address,required this.opponent_age,required this.user_image,required this.username,required this.opponent_id,required this.opponent_name,required this.userid});
  final controller=Get.find<Home_page_controller>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppComponents().sizedBox30,
            Container(
              height: MediaQuery.of(context).size.height/1.70,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                children: [
                  Positioned(
                    right: 20,
                    top: 20,
                    child: Transform.rotate(
                      angle: 0.3,
                      child: Container(
                        height: 220,
                        width: 160,
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20,left: 20),
                              height: 240,
                              width: 160,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(opponent_image),
                                  fit: BoxFit.cover
                                ),
                                border: Border.all(color: textcolor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
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
                                          offset:
                                          Offset(0, 10), // changes position of shadow
                                        ),
                                      ]),
                                  child: Image.asset(
                                    "assets/heartnew.png",
                                    height: 25,
                                    width: 25,
                                    color: textcolor,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 100,
                    child: Transform.rotate(
                      angle: -0.2,
                      child: Container(
                        height: 260,
                        width: 180,
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20,left: 20,right: 20),
                              height: 220,
                              width: 160,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(user_image),
                                  fit: BoxFit.cover
                                ),
                                border: Border.all(color: textcolor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
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
                                          offset:
                                          Offset(0, 10), // changes position of shadow
                                        ),
                                      ]),
                                  child: Image.asset(
                                    "assets/heartnew.png",
                                    height: 25,
                                    width: 25,
                                    color: textcolor,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("It’s a match, "+username.toString(),textAlign: TextAlign.center,style: TextStyle(color: textcolor,fontSize: 30,fontWeight: FontWeight.w600),),
            ),),
            SizedBox(height: 5,),
            Center(child: Text("Start a conversation now with each other",style:k14styleblack,),),
            AppComponents().sizedBox20,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: kAppButton(buttonText: "Say Hello", onButtonPressed: () async{
                ChatRoomModel?
                chatRoom =
                    await controller
                    .getchatRoom(
                    opponent_id,
                    context);
                Get.to(()=> PersonMessageView(
                    name:opponent_name,
                    profilePicture:opponent_image,
                    age: opponent_age,
                    location: opponent_address,
                    uid: opponent_id,
                    chatRoomModel:
                    chatRoom!));
              }),
            ),
            AppComponents().sizedBox20,
            GestureDetector(
              onTap: (){
                Get.offAll(()=> HomeSwapNew());
              },
              child: Container(
                height: 56,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: textcolor.withOpacity(0.1)
                ),
                child: Center(child: Text("Keep Searching",style: TextStyle(color: textcolor,fontWeight: FontWeight.bold),),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
