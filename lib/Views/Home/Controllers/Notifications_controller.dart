import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  Future<void> getNotifications() {
    return Future.delayed(Duration(milliseconds: 500));
  }

  List<String> imageUrl = [];
  List<String> name = [];

  Future getAllUsers(docid) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(docid)
        .get()
        .then((value) {
      imageUrl.add(value.get('imageUrl'));
      name.add(value.get('name'));
      update();
    });
  }
}
