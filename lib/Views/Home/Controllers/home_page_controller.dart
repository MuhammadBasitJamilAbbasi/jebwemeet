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
import 'package:jabwemeet/Views/Home/Screens/Home/new_home_swapable.dart';
import 'package:jabwemeet/Views/Home/Screens/Likes/Likes_screens.dart';
import 'package:jabwemeet/testing_sub.dart';
import 'package:uuid/uuid.dart';

import '../../../Services/notification/notification_api/notification_api.dart';
import 'package:jabwemeet/Utils/constants.dart';

class Home_page_controller extends GetxController {

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getUserDetails();
    // await getData();
  }
bool purchasekar=false;
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
    visitedList!.clear();
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
        .get()
        .then((snapshot) async{
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('visits').where("date",isEqualTo: Timestamp.fromDate(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)))
          .get().then((value)  {
            if(appData.entitlementIsActive==false && value.size>=25){
              print("aj ky visits: ${value.size} ");
              purchasekar=true;
              update();
            }
            else{
              purchasekar=false;
              update();
              snapshot.docs.forEach((element) {
                if(element.get('age')!=null || element.get('gender')!=null) {
                  if (visitedList!.contains(element.id) == false) {
                    // if(filterReligion==null && element.get('age') >= filterlowerValue.round() &&
                    //     element.get('gender') == gender &&
                    //     element.get('age') < filterupperValue.round()){
                    //   filterReligion= element.get('religion');
                    //   update();
                    // }
                    filterReligion= element.get('religion');
                    filterMartialStatus= element.get('martial_status');
                    update();
                    if (element.get('age') >= filterlowerValue.round() &&
                        element.get('gender') == gender &&
                        element.get('martial_status') == filterMartialStatus &&
                        element.get('age') < filterupperValue.round() &&
                        element.get('religion') == filterReligion) {

                      double datainMeter = GetLocation.DistanceInMeters(
                          double.parse(element.get('latitude').toString()=="null"? "0" : element.get('latitude').toString() ),
                          double.parse(element.get('longitude').toString()=="null"?"0": element.get('longitude').toString() ),
                          double.parse(userModel.latitude.toString()),
                          double.parse(userModel.longitude.toString()));
                      double kilomter = datainMeter / 1000;

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
              homeLoader=false;
              update();
              print("Length: " + userList.length.toString());
            }
      });

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
  }

  var selectedMilesRange = 0.0;
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

  Future<ChatRoomModel?> getchatRoomPremium(
      var opponent_id, BuildContext context) async {
    ChatRoomModel chatRoom = ChatRoomModel();
    User? user = FirebaseAuth.instance.currentUser;
    QuerySnapshot snapshotData = await FirebaseFirestore.instance
        .collection('chatrooms')
        .where('participants.${user!.uid}', isEqualTo: true)
        .where('participants.${opponent_id}', isEqualTo: true)
        .get();
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
    required isReceiverAddress,
    required int isReceiverAge,
    required isSenderAddress,
    required int isSenderAge,
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
              opponent_address:isReceiverAddress ,
              opponent_age: isReceiverAge,
              user_address: isSenderAddress,
              user_age: isSenderAge,
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
                opponent_address:isReceiverAddress ,
                opponent_age: isReceiverAge,
                user_address: isSenderAddress,
                user_age: isSenderAge,
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
                    opponent_age: isReceiverAge,
                    user_address: isSenderAddress,
                    user_age: isSenderAge,
                    opponent_address: isReceiverAddress,
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
            isReceiverAddress: isReceiverAddress,
            isReceiverAge: isReceiverAge,
            isSenderAddress:isSenderAddress ,
            isSenderAge:isSenderAge ,
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
    // getData();
    // update();
  }

  Future ignorswap({required UserModel opponent_user,required String visitType})async{
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
          .toString(),
      "date": Timestamp.fromDate(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)),
      "image":opponent_user.imageUrl,
      "name":opponent_user.name,
      "visitType":visitType
    });
    // getData();
    // update();
  }
  Future block({required opponent_userid,name,image,required String visitType})async{
    await FirebaseFirestore
        .instance
        .collection(
        "users")
        .doc(userModel
        .uid)
        .collection(
        "visits")
        .doc(opponent_userid)
        .set({
      "uid":opponent_userid,
      "image":image,
      "date": Timestamp.fromDate(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)),
      "name":name,
      "visitType":visitType
    });
    // getData();
    // update();
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
  Future removeLiked({ opponent_user}) async{
    await FirebaseFirestore
        .instance
        .collection(
        "users")
        .doc(userModel
        .uid)
        .collection(
        "visits")
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
        isSenderAge: userModel.age!,
        isSenderAddress: userModel.address,
        isReceiverAge: opponent_user.age,
        isReceiverAddress: opponent_user.address,
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
         ignorswap(opponent_user:opponent_user,visitType: "like" );
         // getData();
        });
  }

}
