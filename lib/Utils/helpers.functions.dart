import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:uuid/uuid.dart';

class HelpersFunctions extends ChangeNotifier {
  //cover picture
  File? communityCoverImage;
  double? imageUploadPercentageCover;
  String? communityPictureDownloadUrlCover;
  String CommunityImageFolderNameCover = 'communityCovers';

  // Create a community detail things
  File? communityImage;
  double? imageUploadPercentage;
  String? communityPictureDownloadUrl;
  String CommunityImageFolderName = 'CommunityPic';

  //create Post things
  File? postImage;
  var selectedImage = "";

  File? postImageCover;

  var selectedImageCover = "";
  //Pick the image from the gallery

  //FOR PROFILE PICTURE
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
        notifyListeners();
        selectedImage = image.path.toString();
        notifyListeners();
        postImage = image;
        notifyListeners();
      } else {
        return;
      }
    } on PlatformException catch (e) {
      snackBar(context, e.toString(), Colors.pink);
    }
  }

  //Upload the image to firebase fireStorage
  uploadImage(BuildContext context, double? percentage, File? image,
      String folderName) async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child(folderName)
        .child(Uuid().v1())
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
  }

  // FOR COVER PHOTO

  Future pickCoverImage(
    BuildContext context,
    File? image,
  ) async {
    try {
      XFile? imagePick =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (imagePick != null) {
        File convertedFile = File(imagePick.path);
        image = convertedFile;
        communityCoverImage = image;
        notifyListeners();
        selectedImageCover = image.path.toString();
        notifyListeners();
        postImageCover = image;
        notifyListeners();
      } else {
        return;
      }
    } on PlatformException catch (e) {
      snackBar(context, e.toString(), Colors.pink);
    }
  }

  //Upload the image to firebase fireStorage
  UploadCoverImage(BuildContext context, double? percentage, File? image,
      String folderName) async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child(folderName)
        .child(Uuid().v1())
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
    communityPictureDownloadUrlCover = await taskSnapshot.ref.getDownloadURL();
    listenEvent.cancel();
    log(communityPictureDownloadUrlCover!);
  }
}
