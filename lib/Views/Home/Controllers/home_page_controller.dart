import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Models/UserModel.dart';
import 'package:jabwemeet/Models/chatroom.model.dart';
import 'package:jabwemeet/Models/likes_model.dart';
import 'package:jabwemeet/Utils/locations.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Home/Screens/Likes/LIke.dart';
import 'package:uuid/uuid.dart';

import '../../../Services/notification/notification_api/notification_api.dart';

class Home_page_controller extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getUserDetails();
    await getData();
  }

  int selectedIndex = 0;
  String? selectedMartialStatus = "Select Status";
  String? selectedReligion = "Select Religion";
  String? selectedCaste = "Select Caste";
  String? selectedCity = "Select City";
  var lowerValue = 18.0.obs;
  var upperValue = 60.0.obs;
  String? gender = "";
  Stream<QuerySnapshot<Map<String, dynamic>>>? queryValue;
  UserModel userModel = UserModel();

  List<QueryDocumentSnapshot> userList = [];
  final storageController = Get.find<GetSTorageController>();
  Future getData() async {
    userList.clear();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('visits')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        visitedList!.add(element.id);
        update();
      });
      print("VisitedList1:  " + visitedList!.length.toString());
    });
    await FirebaseFirestore.instance
        .collection("users")
        .limit(50)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {
        if (visitedList!.contains(element.id) == false) {
          if (element.get('age') >= filterlowerValue.round() &&
                  element.get('gender') == gender &&
                  element.get('age') < filterupperValue.round() ||
              element.get('martial_status') == filterMartialStatus ||
              element.get('address') == filterCity ||
              element.get('religion') == filterReligion) {
            double datainMeter = GetLocation.DistanceInMeters(
                double.parse(element.get('latitude')),
                double.parse(element.get('longitude')),
                double.parse(userModel.latitude.toString()),
                double.parse(userModel.longitude.toString()));
            print("datainMeter: " + datainMeter.toString());
            print("selectedMilesRangeDefault: " +
                selectedMilesRangeDefault.toString());
            if (datainMeter < selectedMilesRangeDefault) {
              if (userList.contains(element.id) == true) {
                userList.remove(element);
                update();
                print("remove element");
              } else {
                userList.add(element);
                update();
                print("Add element");
              }
            }
          }
        }
      });
      update();
      print("Length: " + userList.length.toString());
    });
    return userList;
  }

  List<String>? visitedList = [];
  getUserDetails() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      userModel = UserModel.fromMap(value.data()!);
      update();
      if (userModel.gender.toString() == "Man") {
        gender = "Woman";
        update();
        print("Woman=" + gender.toString());
      }
      if (userModel.gender.toString() == "Woman") {
        gender = "Man";
        update();
        print("Man" + gender.toString());
      }
      log(userModel.gender.toString());
      log("Init Call Start");
      log(gender.toString());
      queryValue = FirebaseFirestore.instance
          .collection("users")
          .where("age", isGreaterThanOrEqualTo: 18)
          .where("gender", isEqualTo: gender)
          .snapshots();
      log("Init Call End");
    });
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
    filterlowerValueMiles = 300.0;
    filterupperValueMiles = 700.0;
    selectedMilesRange = 500.0;
    selectedMilesRangeDefault = 2490000.0;
    update();
    snackBar(context, "Filters Clear", Colors.pink);
  }

  var selectedMilesRange = 500.0;
  var selectedMilesRangeDefault = 2490000.0;
  selectedMilesRangeFunction(value) {
    selectedMilesRange = value;
    selectedMilesRangeDefault = value;
    update();
  }

  String? filterMartialStatus = null;
  String? filterReligion = null;
  String? filterCaste = null;
  String? filterCity = null;
  var filterlowerValue = 18.0;
  var filterupperValue = 70.0;
  var filterlowerValueMiles = 300.0;
  var filterupperValueMiles = 700.0;
  query() async {
    if (filterMartialStatus == "Select Status" ||
        filterReligion == "Select Religion" ||
        filterCaste == "Select Caste" ||
        filterCity == "Select City") {
      filterMartialStatus = null;
      filterReligion = null;
      gender = "Woman";
      filterCaste = null;
      filterCity = null;
      update();
    }
    log("in Query Check gender " + gender.toString());
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

  Future<LikesModel?> getLikes({
    required var opponent_id,
    required var fcm_token,
    required BuildContext context,
    required isSenderImage,
    required isSenderName,
    required isRecImage,
    required isRecName,
  }) async {
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
            Get.to(() => LikesView());
            /*Code Added By Kamran*/
            bool isNotificationSet = await NotificationApiHitting()
                .callOnFcmApiSendPushNotifications(
              fcmToken: fcm_token,
              jwm_message: "Your Profile was Liked.",
            );
            if (isNotificationSet) {
              log("Notification Sent:");
            } else {
              log("Notification Not Sent:");
            }
            /*=========================*/
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
              Get.to(() => LikesView());
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
              Get.to(() => LikesView());
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
            isReceiverImage: isRecImage,
            isReceiverName: isRecName,
            isSenderImage: isSenderImage,
            isSenderName: isSenderName);
        await FirebaseFirestore.instance
            .collection('likes')
            .doc(newLikeCollection.likeId)
            .set(newLikeCollection.toMap());
        likesModel = newLikeCollection;
        log('likes created');
        Get.to(() => LikesView());
      }

      return likesModel;
    }
  }
}
