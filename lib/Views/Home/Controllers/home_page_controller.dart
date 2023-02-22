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
import 'package:jabwemeet/Views/Home/Screens/Home/match_screen.dart';
import 'package:jabwemeet/Views/Home/Screens/Likes/LIke.dart';
import 'package:uuid/uuid.dart';

import '../../../Services/notification/notification_api/notification_api.dart';

class Home_page_controller extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getUserDetails();
    // await getData();
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
  bool homeLoader=false;
  List<QueryDocumentSnapshot> userList = [];
  final storageController = Get.find<GetSTorageController>();
  Future getData() async {
    userList.clear();
    homeLoader=true;
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
        if(element.get('age')!=null || element.get('gender')!=null) {
          if (visitedList!.contains(element.id) == false) {
            log(element.get('age').toString() + " == " +
                filterlowerValue.round().toString());
            log(element.get('gender').toString() + " == " + gender.toString());
            log(element.get('age').toString() + " == " +
                filterupperValue.round().toString());
            log(element.get('martial_status').toString() + " == " +
                filterMartialStatus.toString());
            log(element.get('religion').toString() + " == " +
                filterReligion.toString());
            homeLoader=false;
            update();
            if(filterReligion==null){
              filterReligion= element.get('religion');
              update();
            }
            if (element.get('age') >= filterlowerValue.round() &&
                element.get('gender') == gender &&
                element.get('age') < filterupperValue.round() &&
                // element.get('martial_status') == filterMartialStatus &&
                element.get('religion') == filterReligion) {
              double datainMeter = GetLocation.DistanceInMeters(
                  double.parse(element.get('latitude').toString()),
                  double.parse(element.get('longitude').toString()),
                  double.parse(userModel.latitude.toString()),
                  double.parse(userModel.longitude.toString()));
              double kilomter = datainMeter / 1000;
              print("datainMeter: " + datainMeter.toString());
              print("datainKiloMeter: " + kilomter.toString());
              print("selectedMilesRangeDefault: " +
                  selectedMilesRangeDefault.toString());
              if (kilomter < selectedMilesRangeDefault) {
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
      if (userModel.gender.toString() == "Male") {
        gender = "Female";
        update();
        print("Female=" + gender.toString());
      }
      if (userModel.gender.toString() == "Female") {
        gender = "Male";
        update();
        print("Male" + gender.toString());
      }
      log(userModel.gender.toString());
      log("Init Call Start");
      log(gender.toString());
      // queryValue = FirebaseFirestore.instance
      //     .collection("users")
      //     .where("age", isGreaterThanOrEqualTo: 18)
      //     .where("gender", isEqualTo: gender)
      //     .snapshots();
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
      gender = "Female";
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
    QuerySnapshot likelist = await FirebaseFirestore.instance
        .collection('likes')
        .get();
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
          // snackBar(context, "You unlike the profile", Colors.pink);
        });
      } else {
        QuerySnapshot like = await FirebaseFirestore.instance
            .collection('likes')
            .where("isSender", isEqualTo: opponent_id)
            .where("isReceiver", isEqualTo: user.uid)
            .where('participants.${user.uid}', isEqualTo: false)
            .get();
        if (like.docs.length > 0) {
          like.docs.forEach((element) async {
            await FirebaseFirestore.instance
                .collection('likes')
                .doc(element.id)
                .update({
              'participants.${user.uid}': true,
            });
            Get.to(() => MatchScreen(
              opponent_image: isRecImage ,
              opponent_id: opponent_id,
              opponent_name: isRecName,
              userid:user.uid ,
              user_image: isSenderImage,
              username: isSenderName,));
            /*Code Added By Kamran*/
            print("First");
            bool isNotificationSet = await NotificationApiHitting()
                .callOnFcmApiSendPushNotifications(
              fcmToken: fcm_token,
              jwm_message: "$isSenderName like your profile.",
            );
            if (isNotificationSet) {
              log("Notification Sent:");
            } else {
              log("Notification Not Sent:");
            }
            /*=========================*/
            // snackBar(context, "You like the profile", Colors.pink);
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
              // snackBar(context, "You unlike the profile", Colors.pink);
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
              Get.to(() => MatchScreen(
                opponent_image: isRecImage ,
                opponent_id: opponent_id,
                opponent_name: isRecName,
                userid:user.uid ,
                user_image: isSenderImage,
                username: isSenderName,));
              print("second");// snackBar(context, "You like the profile", Colors.pink);
              bool isNotificationSet = await NotificationApiHitting()
                  .callOnFcmApiSendPushNotifications(
                fcmToken: fcm_token,
                jwm_message: "$isSenderName like your profile.",
              );
              if (isNotificationSet) {
                log("Notification Sent:");
              } else {
                log("Notification Not Sent:");
              }
            });
          }
        }
      }
      var likesData = snapshotData.docs[0].data();
      LikesModel exisitingLikesdata =
          LikesModel.fromMap(likesData as Map<String, dynamic>);

      likesModel = exisitingLikesdata;

      log('you have already a likes data');
    }
    else {
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
            // snackBar(context, "You unlike the profile", Colors.pink);
          });
        } else {
          QuerySnapshot like = await FirebaseFirestore.instance
              .collection('likes')
              .where("isSender", isEqualTo: opponent_id)
              .where("isReceiver", isEqualTo: user.uid)
              .where('participants.${user.uid}', isEqualTo: false)
              .get();
          if (like.docs.length > 0) {
            log("true");
            like.docs.forEach((element) async {
              await FirebaseFirestore.instance
                  .collection('likes')
                  .doc(element.id)
                  .update({
                'participants.${user.uid}': true,
              });
              Get.to(() =>
                  MatchScreen(
                    opponent_image: isRecImage,
                    opponent_id: opponent_id,
                    opponent_name: isRecName,
                    userid: user.uid,
                    user_image: isSenderImage,
                    username: isSenderName,));
              // snackBar(context, "You like the profile", Colors.pink);
              print("Third");
              bool isNotificationSet = await NotificationApiHitting()
                  .callOnFcmApiSendPushNotifications(
                fcmToken: fcm_token,
                jwm_message: "$isSenderName like your profile.",
              );
              if (isNotificationSet) {
                log("Notification Sent:");
              } else {
                log("Notification Not Sent:");
              }
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
                // snackBar(context, "You unlike the profile", Colors.pink);
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
                // snackBar(context, "You like the profile", Colors.pink);
              });
            }
          }
        }
        var likesData = snapshotData.docs[0].data();
        LikesModel exisitingLikesdata =
        LikesModel.fromMap(likesData as Map<String, dynamic>);
        likesModel = exisitingLikesdata;
        log('you have already a likes data');
      }
      else {
        LikesModel newLikeCollection = LikesModel(
            likeId: (likelist.size+1).toString(),
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
        // Get.to(() => LikesView());
        print("Fourth");
        bool isNotificationSet = await NotificationApiHitting()
            .callOnFcmApiSendPushNotifications(
          fcmToken: fcm_token,
          jwm_message: "$isSenderName like your profile.",
        );
        if (isNotificationSet) {
          log("Notification Sent:");
        } else {
          log("Notification Not Sent:");
        }
      }
      return likesModel;
    }
  }

  Future ignorswap({opponent_user,})async{
    print(userList
        .length
        .toString());
    print(
        "Remove tap");
    await FirebaseFirestore
        .instance
        .collection(
        "users")
        .doc(userModel
        .uid)
        .collection(
        "visits")
        .doc(opponent_user
        .uid
        .toString())
        .set({
      "uid": opponent_user
          .uid
          .toString()
    });
  }
  Future addtofavourite({required UserModel opponent_user}) async{
    await FirebaseFirestore
        .instance
        .collection(
        "users")
        .doc(userModel
        .uid)
        .collection(
        "favourites")
        .doc(opponent_user
        .uid
        .toString())
        .set({
      "uid": opponent_user
          .uid
          .toString(),
      "image": opponent_user.imageUrl,
      "name":opponent_user.name

    }).then((value) => print("Add to favourite"));
  }
  Future removefavourite({ opponent_user}) async{
    await FirebaseFirestore
        .instance
        .collection(
        "users")
        .doc(userModel
        .uid)
        .collection(
        "favourites")
        .doc(opponent_user)
        .delete();
  }
  Future likeswap(BuildContext context,{opponent_user}) async{
    log("Like TAp");
     await
        getLikes(
        opponent_id: opponent_user
            .uid
            .toString(),
        fcm_token: opponent_user
            .fcm_token
            .toString(),
        context:
        context,
        isSenderImage: userModel
            .imageUrl
            .toString(),
        isSenderName: userModel
            .name
            .toString(),
        isRecImage: opponent_user
            .imageUrl
            .toString(),
        isRecName: opponent_user
            .name
            .toString())
        .then(
            (value) async {
          print("Remove tap");
         ignorswap(opponent_user:opponent_user );
         // getData();
        });
  }

}
