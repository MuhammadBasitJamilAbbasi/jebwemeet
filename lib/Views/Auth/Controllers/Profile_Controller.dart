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
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Home/Screens/Home/Home.dart';

class ProfileConytroller extends GetxController {
  TextEditingController workController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController casteController = TextEditingController();
  TextEditingController sportsController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController moviesController = TextEditingController();

  var selectedImagePath = "";
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

  List interestList = [];
  List addTopicsList = [];
  int? totalSelection = 0;
  int? topicsSelected;
  List usersInterest = [];

  Map<String, dynamic>? topic;

  bool isSelection(int index) {
    topicContents[index].isSeleted = !topicContents[index].isSeleted;
    update();
    return topicContents[index].isSeleted;
  }

  bool topicSelection(int index) {
    topicContents[index].isSeleted = !topicContents[index].isSeleted;
    update();
    return topicContents[index].isSeleted;
  }

  addToInterestList() {
    interestList.add(topicContents.length);
  }

  addTopicsToList(int index) {
    if (topicContents[index].isSeleted == true) interestList.add(topicContents);
    update();
  }

//Select the interest of the user
  bool userInterests(int index) {
    topicContents[index].isSeleted = !topicContents[index].isSeleted;
    update();
    return topicContents[index].isSeleted;
  }

  //add the interest to the user  profile
  addUserInterests() {
    topicContents.forEach((item) {
      if (item.isSeleted == true) {
        if (!usersInterest.contains(item.title)) {
          usersInterest.add(
            item.title,
          );
        }

        update();
      }
    });

    log(usersInterest.toString());
    return usersInterest;
  }

  //------------->//
  //topic view controller
  List<TopicModel> allTopics = topicsList;
  List<TopicModel> get topics => allTopics;

  List<TopicModel> selectedList = [];
  List<TopicModel> get selectedItems => selectedList;

  List<String> selectTitles = [];
  List<String> get getSelectedTitles => selectTitles;

  List<String> titleSelected = [];
  List<String> get getTitlesSelected => titleSelected;

  List<String> randomTitles = [];
  List<String> get getRandomTitles => randomTitles;
  List<String> getList = [];
  //add topics to the list
  void addTopics(TopicModel topics) {
    selectedList.add(topics);
    update();
    selectedList.forEach((element) {
      getList.add(element.title);
      update();
    });
    print(getList);
  }

  //remove topics from the list
  void removeTopics(TopicModel topics) {
    selectedList.remove(topics);
    update();
  }

  //add topics to the list
  void addTitles(TopicModel topics) {
    getTitlesSelected.add(topics.title);
    update();
  }

  //add topics to the list
  void removeTitles(TopicModel topics) {
    getTitlesSelected.remove(topics.title);
    update();
  }

//----------->//
  submitProfile(BuildContext context) async {
    if (file.toString() == "") {
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
    } else {
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
                Get.find<GetSTorageController>().box.read(kAbout).toString(),
            "education": Get.find<GetSTorageController>()
                .box
                .read(kEducation)
                .toString(),
            "height":
                Get.find<GetSTorageController>().box.read(kHeight).toString(),
            "hobbies": getList,
            "imageUrl":
                Get.find<GetSTorageController>().box.read(kImageUrl).toString(),
            "income":
                Get.find<GetSTorageController>().box.read(kIncome).toString(),
            "sports":
                Get.find<GetSTorageController>().box.read(kSports).toString(),
            "work": Get.find<GetSTorageController>().box.read(kWork).toString(),
            "movies":
                Get.find<GetSTorageController>().box.read(kMovies).toString()
          }).then((value) => Get.offAll(() => Home()));
        });

        isLoader = false;
        update();
      } catch (e) {
        isLoader = false;
        update();
        snackBar(context, e.toString(), Colors.pink);
      }
    }

    List interestList = [];
    List usersInterest = [];

    addToInterestList() {
      interestList.add(topicContents.length);
    }

    addTopicsToList(int index) {
      if (topicContents[index].isSeleted == true)
        interestList.add(topicContents);
      update();
    }

//Select the interest of the user
    bool userInterests(int index) {
      topicContents[index].isSeleted = !topicContents[index].isSeleted;
      update();
      return topicContents[index].isSeleted;
    }

    //add the interest to the user  profile
    addUserInterests() {
      topicContents.forEach((item) {
        if (item.isSeleted == true) {
          if (!usersInterest.contains(item.title)) {
            usersInterest.add(
              item.title,
            );
          }

          update();
        }
      });
      log(usersInterest.toString());
      return usersInterest;
    }

    //------------->//

//----------->//
  }

  Future getImage(BuildContext context) async {
    try {
      XFile? imagePick =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (imagePick != null) {
        File convertedFile = File(imagePick.path);
        file = convertedFile;
        selectedImagePath = imagePick.path;
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
