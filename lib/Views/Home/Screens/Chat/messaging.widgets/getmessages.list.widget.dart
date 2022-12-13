import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jabwemeet/Utils/constants.dart';

class GetMessageList extends StatelessWidget {
  final String profileImage, name, message;
  final String time;
  final VoidCallback ontap;
  final bool isRead;
  GetMessageList(
      {Key? key,
      required this.profileImage,
      required this.ontap,
      required this.name,
      required this.message,
      required this.time,
      required this.isRead})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: ontap,
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              profileImage == ''
                  ? CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage('Assets/images/user.png'),
                    )
                  : CircleAvatar(
                      radius: 24,
                      backgroundImage: CachedNetworkImageProvider(profileImage),
                      onBackgroundImageError: ((exception, stackTrace) =>
                          Icon(Icons.error_outline)),
                    ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: body4StyleHeight,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Spacer(),
                        Text(
                          time,
                          style: secondaryFontStyleWeight,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            message,
                            style: isRead == false
                                ? unreadStyle
                                : secondaryFontStyleWeight,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Spacer(),
                        isRead == false
                            ? CircleAvatar(
                                radius: 4,
                                backgroundColor: butoncolor,
                              )
                            : SizedBox(),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
