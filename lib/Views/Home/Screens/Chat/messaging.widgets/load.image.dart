import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Home/Controllers/message_controller.dart';

class LoadImage extends StatelessWidget {
  const LoadImage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MessageController>();

    return (controller.messageImage != null && controller.percentage != null)
        ? Align(
            alignment: Alignment.centerRight,
            child: Container(
              constraints: BoxConstraints(maxWidth: 150, maxHeight: 150),
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image(
                          image: FileImage(controller.messageImage!),
                          fit: BoxFit.cover,
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: Center(
                          child: CircularProgressIndicator(
                        color: butoncolor,
                        value: controller.percentage,
                      )),
                    ),
                  )
                ],
              ),
            ),
          )
        : SizedBox();
  }
}
