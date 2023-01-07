import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class Services {
  /*Notification Services*/
  //Add Notification
  addNotification({
    required String senderName,
    required String senderId,
    required String userImage,
    required String message,
    required String receiverUserID,
    required String time,
    required bool isRead,
    required String type,
  }) async {
    try {
      log("Inside Try Statement:");
      await FirebaseFirestore.instance
          .collection('users')
          .doc(receiverUserID)
          .collection("notifications")
          .add({
        "sender_name": senderName,
        "sender_user_id": senderId,
        "userImage": userImage,
        "message": message,
        "receiverUserID": receiverUserID,
        "time": time,
        "isRead": false,
        "type": type,
      });
      log(
        "Notification Alert Created",
      );
    } on FirebaseException catch (ex) {
      log("Inside Catch Statement: ");
      log("Error is ${ex.code}.");
    }
  }

  readNotification(
      {required String receiverUserID, required String notificationId}) async {
    try {
      log("Inside Try Statement:");
      await FirebaseFirestore.instance
          .collection('users')
          .doc(receiverUserID)
          .collection("notifications")
          .doc(notificationId)
          .update({
        "isRead": true,
      });
      log("Notification is Read.");
    } on FirebaseException catch (ex) {
      log("Inside Catch Statement: ");
      log("Error is ${ex.code}.");
    }
  }

  Stream<QuerySnapshot> getNotification({required String userId}) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection("notifications")
        .where("isRead", isEqualTo: false)
        .snapshots();
  }

  readAllNotifications({required String userId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection("notifications")
        .where("isRead", isEqualTo: false)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
      snapshot.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection("notifications")
            .doc(element.id)
            .update({"isRead": true});
      });
    });
  }

/*Notifications Services End*/
}
