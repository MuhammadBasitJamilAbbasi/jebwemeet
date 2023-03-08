import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jabwemeet/Views/Auth/Screens/JabWeMetScreen.dart';
import 'package:jabwemeet/Views/Auth/Screens/onboarding2.dart';
import 'package:jabwemeet/Views/Auth/Screens/onboarding_testing.dart';

class GetSTorageController extends GetxController implements GetxService {
  final box = GetStorage();

  Future<void> initstorage() async {
    await GetStorage().initStorage;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    imageurl.value = box.read("image").toString();
    uID.value = box.read("uid").toString();
  }

  var imageurl = "".obs;
  var uID = "".obs;
  bool isHavingData = false;

  ToggleIsHavingData(bool value) {
    isHavingData = value;
    update();
  }

  Future<void> removeStoragebyMe() async {
    await box.erase();
  }

  Future<void> removeStorage() async {
    log("<--------------Get Storage Remove Before-------------->");
    log(box.getKeys().toString());
    log(box.getValues().toString());
    await box.erase().then((value) async {
      FirebaseAuth.instance.signOut();
      ToggleIsHavingData(false);
      print("removee storage");
      update();
      Get.offAll(() => OnboardingTesting());
    });
    log("<--------------Get Storage Remove After-------------->");
    log(box.getKeys().toString());
    log(box.getValues().toString());
  }
}
