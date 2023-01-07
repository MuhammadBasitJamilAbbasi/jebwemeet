import 'package:avatar_glow/avatar_glow.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileDetails extends StatelessWidget {
  final image;
  final name;
  final age;
  final work;
  final gender;
  final martial_status;
  final phone;
  final email;
  final address;
  final height;
  final education;
  final jobtitle;
  final industry;
  final about;
  List<dynamic>? imgeList;
  ProfileDetails({
    required this.name,
    required this.martial_status,
    required this.work,
    required this.email,
    required this.address,
    required this.age,
    required this.height,
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: AppComponents().backIcon(() {
          Get.back();
        }),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    height: 300,
                    child: Stack(children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          viewportFraction: 1,
                          aspectRatio: 1.5,
                          enlargeCenterPage: true,
                          // enlargeCenterPage: true,
                          //scrollDirection: Axis.vertical,
                          onPageChanged: (index, reason) {
                            // setState(
                            //   () {
                            //     _currentIndex = index;
                            //   },
                            // );
                            // setState(() {});
                          },
                        ),
                        items: imgeList!
                            .map(
                              (item) => Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      height: 300,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              butoncolor.withOpacity(0.3),
                                              butoncolor.withOpacity(0.1),
                                            ],
                                          )),
                                      child: Image.network(
                                        item,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      Positioned(
                        top: 120,
                        left: 20,
                        right: 20,
                        child: Center(
                          child: AvatarGlow(
                            glowColor: Color.fromARGB(255, 15, 233, 106),
                            endRadius: 90.0,
                            duration: Duration(milliseconds: 2000),
                            repeat: true,
                            showTwoGlows: true,
                            repeatPauseDuration: Duration(milliseconds: 100),
                            child: Center(
                              child: SizedBox(
                                width: 130,
                                height: 130,
                                child: CircleAvatar(
                                  foregroundImage:
                                      NetworkImage(image.toString()),
                                  radius: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                  /* TextButton(
                      onPressed: () async {
                        getUrlLauncher(Uri.parse(phone.toString()));
                      },
                      child: Text(
                        phone.toString(),
                        style: TextStyle(
                            color: butoncolor, fontWeight: FontWeight.bold),
                      )),*/
                  /*   TextButton(
                      onPressed: () async {
                        getUrlLauncher(Uri.parse(email.toString()));
                      },
                      child: Text(
                        email.toString(),
                        style: TextStyle(
                            color: butoncolor, fontWeight: FontWeight.bold),
                      )),*/
                  about.toString() == "null"
                      ? SizedBox.shrink()
                      : Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "About",
                            style: k18styleblack,
                          ),
                        ),
                  about.toString() != "null"
                      ? Detail_Profile_Tile(
                          value: about.toString(),
                          ontap: () {},
                        )
                      : SizedBox.shrink(),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Name",
                      style: k18styleblack,
                    ),
                  ),
                  Detail_Profile_Tile(
                    value: name.toString(),
                    ontap: () {},
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Occupation",
                      style: k18styleblack,
                    ),
                  ),
                  Detail_Profile_Tile(
                    value: work.toString(),
                    ontap: () {},
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Job Title",
                      style: k18styleblack,
                    ),
                  ),
                  Detail_Profile_Tile(
                    value: jobtitle.toString(),
                    ontap: () {},
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Gendar",
                      style: k18styleblack,
                    ),
                  ),
                  Detail_Profile_Tile(
                    value: gender.toString(),
                    ontap: () {},
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Age",
                      style: k18styleblack,
                    ),
                  ),
                  Detail_Profile_Tile(
                    value: age.toString(),
                    ontap: () {},
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Martial Status",
                      style: k18styleblack,
                    ),
                  ),
                  Detail_Profile_Tile(
                    value: martial_status.toString(),
                    ontap: () {},
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Address",
                      style: k18styleblack,
                    ),
                  ),
                  Detail_Profile_Tile(
                    value: address.toString(),
                    ontap: () {},
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Height",
                      style: k18styleblack,
                    ),
                  ),
                  Detail_Profile_Tile(
                    value: height.toString(),
                    ontap: () {},
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Education",
                      style: k18styleblack,
                    ),
                  ),
                  Detail_Profile_Tile(
                    value: education.toString(),
                    ontap: () {},
                  ),
                ],
              ),
              AppComponents().sizedBox20,
              AppComponents().sizedBox20,
            ],
          ),
        ),
      ),
    );
  }
}
