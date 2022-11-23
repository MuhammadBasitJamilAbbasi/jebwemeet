import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class KCommonText extends StatelessWidget {
  String text;
  FontWeight fontweight;
  double fontsize;
  Color color;
  int combination;
  KCommonText({
    required this.text,
    required this.fontweight,
    required this.fontsize,
    required this.color,
    this.combination = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: combination == 1
          ? GoogleFonts.nunito(
              textStyle: TextStyle(
                color: color,
                fontWeight: fontweight,
                fontSize: fontsize,
              ),
            )
          : GoogleFonts.baskervville(
              textStyle: TextStyle(
                color: color,
                fontWeight: fontweight,
                fontSize: fontsize,
              ),
            ),
      textAlign: TextAlign.left,
    );
  }
}
