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
import 'package:jabwemeet/Models/UserModel.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';

class EditProfileController extends GetxController {
  EditProfileController({required this.userModel});
  UserModel userModel;
  bool isBlured = false;
  blurFunction(bool value) {
    isBlured = value;
    update();
  }

  TextEditingController nameController = TextEditingController();
  String? selectedMartialStatus = "Select Status";
  String? selectedReligion = "Select Religion";
  String? selectedCaste = "Select Caste";
  String? selectedCity = "Select City";
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
    selectedMartialStatus = userModel.martial_status.toString();
    selectedCaste = userModel.caste;
    selectedCity = userModel.address;
    selectedReligion = userModel.religion;
  }

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

//----------->//
  submitProfile(BuildContext context) async {
/*    if (file.toString() == "") {
      snackBar(context, "Please Select your image", Colors.pink);
    } else if (Get.find<GetSTorageController>().box.read(kAbout).toString() ==
            "" ||
        Get.find<GetSTorageController>().box.read(kAbout).toString() ==
            "null") {
      snackBar(context, "Please enter about", Colors.pink);
    } else if (Get.find<GetSTorageController>()
                .box
                .read(kEducation)
                .toString() ==
            "" ||
        Get.find<GetSTorageController>().box.read(kEducation).toString() ==
            "null") {
      snackBar(context, "Please Select your education level", Colors.pink);
    } else if (Get.find<GetSTorageController>().box.read(kIncome).toString() ==
            "" ||
        Get.find<GetSTorageController>().box.read(kIncome).toString() ==
            "null") {
      snackBar(context, "Please Enter your income", Colors.pink);
    } else if (Get.find<GetSTorageController>().box.read(kWork).toString() ==
            "" ||
        Get.find<GetSTorageController>().box.read(kWork).toString() == "null") {
      snackBar(context, "Please Enter your occupation sector", Colors.pink);
    } else if (Get.find<GetSTorageController>().box.read(kHeight).toString() ==
            "" ||
        Get.find<GetSTorageController>().box.read(kHeight).toString() ==
            "null") {
      snackBar(context, "Please Enter your Height", Colors.pink);
    } else if (Get.find<GetSTorageController>().box.read(kSports).toString() ==
            "" ||
        Get.find<GetSTorageController>().box.read(kSports).toString() ==
            "null") {
      snackBar(context, "Please add your sports", Colors.pink);
    } else if (Get.find<GetSTorageController>().box.read(kMovies).toString() ==
            "" ||
        Get.find<GetSTorageController>().box.read(kMovies).toString() ==
            "null") {
      snackBar(context, "Please add your movies", Colors.pink);
    } else {*/
    User? user = FirebaseAuth.instance.currentUser!;
    try {
      isLoader = true;
      update();
      // await uploadProfile(context).then((value) async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .update({
        "name": nameController.value.text,
        "martial_status": selectedMartialStatus,
        "religion": selectedReligion,
        "blur": isBlured,
        "caste": selectedCaste,
        "address": selectedCity
      }).then((value) => Get.back());

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

    //upload the data
    // await FirebaseFirestore.instance.collection('users').doc(user.uid).update(({
    //       'profilePic': downloadUrl,
    //     }));
  }
}
