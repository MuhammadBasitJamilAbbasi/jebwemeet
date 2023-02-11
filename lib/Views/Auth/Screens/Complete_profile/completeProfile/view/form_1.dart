import 'dart:developer';
import 'dart:io';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/Profile_Controller.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/add_about.dart';


class Form1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final vm= Get.find<ProfileController>();
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: GetBuilder<ProfileController>(builder: (controller){
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppComponents().sizedBox10,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  "Complete your profile",
                  style: k25styleblack,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Text(
                  "The more you fill out your profile, the better matches we can find for you",
                  style: k14styleblack,
                ),
              ),
              AppComponents().sizedBox15,
              Center(
                child: InkWell(
                  onTap: () {
                    controller.pickImagestatus = true;
                    controller.update();
                    Get.bottomSheet(
                        isDismissible: true,
                        // backgroundColor: Colors.white,
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          child: InkWell(
                            onTap: () {
                              controller.pickImagestatus = false;
                              controller.update();
                            },
                            child: Container(
                              height:
                              MediaQuery.of(context).size.height * 1,
                              width: MediaQuery.of(context).size.width * 1,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                width:
                                MediaQuery.of(context).size.width * 1,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25)),
                                    // border: Border.all(
                                    //   color: butoncolor,
                                    //   width: 1.2,
                                    // ),
                                    color: Colors.white),
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Container(
                                      height: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.02,
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.01),
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.05,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                controller.getImage(context,
                                                    ImageSource.camera);
                                              },
                                              child: Container(
                                                  height:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.171,
                                                  width:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.171,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: butoncolor,
                                                          width: 1.2),
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          12)),
                                                  child: Icon(
                                                    Icons
                                                        .camera_alt_outlined,
                                                    size: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .width *
                                                        0.064,
                                                  )),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.01,
                                            ),
                                            Text(
                                              "Camera",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 13,
                                                  color: const Color(
                                                      0xff666666)),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                controller.getImage(context,
                                                    ImageSource.gallery);
                                              },
                                              child: Container(
                                                  height:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.171,
                                                  width:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.171,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: butoncolor,
                                                          width: 1.2),
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          12)),
                                                  child: Icon(
                                                    Icons.image_outlined,
                                                    size: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .width *
                                                        0.064,
                                                  )),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.01,
                                            ),
                                            Text(
                                              "Gallery",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 13,
                                                  color: const Color(
                                                      0xff666666)),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ));
                  },
                  child: Container(
                    height: 150,
                    width: 150,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 15, right: 0),
                    decoration: controller.selectedImagePath
                        .toString() ==
                        ""
                        ? DottedDecoration(
                      color: textcolor,
                      shape: Shape.circle,
                    )
                        : BoxDecoration(
                        color: kinputbgcolor.withOpacity(0.3),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(File(
                                controller.selectedImagePath)))),
                    child:
                    controller.selectedImagePath.toString() == ""
                        ? Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
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
                          "Profile photo",
                          style: k14styleblack,
                        )
                      ],
                    )
                        : SizedBox.shrink(),
                  ),
                ),
              ),
              AppComponents().sizedBox10,
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Blur my profile",
                      style: k16styleblack,
                    ),
                    Switch(
                      value: controller.isBlured,
                      onChanged: (value) {
                        controller.blurFunction(value);
                      },
                      activeTrackColor: Colors.deepOrange.shade200,
                      activeColor: primarycolor,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  "More photos",
                  style: k16styleblack,
                ),
              ),
              InkWell(
                onTap: () async {
                  controller.filesImages.clear();
                  controller.multipleImagesDownloadLinks!.clear();
                  controller.filesImages =
                  await controller.pickImage(multiple: true);
                  controller.update();
                  if(controller.filesImages.length<5){
                    snackBar(context, "Please Select more than 5 images", Colors.pink);
                  }
                  else {
                    await controller.uploadImages(context);
                  }
                },
                child: Container(
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
                        child: controller.filesImages.length == 0
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
                              "Tap to add more 5 photos",
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
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: textcolor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(child: Text("+",style: TextStyle(color: Colors.white,fontSize: 20),)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),


              // Wrap(
              //   runSpacing: 15,
              //   spacing: 15,
              //   children: List.generate(vm.tourImagesList.length+1, (index) {
              //     return index == 0
              //         ?  InkWell(
              //       onTap: (){
              //         vm.pickTourImages(context);
              //         log( vm.tourImagesList.length.toString());
              //
              //       },
              //           child: Container(
              //       height: MediaQuery.of(context).size.width/2 -30,
              //       width: MediaQuery.of(context).size.width/2 -30,
              //
              //       decoration:DottedDecoration(
              //             borderRadius: BorderRadius.circular(16),
              //             color: Colors.grey,
              //           shape: Shape.box,
              //           strokeWidth: 1
              //       ),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //           Image.asset("assets/camera.png",height: 24,width: 24,color: textcolor,),
              //          AppComponents().sizedBox10,
              //           Text("Click to add images",style: k14styleblack,),
              //         ],
              //       ),
              //           ),
              //         )
              //         :
              //     GetBuilder<ProfileController>(
              //       builder: (vmm) {
              //         return Container(
              //           height: MediaQuery.of(context).size.width / 2-30,
              //           width: MediaQuery.of(context).size.width / 2-30,
              //           child: Stack(
              //             children: [
              //               Positioned(
              //                 top:30,
              //                 right: 30,
              //                 child: Container(
              //                   height: MediaQuery.of(context).size.width / 2 - 30,
              //                   width: MediaQuery.of(context).size.width / 2 - 30,
              //                   decoration: BoxDecoration(
              //                       borderRadius: BorderRadius.circular(16),
              //                       image: DecorationImage(
              //                           image: FileImage(vmm.tourImagesList[index-1]),
              //                           fit: BoxFit.cover)),
              //                 ),
              //               ),
              //               Positioned(
              //                 top: 15,
              //                 right: 15,
              //                 child: InkWell(
              //                   onTap: (){
              //                     vmm.removeTourImages(vmm.tourImagesList[index-1]);
              //                   },
              //                   child: Container(
              //                       height: 25,
              //                       width: 25,
              //                       decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              //                       child: Icon(Icons.clear,size: 15,)),
              //                 ),
              //               )
              //             ],
              //           ),
              //         );
              //       },
              //     );
              //   }),
              // ),

            ],
          ),
        );
      },),
    );
  }

}
