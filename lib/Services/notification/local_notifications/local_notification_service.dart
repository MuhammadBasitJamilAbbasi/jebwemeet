import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../../Views/Home/Screens/Likes/Likes_screens.dart';

//<==========Api Implementation==========>
class LocalNotificationApiImplementation {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    // initializationSettings  for Android
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"),
            iOS: IOSInitializationSettings(
              requestAlertPermission: true,
              requestBadgePermission: true,
              requestSoundPermission: true,
            ));

    _notificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? message) async {
        log("Inside onSelectNotification");
        if (message!.isNotEmpty) {
          log("Message is $message");
          Get.to(() => LikesView());
        }
      },
    );
  }

  //Create Channel
  static void createAndDisplayNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "Jab We Meet",
          "jwm_mobile_channel",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['jwm_message'],
      );
    } on Exception catch (e) {
      log("<========== Exception Caught ==========>");
      log(e.toString());
    }
  }
}
