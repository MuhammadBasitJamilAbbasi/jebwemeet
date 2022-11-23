//ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutales, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jabwemeet/Components/KCommonText.dart';
import 'package:jabwemeet/Utils/constants.dart';

class kCommonButton extends StatelessWidget {
  String text;
  var ontap;
  kCommonButton({required this.ontap, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: Center(
          child: KCommonText(
              text: text,
              fontweight: FontWeight.w500,
              fontsize: 16,
              color: whitecolor),
        ),
        decoration: BoxDecoration(
            /*  boxShadow: [
          BoxShadow(color: Colors.grey.shade300, blurRadius: 10.0, spreadRadius: 5,offset: Offset(0,1)),
        ], */
            borderRadius: BorderRadius.circular(8),
            color: primarycolor),
      ),
    );
  }
}
