import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../local_notifications/local_notification_service.dart';

/* It will contain remote message which which has message inside.
   It will handle the notification happening in background.
   Make it Global*/
Future<void> backgroundHandler(RemoteMessage message) async {
  log("Message Title is! ${message.notification!.title}");
  log("Message Body is! ${message.notification!.body}");
  log("Message Data is! ${message.data["jwm_message"]}");
}

class NotificationService {
  //initialize function
  static Future<void> initialize() async {
     
    log("Inside Notification Service: ");
    // Using this we will get the permission to show the notification
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission();
    //If user is authorised:
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await FirebaseMessaging.instance.getToken();

      
      if (token != null) {
        log("Firebase Messaging Token is: $token");
      }
      //On background
      //Calling onBackgroundMessage Method
      FirebaseMessaging.onBackgroundMessage(backgroundHandler);
      //Calling Local Notification Service
      LocalNotificationApiImplementation.initialize();
      log("Notifications Initialized!");
    }
  }
}
