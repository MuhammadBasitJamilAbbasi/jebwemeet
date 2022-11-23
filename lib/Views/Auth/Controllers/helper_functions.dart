import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';

class HelpersFunctions extends GetxController {
  // Create a community detail things
  File? communityImage;
  double? imageUploadPercentage;
  String? communityPictureDownloadUrl;
  String CommunityImageFolderName = 'CommunityPic';

  //create Post things
  File? postImage;
  var selectedImage = "";
  //Pick the image from the gallery
  Future pickImage(
    BuildContext context,
    File? image,
  ) async {
    try {
      XFile? imagePick =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (imagePick != null) {
        File convertedFile = File(imagePick.path);
        image = convertedFile;
        communityImage = image;
        update();
        selectedImage = image.path.toString();
        update();
        postImage = image;
        update();
      } else {
        return;
      }
    } on PlatformException catch (e) {
      snackBar(context, e.toString(), butoncolor);
    }
  }

  //Upload the image to firebase fireStorage
/*  uploadImage(BuildContext context, double? percentage, File? image,
      String folderName) async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child(folderName)
        .child(uuid.v1())
        .putFile(image!);

    StreamSubscription listenEvent = uploadTask.snapshotEvents.listen((data) {
      percentage = (data.bytesTransferred / data.totalBytes);
      notifyListeners();
      if (data.state == TaskState.success) {
        percentage = null;

        log('Our image uploading done');
      }

      log('This is our uploading image task : ${percentage.toString()}');
    });

    ;

    TaskSnapshot taskSnapshot = await uploadTask;
    communityPictureDownloadUrl = await taskSnapshot.ref.getDownloadURL();
    listenEvent.cancel();
    log(communityPictureDownloadUrl!);
  }*/
}
