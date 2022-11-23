//ignore_for_file: prefer_const_constructors, prefer+const_literals_to_create_immutables;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Utils/Dialouge_Boxes.dart';

import '../constants.dart';

class AppBarWidget extends StatelessWidget {
  String titleText;
  bool isOff;
  bool isActionOn;

  AppBarWidget(
      {Key? key,
      required this.titleText,
      this.isOff = false,
      this.isActionOn = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20, width: 20),
          Text(
            titleText,
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 20, color: Colors.white),
          ),
        ],
      ),
      centerTitle: true,
      leading: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20, width: 20),
          Flexible(
            child: IconButton(
                onPressed: () {
                  if (isOff) {
                    Dialouge_Box.showExitPopup_PrepareFood(context);
                  } else
                    Get.back();
                },
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.white),
          ),
        ],
      ),
      leadingWidth: 70,
      backgroundColor: primarycolor,
      elevation: 0.0,
    );
  }
}
