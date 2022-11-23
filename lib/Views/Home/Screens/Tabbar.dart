import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Home/Screens/Account/Account.dart';
import 'package:jabwemeet/Views/Home/Screens/Chat/chat.dart';
import 'package:jabwemeet/Views/Home/Screens/Home/Home.dart';
import 'package:jabwemeet/Views/Home/Screens/Likes/LIke.dart';

class kCustomBottomNavBar extends StatefulWidget {
  final int? index;

  kCustomBottomNavBar({this.index = 0});

  @override
  State<kCustomBottomNavBar> createState() => _kCustomBottomNavBarState();
}

class _kCustomBottomNavBarState extends State<kCustomBottomNavBar> {
  int _selectedIndex = 0;
  PageController? _pageController;

  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey.shade100,
      child: CustomNavigationBar(
        iconSize: 45,
        backgroundColor: Colors.transparent,
        selectedColor: butoncolor,
        strokeColor: Colors.grey.shade200,
        unSelectedColor: Colors.grey.shade200,
        items: [
          CustomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Get.to(() => Home());
              },
              child: Container(
                height: 45,
                width: 45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 2,
                      width: 50,
                      color:
                          widget.index == 0 ? butoncolor : Colors.transparent,
                    ),
                    Container(
                      child: Image.asset(
                        "assets/Group 25.png",
                        height: 35,
                        width: 25,
                        color:
                            widget.index == 0 ? butoncolor : Color(0xFFADAFBB),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          CustomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Get.to(() => Like());
              },
              child: Container(
                height: 45,
                width: 45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 2,
                      width: 50,
                      color:
                          widget.index == 1 ? butoncolor : Colors.transparent,
                    ),
                    widget.index == 1
                        ? Container(
                            child: Image.asset(
                              "assets/indicator.png",
                              height: 35,
                              width: 25,
                              color: butoncolor,
                            ),
                          )
                        : Container(
                            child: Image.asset(
                              "assets/indicator.png",
                              height: 35,
                              width: 25,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
          CustomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Get.to(() => Chat());
              },
              child: Container(
                height: 45,
                width: 45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 2,
                      width: 50,
                      color:
                          widget.index == 2 ? butoncolor : Colors.transparent,
                    ),
                    widget.index == 2
                        ? Container(
                            child: Image.asset("assets/message.png",
                                height: 35, width: 25, color: butoncolor),
                          )
                        : Container(
                            child: Image.asset(
                              "assets/message.png",
                              height: 35,
                              width: 25,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
          CustomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Get.to(() => Account());
              },
              child: Container(
                height: 45,
                width: 45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 2,
                      width: 50,
                      color:
                          widget.index == 3 ? butoncolor : Colors.transparent,
                    ),
                    Container(
                      child: Image.asset(
                        "assets/people.png",
                        height: 35,
                        width: 25,
                        color:
                            widget.index == 3 ? butoncolor : Color(0xFFADAFBB),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        currentIndex: widget.index ?? _selectedIndex,
        isFloating: true,
        elevation: 0,
        onTap: (index) {
          _selectedIndex = index;
          _pageController!.animateToPage(index,
              duration: Duration(milliseconds: 200), curve: Curves.ease);
        }, /**/
      ),
    );
  }
}
