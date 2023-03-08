import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Models/Hobbies_Model.dart';
import 'package:jabwemeet/Models/UserModel.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';
import 'package:jabwemeet/Views/Home/Screens/Profile/Edit_Profile.dart';

class EditProfileController extends GetxController {
  EditProfileController({required this.userModel});
  UserModel userModel;
  bool isBlured = false;
  blurFunction(bool value)async {
    isBlured = value;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userModel.uid)
        .update({
      'blur': value,
    });
    update();
  }


  final storage=Get.find<GetSTorageController>();
  TextEditingController nameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController jobtitleController = TextEditingController();
  String? selectedMartialStatus = "Select Status";
  String? selectedReligion = "Sunni";
  String? selectedPractisingStatus = "Very Practising";
  String? selectedCaste = "Abbasi";
  String? selectedCity = "Islamabad";

  var selectedImagePath = "";
  bool isLoader = false;
  bool isImageLoading = false;
  ImagePicker imagePicker = ImagePicker();
  File? file;
  double? percentage;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nameController.text = userModel.name.toString();
    aboutController.text = userModel.about.toString();
    jobtitleController.text = userModel.job_title.toString();
    selectedMartialStatus = userModel.martial_status.toString();
    Get.find<RegisterController>().selectedChild = userModel.childerns.toString();
    selectedCaste = userModel.caste;
    selectedCity = userModel.address;
    selectedReligion = userModel.religion;
    isBlured=userModel.blur!;
    userModel.hobbies!.forEach((element) {
      getListt!.add(element);
    });

    multipleImagesDownloadLinks=userModel.imagesList;
    storage.box.write(kEducation, userModel.education);
    storage.box.write(kReligion, userModel.religion);
    storage.box.write(kMartial_Statius, userModel.martial_status);
    storage.box.write(kchildern, userModel.childerns);
    storage.box.write(kCaste, userModel.caste);
    storage.box.write(kAddress, userModel.address);
    storage.box.write(kReligiousPractice, userModel.religious_practice);
  }
  selectedPractisingFunction(String? value) {
    selectedPractisingStatus = value;
    storage.box.write(kReligiousPractice, value);
    update();
  }
  selectedMartialFunction(String? value) {
    selectedMartialStatus = value;
    update();
  }

  selectedCityFunction(String? value) {
    selectedCity = value;
    storage.box.write(kAddress, value);
    update();
  }

  selectedReligionFunction(String? value) {
    selectedReligion = value;
    storage.box.write(kReligion, value);
    update();
  }

  selectedCasteFunction(String? value) {
    selectedCaste = value;
    storage.box.write(kCaste, value);
    update();
  }

  List<InterestModel>? getListt = [];
  List<Map<String, dynamic>> interestsList = [];
  //add topics to the list
  void addTopics(InterestModel topics) {
    if(getListt!.isEmpty){
      getListt!.add(topics);
      update();
    }
    else {
      getListt!.add(topics);
      update();
    }
  }
  void removeTopics(InterestModel topics) {
    getListt!.remove(topics);
    update();
  }

  sendInteresetList(){
    print(getListt!.toString());
    for (var i in getListt!) {
      interestsList.add({
        'image': i.image,
        'title': i.title,
      });
    }
  }
//----------->//
  updateProfile(BuildContext context,{required parameter,required value}) async {
    User? user = FirebaseAuth.instance.currentUser!;
    try {
      isLoader = true;
      update();
      // await uploadProfile(context).then((value) async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .update({
        parameter: value,
      }).then((value) {
         Get.back();
      });
      isLoader = false;
      update();
    } catch (e) {
      isLoader = false;
      update();
      snackBar(context, e.toString(), Colors.pink);
    }
  }

  //------------->//

//----------->//

  Future getImage(BuildContext context) async {
    try {
      XFile? imagePick =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imagePick != null) {
        File convertedFile = File(imagePick.path);
        file = convertedFile;
        selectedImagePath = imagePick.path;
        await uploadProfile(context).then((value) async {
          // await uploadProfile(context).then((value) async {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({
            "imageUrl": Get.find<GetSTorageController>().box.read(kImageUrl),
          });
        });
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

    StreamSubscription listenEvent =
        uploadTask.snapshotEvents.listen((data) async {
      percentage = (data.bytesTransferred / data.totalBytes);
      update();
      if (data.state == TaskState.success) {
        percentage = null;
        snackBar(
          context,
          'Profile image uploaded successfully',
          butoncolor,
        );
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
  }


  List<XFile> filesImages = [];
  List<dynamic>? multipleImagesDownloadLinks = [];
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
  // createPostController.images
  //     .addAll(files.map((e) => File(e.path)).toList());

  removepic(index,userid)async{
    multipleImagesDownloadLinks!.remove(index);
    update();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userid)
        .update({
      "imagesList": multipleImagesDownloadLinks,
    });

  }
  bool imagesss=false;
  Future<List?> uploadImages(BuildContext context) async {
    imagesss=true;
    update();
    // multipleImagesDownloadLinks = [];
    imagelistlength=filesImages.length;
    try {
      for(var img in filesImages){
        print(img);
        print(img.path);
        Reference ref;
        ref = FirebaseStorage.instance
            .ref()
            .child('profilePics')
            .child(img.path);
        await ref.putFile(File(img.path)).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            multipleImagesDownloadLinks!.add(value);
            debugPrint("multiple images are ${multipleImagesDownloadLinks.toString()}");

          });
        });
      }
      log(" uploading images succesffully");
      imagesss=false;
      update();
    } catch (e) {
      log(e.toString());
      log("Error in uploading images");
    }
    update();
    debugPrint("multiple images are ${multipleImagesDownloadLinks.toString()}");
    return multipleImagesDownloadLinks;
  }


}
