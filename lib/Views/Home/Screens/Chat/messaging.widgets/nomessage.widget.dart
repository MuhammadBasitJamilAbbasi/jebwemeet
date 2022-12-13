import 'package:flutter/material.dart';
import 'package:jabwemeet/Utils/constants.dart';

class NoMessageWidget extends StatelessWidget {
  const NoMessageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          child: Image.asset(
            "assets/message.png",
            color: butoncolor,
            height: 120,
            width: 120,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text('No messages yet', style: k18styleblack),
        SizedBox(
          height: 10,
        ),
        Text(
          'You have no active chats',
          style: k16styleblack,
        ),
      ],
    );
  }
}
