import 'package:flutter/material.dart';

class InterestWidget extends StatelessWidget {
  final String image;
  final Color color;
  final String? title;
  final VoidCallback? onTap;
  final double horizontalDistance;
  final TextStyle? textstyle;
  const InterestWidget({
    Key? key,
    this.textstyle,
    required this.image,
    this.title,
    this.onTap,
    required this.horizontalDistance,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding:
            EdgeInsets.symmetric(horizontal: horizontalDistance, vertical: 10),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(40)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(image),
            SizedBox(width: 5),
            Text(
              title!,
              style: textstyle,
            )
          ],
        ),
      ),
    );
  }
}
