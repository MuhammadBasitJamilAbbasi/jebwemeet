import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Models/UserModel.dart';
import 'package:jabwemeet/Models/chatroom.model.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Home/Controllers/home_page_controller.dart';
import 'package:jabwemeet/Views/Home/Screens/Chat/messaging/inbox.dart';
import 'package:jabwemeet/Views/Home/Screens/Home/filterScreen.dart';
import 'package:uuid/uuid.dart';


RoundedRectangleBorder defaultCardBorder() {
  return RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(15.0),
    topRight: Radius.circular(15.0),
    topLeft: Radius.circular(15.0),
    bottomRight: Radius.circular(15.0),
  ));
}
