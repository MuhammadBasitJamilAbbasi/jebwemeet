import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';

class TermsAndConiditons extends StatefulWidget {
  const TermsAndConiditons({Key? key}) : super(key: key);

  @override
  State<TermsAndConiditons> createState() => _TermsAndConiditonsState();
}

class _TermsAndConiditonsState extends State<TermsAndConiditons> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegisterController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.height * 0.025,
          MediaQuery.of(context).size.height * 0.06,
          MediaQuery.of(context).size.height * 0.025,
          0.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              AppComponents().backIcon(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: FittedBox(
                  child: Text(
                    "Terms & Conditions",
                    style: TextStyle(
                      color: Color(0xfFf1565A),
                      fontSize: 25,
                      fontFamily: "Gilroy-Bold",
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Text(
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.",
                style: TextStyle(fontSize: 14, fontFamily: "Gilroy-Regular"),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
              ),
              Obx(
                () => Get.find<RegisterController>().isAccept.value
                    ? SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.055,
                            width: MediaQuery.of(context).size.width * 0.33,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.find<RegisterController>().isAccept.value =
                                    true;
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: const BorderSide(
                                        color: Color(0xfFf1565A)),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xfFf1565A)),
                              ),
                              child: const Text("Accept",
                                  style: TextStyle(
                                      fontFamily: "Gilroy-Regular",
                                      fontSize: 16)),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.055,
                            width: MediaQuery.of(context).size.width * 0.33,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side:
                                        BorderSide(color: Colors.grey.shade400),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.grey.shade400),
                              ),
                              child: const Text("Decline",
                                  style: TextStyle(
                                      fontFamily: "Gilroy-Regular",
                                      fontSize: 16)),
                            ),
                          ),
                        ],
                      ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Obx(
                () => Get.find<RegisterController>().isAccept.value
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  value: controller.isTerm.value,
                                  onChanged: (val) {
                                    controller.isTerm.value = val!;
                                  }),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "I agree with Terms and Conditions",
                                style: TextStyle(
                                    fontFamily: "Gilroy-Regular", fontSize: 12),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: controller.isPolicy.value,
                                  onChanged: (val) {
                                    controller.isPolicy.value = val!;
                                  }),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "I agree with Privacy Policy",
                                style: TextStyle(
                                    fontFamily: "Gilroy-Regular", fontSize: 12),
                              )
                            ],
                          )
                        ],
                      )
                    : GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "By accepting you agree to our Terms and\nPrivacy Policy",
                          style: TextStyle(color: Colors.black, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
