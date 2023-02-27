import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/onboarding_controller.dart';
import 'package:jabwemeet/Views/Auth/Screens/JabWeMetScreen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  List<Widget> pages = [
     OnBoardingPage(
      // centerimage: "assets/girl2.png",
      // leftimage: "assets/girl2_left.png",
      // rightimage: "assets/girl2_right.png",
      content:
          "Users going through a vetting process to ensure you never match with bots.",
      text: "Algorithm",
    ),
     OnBoardingPage(
      // centerimage: "assets/girl1.png",
      // leftimage: "assets/girl1_left.png",
      // rightimage: "assets/girl1_right.png",
      content:
          "We match you with people that have a large array of similar interests.",
      text: "Matches",
    ),
     OnBoardingPage(
      // centerimage: "assets/girl3.png",
      // leftimage: "assets/girl3_left.png",
      // rightimage: "assets/girl3_right.png",
      content:
          "Sign up today and enjoy the first month of premium benefits on us.",
      text: "Premium",
    ),
  ];
 List<String>? imagesList1=[
   "assets/girl3.png",
   "assets/girl2.png",
   "assets/girl1.png",
 ];
  List<String>? imagesList2=[
    "assets/girl2.png",
    "assets/girl1.png",
    "assets/girl3.png",
  ];
  List<String>? imagesList3=[
    "assets/girl1.png",
    "assets/girl3.png",
    "assets/girl2.png",
  ];
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Get.find<OnBoardingController>().index = 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Object? args = ModalRoute.of(context)?.settings.arguments;

    return SafeArea(
      child: GetBuilder<OnBoardingController>(
        init: OnBoardingController(),
        builder: (onBoardingProvider) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  child:
                    Container(
                      height: 310,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          viewportFraction: 0.6,
                          aspectRatio: 1,
                          enlargeCenterPage: true,
                          height: 310,
                          initialPage: onBoardingProvider.index,
                          autoPlayInterval: Duration(seconds: 4),
                          // enlargeCenterPage: true,
                          //scrollDirection: Axis.vertical,
                          onPageChanged: (index, reason) {
                           // index= onBoardingProvider.index;
                           //  setState(() {});
                          },
                        ),
                        items: onBoardingProvider.index==1? imagesList1!
                            .map(
                              (item) => GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 310,
                              width: MediaQuery.of(context).size.width,

                              child: Image.asset(
                                item,
                                fit: BoxFit.fill,
                                height: 310,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ),
                        )
                            .toList() :onBoardingProvider.index==2 ?imagesList2!
                            .map(
                              (item) => GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 310,
                              width: MediaQuery.of(context).size.width,

                              child: Image.asset(
                                item,
                                fit: BoxFit.fill,
                                height: 310,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ),
                        )
                            .toList() : imagesList3!
                            .map(
                              (item) => GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 310,
                              width: MediaQuery.of(context).size.width,

                              child: Image.asset(
                                item,
                                fit: BoxFit.fill,
                                height: 310,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ),
                        )
                            .toList(),
                      ),
                    ),
                ),
                PageView(
                  onPageChanged: (int value) {
                    onBoardingProvider.index = value;
                    onBoardingProvider.update();
                  },
                  controller: _pageController,
                  children: pages.asMap().entries.map((e) {
                    return e.value;
                  }).toList(),
                ),
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            pages.length,
                                (index) => Container(
                              height: 8,
                              width: 8,
                              margin: EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: onBoardingProvider.index == index
                                      ? primarycolor
                                      : Colors.grey.shade300),
                            )),
                      ),
                      AppComponents().sizedBox30,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: kAppButton(
                            buttonText: "Create an account",
                            onButtonPressed: () {
                              Get.to(()=> JabWeMet_Screen());
                            }),
                      ),
                      AppComponents().sizedBox20,
                      alreadyHaveAnAccount(context)
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  // final String centerimage;
  // final String leftimage;
  // final String rightimage;
  final String text;
  final String content;
   OnBoardingPage({
    Key? key,
    // required this.centerimage,
    // required this.leftimage,
    // required this.rightimage,
    required this.content,
    required this.text,
  }) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  List<String>? imagesList=[
    "assets/girl3.png",
    "assets/girl2.png",
    "assets/girl1.png",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         SizedBox(height: 360,)

          // AppComponents().sizedBox50,
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Image.asset(
          //       leftimage,
          //       height: 260,
          //     ),
          //     Expanded(
          //       child: Image.asset(
          //         centerimage,
          //         height: 320,
          //       ),
          //     ),
          //     Padding(
          //       padding: EdgeInsets.symmetric(vertical: 30),
          //       child: Image.asset(
          //         rightimage,
          //         height: 260,
          //       ),
          //     ),
          //   ],
          // ),
          ,
          AppComponents().sizedBox30,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    widget.text,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: textcolor),
                  ),
                ),
              ),
            ],
          ),
          AppComponents().sizedBox30,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Center(
                    child: Text(
                      widget.content,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,

                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
