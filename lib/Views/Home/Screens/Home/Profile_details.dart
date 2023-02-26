import 'package:avatar_glow/avatar_glow.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Utils/locations.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Home/Controllers/home_page_controller.dart';
import 'package:jabwemeet/Views/Home/Screens/Profile/Edit_Profile.dart';
import 'package:readmore/readmore.dart';
import 'package:skeletons/skeletons.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileDetails extends StatelessWidget {
  final image;
  final model;
  final propertiesindex;
  final name;
  final age;
  final work;
  final gender;
  List<dynamic>? interests;
  final martial_status;
  final phone;
  final email;
  final address;
  final height;
  final latitude;
  final longitude;
  final education;
  final blur;
  final jobtitle;
  final industry;
  final about;
  // final caste;
  // final religion;
  List<dynamic>? imgeList;

  ProfileDetails({
    required this.name,
    // required this.caste,
    // required this.religion,
    required this.martial_status,
    required this.work,
    required this.blur,
    required this.email,
    required this.address,
    required this.age,
    required this.propertiesindex,
    required this.model,
    required this.height,
    required this.interests,
    required this.latitude,
    required this.longitude,
    required this.about,
    required this.gender,
    required this.image,
    required this.industry,
    required this.education,
    required this.imgeList,
    required this.phone,
    required this.jobtitle,
  });

  @override
  Widget build(BuildContext context) {
    void getUrlLauncher(Uri url) async {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }
    double datainMeter = GetLocation.DistanceInMeters(
        double.parse(latitude.toString()),
        double.parse(longitude.toString()),
        double.parse(Get.find<Home_page_controller>().userModel.latitude.toString()),
        double.parse(Get.find<Home_page_controller>().userModel.longitude.toString()),
        );
    double kilomter=datainMeter/1000;
    print("datainMeter: " + datainMeter.toString());
    print("datainKiloMeter: " + kilomter.toString());
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GestureDetector(
              onTap: (){
                Get.to(()=> kFullScreenImageViewer(image));
              },
              child: 
              CachedNetworkImage(
                imageUrl: image,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Icon(Icons.error),
                placeholder: (context, url) => Skeleton(isLoading: true, skeleton: SkeletonAvatar(style: SkeletonAvatarStyle(shape: BoxShape.rectangle,)), child: Text("")),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: blur==true? BlurryContainer(
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
            ) : Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Text("")),
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
                                    name.toString() + ", " + age.toString(),
                                    style: TextStyle(
                                        fontSize: 24, fontWeight: FontWeight.w600),
                                  ),
                                  AppComponents().sizedBox10,
                                  Text(
                                    work.toString(),
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
                            //             Border.all(color: Colors.grey.shade300)),
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
                              flex: 7,
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
                                    address.toString(),
                                    style: k14styleblack,
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 34,
                                width: 82,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFFE94057).withOpacity(0.1),),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Row(
                                    children: [
                                      Image.asset("assets/locnew.png",height: 12,width: 12,),
                                      SizedBox(width: 5,),
                                      Expanded(child: Text(kilomter.round().toString()+" km".toString(),style: k12styleblack,))
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        AppComponents().sizedBox20,
                        about.toString() == "null"
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
                        about.toString() != "null"
                            ? Align(
                          alignment: Alignment.centerLeft,
                          child: ReadMoreText(
                          about.toString(),
                          trimLines: 3,
                          colorClickableText: textcolor,
                          trimMode: TrimMode.Line,
                          textAlign: TextAlign.left,
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
                            children: List.generate(interests!.length, (index) {
                              return Container(
                                height: 32,
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                                // alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: textcolor)
                                ),
                                child: Text(interests![index].title.toString()+"  "+interests![index].image.toString()),

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
                            // Text("See All",style: TextStyle(color: textcolor,fontSize: 16,fontWeight: FontWeight.w600),)
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
                          children: List.generate(imgeList!.length, (index) =>  GestureDetector(
                            onTap: (){
                              if(blur==false) {
                                Get.to(() =>
                                    kFullScreenImageViewer(imgeList![index]));
                              }
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: index==0 || index==1 ? 190 : 122,
                                  width: index==0 || index==1 ? 142 : 92,
                                  margin: EdgeInsets.only(right: 5,bottom: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                          image: NetworkImage(imgeList![index]),
                                          fit: BoxFit.cover
                                      )
                                  ),
                                ),
                                blur==true?
                                    BlurryContainer(
                                        height: index==0 || index==1 ? 190 : 122,
                                        width: index==0 || index==1 ? 142 : 92,
                                      blur: 20,
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

                                    ) : Text("")
                              ],
                            ),),)
                        ),
                        AppComponents().sizedBox30,
                        AppComponents().sizedBox50,
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
                      GestureDetector(
                        onTap: (){
                          Get.find<Home_page_controller>().ignorswap(opponent_user: model,visitType: "passed").then((value) => Get.back());
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
                      GestureDetector(
                        onTap: (){
                          Get.find<Home_page_controller>().likeswap(context,opponent_user: model).then((value) => Get.back());
                        },
                        child: Container(
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
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.find<Home_page_controller>().addtofavourite(opponent_user: model).then((value) => Get.back());
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
                              "assets/starnew.png",
                              height: 20,
                              width: 20,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
