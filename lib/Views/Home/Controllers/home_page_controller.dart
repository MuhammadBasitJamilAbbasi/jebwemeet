import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Models/UserModel.dart';
import 'package:jabwemeet/Models/chatroom.model.dart';
import 'package:jabwemeet/Models/likes_model.dart';
import 'package:uuid/uuid.dart';

class Home_page_controller extends GetxController {
  String? selectedMartialStatus = "Select Status";
  String? selectedReligion = "Select Religion";
  String? selectedCaste = "Select Caste";
  String? selectedCity = "Select City";
  var lowerValue = 18.0.obs;
  var upperValue = 60.0.obs;
  Stream<QuerySnapshot<Map<String, dynamic>>> queryValue = FirebaseFirestore
      .instance
      .collection("users")
      .where("age", isGreaterThanOrEqualTo: 18)
      .snapshots();
  UserModel userModel = UserModel();

  getUserDetails() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      userModel = UserModel.fromMap(value.data()!);
      update();
      log(userModel.gender.toString());
    });
    if (userModel.gender.toString() == "Man") {
      gender = "Female";
      update();
    }
    if (userModel.gender.toString() == "Female") {
      gender = "Man";
      update();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserDetails();
  }

  clearAll(BuildContext context) {
    selectedMartialStatus = "Select Status";
    selectedReligion = "Select Religion";
    selectedCaste = "Select Caste";
    selectedCity = "Select City";
    lowerValue.value = 18.0;
    upperValue.value = 70.0;
    filterMartialStatus = null;
    filterReligion = null;
    filterCaste = null;
    filterCity = null;
    filterlowerValue = 18.0;
    filterupperValue = 70.0;
    update();
    snackBar(context, "Filters Clear", Colors.pink);
  }

  String? filterMartialStatus = null;
  String? filterReligion = null;
  String? filterCaste = null;
  String? filterCity = null;
  var filterlowerValue = 18.0;
  var filterupperValue = 70.0;
  String? gender = "Man";
  query() {
    if (filterMartialStatus == "Select Status" ||
        filterReligion == "Select Religion" ||
        filterCaste == "Select Caste" ||
        filterCity == "Select City") {
      filterMartialStatus = null;
      filterReligion = null;
      gender = "Female";
      filterCaste = null;
      filterCity = null;
      update();
    }

    queryValue = FirebaseFirestore.instance
        .collection("users")
        .where("age", isGreaterThanOrEqualTo: filterlowerValue.round())
        .where("age", isLessThanOrEqualTo: filterupperValue.round())
        .where("gender", isEqualTo: gender)
        .where("martial_status", isEqualTo: filterMartialStatus)
        .where("address", isEqualTo: filterCity)
        .where("religion", isEqualTo: filterReligion)
        .snapshots();
    update();
    log("in Query Check gender " + gender.toString());
    return queryValue;
  }

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

  Future<ChatRoomModel?> getchatRoom(
      var opponent_id, BuildContext context) async {
    ChatRoomModel chatRoom = ChatRoomModel();
    User? user = FirebaseAuth.instance.currentUser;
    QuerySnapshot snapshotData = await FirebaseFirestore.instance
        .collection('chatrooms')
        .where('participants.${user!.uid}', isEqualTo: true)
        .where('participants.${opponent_id}', isEqualTo: true)
        .get();
    QuerySnapshot likesdata = await FirebaseFirestore.instance
        .collection('likes')
        .where('participants.${user.uid}', isEqualTo: true)
        .where('participants.${opponent_id}', isEqualTo: true)
        .get();
    if (likesdata.docs.length > 0) {
      if (snapshotData.docs.length > 0) {
        var chatRoomData = snapshotData.docs[0].data();
        ChatRoomModel exisitingChatRoom =
            ChatRoomModel.fromMap(chatRoomData as Map<String, dynamic>);

        chatRoom = exisitingChatRoom;

        log('you have already a chatromm');
      } else {
        ChatRoomModel newChatRoom = ChatRoomModel(
            chatRoomId: Uuid().v1(),
            typing: [],
            participants: {
              user.uid: true,
              opponent_id: true,
            },
            isReadSender: true,
            isReadReceiver: false,
            lastMessage: '',
            lastMesgUserId: FirebaseAuth.instance.currentUser!.uid.toString());
        await FirebaseFirestore.instance
            .collection('chatrooms')
            .doc(newChatRoom.chatRoomId)
            .set(newChatRoom.toMap());
        chatRoom = newChatRoom;
        log('Hurrah!new chat room created!');
      }
    } else {
      snackBar(context, "You don't match each other", Colors.pink);
    }
    return chatRoom;
  }

  Future<LikesModel?> getLikes(var opponent_id, BuildContext context) async {
    LikesModel likesModel = LikesModel();
    User? user = FirebaseAuth.instance.currentUser;
    QuerySnapshot snapshotData = await FirebaseFirestore.instance
        .collection('likes')
        .where("isSender", isEqualTo: opponent_id)
        .where("isReceiver", isEqualTo: user!.uid)
        .get();
    if (snapshotData.docs.length > 0) {
      QuerySnapshot like = await FirebaseFirestore.instance
          .collection('likes')
          .where("isSender", isEqualTo: opponent_id)
          .where("isReceiver", isEqualTo: user.uid)
          .where('participants.${user.uid}', isEqualTo: true)
          .get();
      if (like.docs.length > 0) {
        log("unlike");
        like.docs.forEach((element) async {
          await FirebaseFirestore.instance
              .collection('likes')
              .doc(element.id)
              .update({
            'participants.${user.uid}': false,
          });
          snackBar(context, "You unlike the profile", Colors.pink);
        });
      } else {
        QuerySnapshot like = await FirebaseFirestore.instance
            .collection('likes')
            .where("isSender", isEqualTo: opponent_id)
            .where("isReceiver", isEqualTo: user.uid)
            .where('participants.${user.uid}', isEqualTo: false)
            .get();
        if (like.docs.length > 0) {
          log("unlike");
          like.docs.forEach((element) async {
            await FirebaseFirestore.instance
                .collection('likes')
                .doc(element.id)
                .update({
              'participants.${user.uid}': true,
            });
            snackBar(context, "You like the profile", Colors.pink);
          });
        } else {
          QuerySnapshot likeda = await FirebaseFirestore.instance
              .collection('likes')
              .where("isSender", isEqualTo: user.uid)
              .where("isReceiver", isEqualTo: opponent_id)
              .where('participants.${user.uid}', isEqualTo: true)
              .get();
          if (likeda.docs.length > 0) {
            log("unlike");
            likeda.docs.forEach((element) async {
              await FirebaseFirestore.instance
                  .collection('likes')
                  .doc(element.id)
                  .update({
                'participants.${user.uid}': false,
              });
              snackBar(context, "You unlike the profile", Colors.pink);
            });
          } else {
            QuerySnapshot likeda = await FirebaseFirestore.instance
                .collection('likes')
                .where("isSender", isEqualTo: user.uid)
                .where("isReceiver", isEqualTo: opponent_id)
                .where('participants.${user.uid}', isEqualTo: false)
                .get();
            likeda.docs.forEach((element) async {
              log("like back");
              await FirebaseFirestore.instance
                  .collection('likes')
                  .doc(element.id)
                  .update({
                'participants.${user.uid}': true,
              });
              snackBar(context, "You like the profile", Colors.pink);
            });
          }
        }
      }
      var likesData = snapshotData.docs[0].data();
      LikesModel exisitingLikesdata =
          LikesModel.fromMap(likesData as Map<String, dynamic>);

      likesModel = exisitingLikesdata;

      log('you have already a likes data');
    } else {
      QuerySnapshot snapshotData = await FirebaseFirestore.instance
          .collection('likes')
          .where("isSender", isEqualTo: user.uid)
          .where("isReceiver", isEqualTo: opponent_id)
          .get();
      if (snapshotData.docs.length > 0) {
        QuerySnapshot like = await FirebaseFirestore.instance
            .collection('likes')
            .where("isSender", isEqualTo: opponent_id)
            .where("isReceiver", isEqualTo: user.uid)
            .where('participants.${user.uid}', isEqualTo: true)
            .get();
        if (like.docs.length > 0) {
          log("unlike");
          like.docs.forEach((element) async {
            await FirebaseFirestore.instance
                .collection('likes')
                .doc(element.id)
                .update({
              'participants.${user.uid}': false,
            });
            snackBar(context, "You unlike the profile", Colors.pink);
          });
        } else {
          QuerySnapshot like = await FirebaseFirestore.instance
              .collection('likes')
              .where("isSender", isEqualTo: opponent_id)
              .where("isReceiver", isEqualTo: user.uid)
              .where('participants.${user.uid}', isEqualTo: false)
              .get();
          if (like.docs.length > 0) {
            log("unlike");
            like.docs.forEach((element) async {
              await FirebaseFirestore.instance
                  .collection('likes')
                  .doc(element.id)
                  .update({
                'participants.${user.uid}': true,
              });
              snackBar(context, "You like the profile", Colors.pink);
            });
          } else {
            QuerySnapshot likeda = await FirebaseFirestore.instance
                .collection('likes')
                .where("isSender", isEqualTo: user.uid)
                .where("isReceiver", isEqualTo: opponent_id)
                .where('participants.${user.uid}', isEqualTo: true)
                .get();
            if (likeda.docs.length > 0) {
              log("unlike");
              likeda.docs.forEach((element) async {
                await FirebaseFirestore.instance
                    .collection('likes')
                    .doc(element.id)
                    .update({
                  'participants.${user.uid}': false,
                });
                snackBar(context, "You unlike the profile", Colors.pink);
              });
            } else {
              QuerySnapshot likeda = await FirebaseFirestore.instance
                  .collection('likes')
                  .where("isSender", isEqualTo: user.uid)
                  .where("isReceiver", isEqualTo: opponent_id)
                  .where('participants.${user.uid}', isEqualTo: false)
                  .get();
              likeda.docs.forEach((element) async {
                log("like back");
                await FirebaseFirestore.instance
                    .collection('likes')
                    .doc(element.id)
                    .update({
                  'participants.${user.uid}': true,
                });
                snackBar(context, "You like the profile", Colors.pink);
              });
            }
          }
        }
        var likesData = snapshotData.docs[0].data();
        LikesModel exisitingLikesdata =
            LikesModel.fromMap(likesData as Map<String, dynamic>);

        likesModel = exisitingLikesdata;

        log('you have already a likes data');
      } else {
        LikesModel newLikeCollection = LikesModel(
          likeId: Uuid().v1(),
          participants: {
            user.uid: true,
            opponent_id: false,
          },
          isSender: user.uid,
          isReceiver: opponent_id,
        );
        await FirebaseFirestore.instance
            .collection('likes')
            .doc(newLikeCollection.likeId)
            .set(newLikeCollection.toMap());
        likesModel = newLikeCollection;

        log('likes created');
      }

      return likesModel;
    }
  }
}
