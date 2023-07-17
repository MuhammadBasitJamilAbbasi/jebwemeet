import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Models/Hobbies_Model.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Home/Screens/Home/home_swap.dart';
import 'package:jabwemeet/Views/Home/Screens/Home/new_home_swapable.dart';

class ProfileController extends GetxController {
  ScrollController scrollController = ScrollController();
  int currentStep = 1;

  int stepLength = 4;

  late bool complete;

  next() {
    if (currentStep <= stepLength) {
      goTo(currentStep + 1);
    }
  }

  back() {
    if (currentStep > 1) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
     currentStep = step;
     update();
    if (currentStep > stepLength) {
      complete = true;
      update();
  }}
  scrollAnimate() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
    );
    update();
  }
  final List<File> tourImagesList = [];


  String tourImagesUrl = '';


  // Stream<List<UserData>> get allUsers => dataBaseService.getAllUserData();

  changeTourImages(var image) {
    tourImagesList.add(image);
    update();
  }
  removeTourImages(var image) {
    tourImagesList.remove(image);
    update();
  }
  changeTourImageUrl(String url) {
    tourImagesUrl = url;
    update();
  }



  void pickTourImages(BuildContext context) async {
    final pickedImages = await imagePicker.pickMultiImage();
    if (pickedImages != null) {
      for (int i = 0; i < pickedImages.length; i++) {
        changeTourImages( File(pickedImages[i].path));
      }
    }
  }
  bool isBlured = false;
  blurFunction(bool value) {
    isBlured = value;
    update();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.find<GetSTorageController>().box.write(kImageUrl, "").toString();
    Get.find<GetSTorageController>().box.write(kImageUrl, "").toString();
    Get.find<GetSTorageController>().box.write(kWork, "").toString();
    Get.find<GetSTorageController>().box.write(kIncome, "").toString();
    Get.find<GetSTorageController>().box.write(kSports, "").toString();
    Get.find<GetSTorageController>().box.write(kHobbies, "").toString();
    Get.find<GetSTorageController>().box.write(kAbout, "").toString();
    Get.find<GetSTorageController>().box.write(kJobTitle, "").toString();
    Get.find<GetSTorageController>().box.write(kIndustry, "").toString();
  }

  bool pickImagestatus = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Get.find<GetSTorageController>().box.write(kImageUrl, "").toString();
    Get.find<GetSTorageController>().box.write(kWork, "").toString();
    Get.find<GetSTorageController>().box.write(kIncome, "").toString();
    Get.find<GetSTorageController>().box.write(kSports, "").toString();
    Get.find<GetSTorageController>().box.write(kHobbies, "").toString();
    Get.find<GetSTorageController>().box.write(kAbout, "").toString();
    Get.find<GetSTorageController>().box.write(kJobTitle, "").toString();
    Get.find<GetSTorageController>().box.write(kIndustry, "").toString();
  }

  TextEditingController workController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController casteController = TextEditingController();
  TextEditingController sportsController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController moviesController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController jobtitleController = TextEditingController();
  TextEditingController addindustryController = TextEditingController();
  List<String>? kList = [];
  String? selectedMartialStatus = "Select Status";

  String? selectedReligion = "Select Religion";
  String? selectedCaste = "Select Caste";
  String? selectedCity = "Select City";
  var selectedImagePath = "";
  var selectedReligiousPractice = 0.0;
  bool isLoader = false;
  bool isImageLoading = false;
  ImagePicker imagePicker = ImagePicker();
  File? file;
  double? percentage;

/*
  Future getImage(ImageSource imageSource) async {
    // ignore: deprecated_member_use
    final pickedFile = await imagePicker.getImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath = pickedFile.path;
      update();
      file = File(pickedFile.path);
      selectedImageSize = ((File(selectedImagePath)).lengthSync() / 1024 / 1024)
              .toStringAsFixed(2) +
          "Mb";
      update();
    }
  }
*/
  selectedMartialFunction(String? value) {
    selectedMartialStatus = value;
    update();
  }

  selectedReligiousPracticeFunction(value) {
    selectedReligiousPractice = value;
    update();
  }

  selectedCityFunction(String? value) {
    selectedCity = value;
    update();
  }


  selectedReligionFunction(String? value) {
    selectedReligion = value;
    update();
  }

  selectedCasteFunction(String? value) {
    selectedCaste = value;
    update();
  }

  List interestList = [];
  List addTopicsList = [];
  int? totalSelection = 0;
  int? topicsSelected;
  List usersInterest = [];





  List<InterestModel>? getList = [];
  List<Map<String, dynamic>> interestsList = [];
  //add topics to the list
  void addTopics(InterestModel topics) {
    if(getList!.isEmpty){
      print("Inbterest 1");
      getList!.add(topics);
      update();
    }
    else {
      // if (getList!.contains(topics) == true) {
      //
      // }
      // else {
        print("Inbterest 1 say zyda");
        getList!.add(topics);
        update();
        print("okay 2");
      // }
    }
    print("Interesrt List  ${getList!.length}");
  }

  //remove topics from the list
  void removeTopics(InterestModel topics) {
    getList!.remove(topics);
    update();
    print("Interesrt List  ${getList!.length}");
  }


  List<XFile> filesImages = [];
  List<String>? multipleImagesDownloadLinks = [];
  Future<List<XFile>> pickImage(
      {ImageSource imageSource = ImageSource.gallery,
      bool multiple = false}) async {
    if (multiple) {
      return imagePicker.pickMultiImage();
    }
    update();
    final singleImage = await imagePicker.pickImage(source: imageSource);
    update();
    if (singleImage != null) {
      return [singleImage];
    } else
      return [];
  }

  int imagelistlength=0;
  Future<List<String>?> uploadImages(BuildContext context) async {
    multipleImagesDownloadLinks = [];
    imagelistlength = filesImages.length;
    try {
      for (var img in filesImages) {
        print(img);
        print(img.path);
        Reference ref;
        ref = FirebaseStorage.instance.ref().child('profilePics').child(img.path);

        File compressedFile = await compressFile(File(img.path)); // Compress the image

        await ref.putFile(compressedFile).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            multipleImagesDownloadLinks!.add(value);
            debugPrint("multiple images are ${multipleImagesDownloadLinks.toString()}");
          });
        });
      }
      log("Uploading images successfully");
    } catch (e) {
      log(e.toString());
      log("Error in uploading images");
    }

    update();
    debugPrint("multiple images are ${multipleImagesDownloadLinks.toString()}");
    return multipleImagesDownloadLinks;
  }

  Future<File> compressFile(File file) async {
    try {
      var result = await FlutterImageCompress.compressWithFile(
        file.absolute.path,
        quality: 70, // Adjust the quality as per your requirement
      );

      // Create a new file and write the compressed data into it
      final compressedFile = File('${file.path}_compressed.jpg');
      await compressedFile.writeAsBytes(result!);

      return compressedFile;
    } catch (e) {
      // Handle the error appropriately
      print(e);
      throw Exception('Failed to compress file');
    }
  }





  checkintrest(BuildContext context)
  {
    if (selectedImagePath.toString() == "") {
      snackBar(context, "Please Add your image in step 1", Colors.pink);
    } else if (Get.find<GetSTorageController>().box.read(kHeight).toString() ==
        "" ||
        Get.find<GetSTorageController>().box.read(kHeight).toString() ==
            "null") {
      snackBar(context, "Please Enter your Height", Colors.pink);
    }else if (Get.find<GetSTorageController>().box.read(kMartial_Statius).toString() ==
        "" ||
        Get.find<GetSTorageController>().box.read(kMartial_Statius).toString() ==
            "null") {
      snackBar(context, "Please Select Martial Status", Colors.pink);
    }
    else if(getList!.isEmpty){
      snackBar(context, "Please add interests", Colors.pink);
    }else
      {
        next();
      }
  }
  checkabout( BuildContext context)
  {
    if (Get.find<GetSTorageController>().box.read(kAbout).toString() ==
        "" ||
        Get.find<GetSTorageController>().box.read(kAbout).toString() ==
            "null") {
      snackBar(context, "Please enter about", Colors.pink);
    }
    else if (Get.find<GetSTorageController>().box.read(kReligion).toString() ==
        "" ||
        Get.find<GetSTorageController>().box.read(kReligion).toString() ==
            "null") {
      snackBar(context, "Please Select Your Religion", Colors.pink);
    }
    else if (Get.find<GetSTorageController>().box.read(kCaste).toString() ==
        "" ||
        Get.find<GetSTorageController>().box.read(kCaste).toString() ==
            "null") {
      snackBar(context, "Please Select Caste", Colors.pink);
    } else if (kList!.length == 0) {
      snackBar(context, "Please add your Language", Colors.pink);
    }else if (Get.find<GetSTorageController>()
        .box
        .read(kReligiousPractice)
        .toString() ==
        "" ||
        Get.find<GetSTorageController>()
            .box
            .read(kReligiousPractice)
            .toString() ==
            "null") {
      snackBar(context, "Please add your Religious Practice", Colors.pink);
    }else{
      next();
    }

  }
  submitProfile(BuildContext context) async {
    print(getList!.toString());
    for (var i in getList!) {
      interestsList.add({
        'image': i.image,
        'title': i.title,
      });
    }
    if (selectedImagePath.toString() == "") {
      snackBar(context, "Please Add your image in step 1", Colors.pink);
    } else if (Get.find<GetSTorageController>().box.read(kHeight).toString() ==
        "" ||
        Get.find<GetSTorageController>().box.read(kHeight).toString() ==
            "null") {
      snackBar(context, "Please Enter your Height", Colors.pink);
    }else if (Get.find<GetSTorageController>().box.read(kMartial_Statius).toString() ==
        "" ||
        Get.find<GetSTorageController>().box.read(kMartial_Statius).toString() ==
            "null") {
      snackBar(context, "Please Select Martial Status", Colors.pink);
    }
    else if(getList!.isEmpty){
      snackBar(context, "Please add interests", Colors.pink);
    }
    else if (Get.find<GetSTorageController>().box.read(kAbout).toString() ==
            "" ||
        Get.find<GetSTorageController>().box.read(kAbout).toString() ==
            "null") {
      snackBar(context, "Please enter about", Colors.pink);
    } else if (Get.find<GetSTorageController>().box.read(kReligion).toString() ==
        "" ||
        Get.find<GetSTorageController>().box.read(kReligion).toString() ==
            "null") {
      snackBar(context, "Please Select Your Religion", Colors.pink);
    } else if (Get.find<GetSTorageController>()
        .box
        .read(kReligiousPractice)
        .toString() ==
        "" ||
        Get.find<GetSTorageController>()
            .box
            .read(kReligiousPractice)
            .toString() ==
            "null") {
      snackBar(context, "Please add your Religious Practice", Colors.pink);
    } else if (Get.find<GetSTorageController>().box.read(kCaste).toString() ==
        "" ||
        Get.find<GetSTorageController>().box.read(kCaste).toString() ==
            "null") {
      snackBar(context, "Please Select Caste", Colors.pink);
    } else if (kList!.length == 0) {
      snackBar(context, "Please add your Language", Colors.pink);
    } else if (Get.find<GetSTorageController>()
                .box
                .read(kEducation)
                .toString() ==
            "" ||
        Get.find<GetSTorageController>().box.read(kEducation).toString() ==
            "null") {
      snackBar(context, "Please Select your education level", Colors.pink);
    }  else if (Get.find<GetSTorageController>().box.read(kWork).toString() ==
            "" ||
        Get.find<GetSTorageController>().box.read(kWork).toString() == "null") {
      snackBar(context, "Please Select your profession", Colors.pink);
    } else if (jobtitleController.value.text.isEmpty) {
      snackBar(context, "Please add your Job title", Colors.pink);
    } else if (Get.find<GetSTorageController>().box.read(kIncome).toString() ==
        "" ||
        Get.find<GetSTorageController>().box.read(kIncome).toString() ==
            "null") {
      snackBar(context, "Please Enter your income", Colors.pink);
    }
    // else if (multipleImagesDownloadLinks!.isEmpty) {
    //   snackBar(context, "Please Add your images in step 1", Colors.pink);
    // }
    else if (multipleImagesDownloadLinks!.length!=imagelistlength) {
      snackBar(context, "Images uploading take some time please wait", Colors.pink);
    }  else {
      User? user = FirebaseAuth.instance.currentUser!;
      try {
        isLoader = true;
        update();
        await uploadProfile(context).then((value) async {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .update({
            "about":
                aboutController.value.text,
            "education": Get.find<GetSTorageController>()
                .box
                .read(kEducation)
                .toString(),
            "imagesList": multipleImagesDownloadLinks,
            "blur": isBlured,
            "job_title":
                jobtitleController.value.text,
            "industry":
                Get.find<GetSTorageController>().box.read(kIndustry).toString(),
            "languages": kList,
            "height":
                Get.find<GetSTorageController>().box.read(kHeight).toString(),
            "hobbies": interestsList,
            "martial_status": Get.find<GetSTorageController>()
                .box
                .read(kMartial_Statius)
                .toString(),
            "imageUrl":
                Get.find<GetSTorageController>().box.read(kImageUrl).toString(),
            "income":
                Get.find<GetSTorageController>().box.read(kIncome).toString(),
            "religious_practice": Get.find<GetSTorageController>()
                .box
                .read(kReligiousPractice)
                .toString(),
            "work": Get.find<GetSTorageController>().box.read(kWork).toString(),
            "childerns":
                Get.find<GetSTorageController>().box.read(kchildern).toString()
          }).then((value) => Get.offAll(() => HomeSwapNew()));
        });
        isLoader = false;
        update();
      } catch (e) {
        isLoader = false;
        update();
        print(e.toString());
        snackBar(context, e.toString(), Colors.pink);
      }
    }
  }

  Future getImage(BuildContext context, ImageSource imageSource) async {
    try {
      XFile? imagePick = await ImagePicker().pickImage(source: imageSource);

      if (imagePick != null) {
        File convertedFile = File(imagePick.path);
        file = convertedFile;
        selectedImagePath = imagePick.path;
        pickImagestatus = false;
        /*      await uploadProfile(context);*/
        update();
      } else {
        return;
      }
    } on PlatformException catch (e) {
      log(e.toString());
    }
  }

  //upload the profile image to the firebase storage
  Future uploadProfile(BuildContext context) async {
    User user = FirebaseAuth.instance.currentUser!;
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child('profilePic')
        .child(user.uid)
        .putFile(file!);

    StreamSubscription listenEvent = uploadTask.snapshotEvents.listen((data) {
      percentage = (data.bytesTransferred / data.totalBytes);
      update();
      if (data.state == TaskState.success) {
        percentage = null;
        log(" uploading image succesffully");
        update();
        log('Our image uploading done');
      }
      log('This is our uploading image task : ${percentage.toString()}');
    });

    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    listenEvent.cancel();
    Get.find<GetSTorageController>().box.write(kImageUrl, downloadUrl);
    log(downloadUrl);
    //upload the data
    // await FirebaseFirestore.instance.collection('users').doc(user.uid).update(({
    //       'profilePic': downloadUrl,
    //     }));
  }
}
