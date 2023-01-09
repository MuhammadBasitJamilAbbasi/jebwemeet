import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class NotificationApiHitting {
  Future<bool> callOnFcmApiSendPushNotifications(
      {required String jwm_message, required fcmToken}) async {
    const String postUrl = 'https://fcm.googleapis.com/fcm/send';
    const String authorization =
        'key=AAAAanOy1vw:APA91bEKqqKOvGGuXPmm7cdgGxH78ys7VgWg099gbjmeWmi4HqIvFliZ6wxa56nfM4M-BoRVk5qs20ecSwxioJPfk6xKPX0lymsyVXYVehKRaeNtEKzvo_LOKJzx1RNtcn60sk3DhLBO';
    // List<String?> userToken = [await FirebaseMessaging.instance.getToken()];
    final data = {
      "registration_ids": [fcmToken],
      "collapse_key": "type_a",
      "notification": {
        "title": 'JabWeMeet',
        "body": jwm_message,
      },
      "priority": "high",
      "data": {"jwm_message": jwm_message}
    };

    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': authorization
    };
    try {
      log("Inside Try Statement");
      final response = await http.post(Uri.parse(postUrl),
          body: json.encode(data),
          encoding: Encoding.getByName('utf-8'),
          headers: headers);

      if (response.statusCode == 200) {
        // On success
        log('<=============Test Ok Push CFM=============>');
        log(response.body.toString());
        return true;
      } else {
        // On failure
        log('<=============CFM error=============>');
        log(response.body.toString());
        return false;
      }
    } catch (ex) {
      log("Inside Catch Statement");
      log("Exception caught ${ex}");
      return false;
    }
  }
}
