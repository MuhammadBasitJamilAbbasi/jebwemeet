import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Home/Controllers/home_page_controller.dart';
import 'package:jabwemeet/Views/Home/Screens/Home/Home_Components.dart';
import 'package:jabwemeet/Views/Home/Screens/Tabbar.dart';

//import 'package:marry_muslim/models/listing_custom_model.dart';

class Home extends GetView<home_page_controller> {
  final a = Get.put(home_page_controller());

  Widget getCard() {
    return GetBuilder<home_page_controller>(
        init: home_page_controller(),
        builder: (builder) {
          return ProfileCard("primary", true);
        });
  }

  @override
  Widget build(BuildContext context) {
    // a.iniCustom();
    return Scaffold(
      bottomNavigationBar: kCustomBottomNavBar(
        index: 0,
      ),
      body: SafeArea(
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
            // outlined_button(
            //     txt: "Refresh",
            //     ontap: () {
            //       // controller.fetch_listing_data(pageNumber: "0");
            //       //  controller.fetch_listing_data(pageNumber: controller.currentPage.value.toString());
            //     },
            //     color: Theme.of(context).primaryColor,
            //     icon: Icon(
            //       Icons.refresh,
            //       color: Theme.of(context).primaryColor,
            //     )),
            AppComponents().sizedBox20,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Discover",
                    style: k25styleblack,
                  ),
                  Image.asset(
                    "assets/filter.png",
                    height: 30,
                    width: 30,
                  ),
                ],
              ),
            ),
            AppComponents().sizedBox10,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "People’s that matches your hobby. Start connecting with them.",
                style: k12styleblack,
              ),
            ),
            AppComponents().sizedBox10,

            Container(
              height: MediaQuery.of(context).size.height * .695,
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: SwipableStack(
                builder: (context, properties) {
                  return getCard();
                },
                detectableSwipeDirections: const {
                  SwipeDirection.right,
                  SwipeDirection.left,
                  SwipeDirection.up,
                  SwipeDirection.down,
                },
                itemCount: 5,
                controller: controller.stackController,
                stackClipBehaviour: Clip.none,
                allowVerticalSwipe: true,
                onWillMoveNext: (index, swipeDirection) {
                  // Datum model = Functions.convertListingToDatum(
                  //     controller.Listing_List.value[index]);

                  // Return true for the desired swipe direction.
                  switch (swipeDirection) {
                    case SwipeDirection.left:
                      {
                        print("====> left");
                        // all_CRUD_user_operation().add_user_to_ignore(model);
                        return true;
                      }
                    case SwipeDirection.right:
                      {
                        print("====> right");
                        // all_CRUD_user_operation().add_user_to_interest(model);
                        return true;
                      }
                    case SwipeDirection.up:
                      {
                        print("====> up");
                        //  all_CRUD_user_operation().add_user_to_follow(model);
                        // all_CRUD_user_operation().check_followed_unfollowed(
                        //     e: model, isfollowed: model.isFollow!);
                        // model.isFollow = !model.isFollow!;

                        return true;
                      }
                    case SwipeDirection.down:
                      return false;
                  }
                },
                horizontalSwipeThreshold: 0.8,
                verticalSwipeThreshold: 1,
                overlayBuilder: (
                  context,
                  properties,
                ) =>
                    CardOverlay(
                  swipeProgress: properties.swipeProgress,
                  direction: properties.direction,
                ),
              ),
            )
          ])
              /*return  PageView(
                physics: BouncingScrollPhysics(),
                //key: PageStorageKey("Listing_List"),
                controller: controller.controller,
                scrollDirection: Axis.vertical,
                children: controller.Listing_List.value.map((e) {
                  return getCard(e);
                }).toList()
            );*/
              )),
    );
  }
}

class CardOverlay extends StatelessWidget {
  const CardOverlay({
    required this.direction,
    required this.swipeProgress,
    Key? key,
  }) : super(key: key);
  final SwipeDirection direction;
  final double swipeProgress;

  @override
  Widget build(BuildContext context) {
    final opacity = math.min<double>(swipeProgress, 1);

    final isRight = direction == SwipeDirection.right;
    final isLeft = direction == SwipeDirection.left;
    final isUp = direction == SwipeDirection.up;
    final isDown = direction == SwipeDirection.down;
    return Stack(
      children: [
        Opacity(
          opacity: isRight ? opacity : 0,
          child: CardLabel.right(),
        ),
        Opacity(
          opacity: isLeft ? opacity : 0,
          child: CardLabel.left(),
        ),
        Opacity(
          opacity: isUp ? opacity : 0,
          child: CardLabel.up(),
        ),
        // Opacity(
        //   opacity: isDown ? opacity : 0,
        //   child: CardLabel.down(),
        // ),
      ],
    );
  }
}

const _labelAngle = math.pi / 2 * 0.2;

class CardLabel extends StatelessWidget {
  const CardLabel._({
    required this.color,
    required this.image_asset,
    required this.angle,
    required this.alignment,
    Key? key,
  }) : super(key: key);

  factory CardLabel.right() {
    return const CardLabel._(
      color: Colors.green,
      image_asset: "assets/icons/liked.png",
      angle: -_labelAngle,
      alignment: Alignment.topLeft,
    );
  }

  factory CardLabel.left() {
    return const CardLabel._(
      color: Colors.red,
      image_asset: "assets/icons/passed.png",
      angle: _labelAngle,
      alignment: Alignment.topRight,
    );
  }

  factory CardLabel.up() {
    return const CardLabel._(
      color: Colors.blue,
      image_asset: "assets/icons/star.png",
      angle: 0,
      alignment: Alignment.topCenter,
    );
  }

  // factory CardLabel.down() {
  //   return const CardLabel._(
  //     color: Colors.grey,
  //     label: 'DOWN',
  //     angle: -_labelAngle,
  //     alignment: Alignment(0, -0.75),
  //   );
  // }

  final Color color;
  final String image_asset;
  final double angle;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(
        vertical: 36,
        horizontal: 36,
      ),
      child: Transform.rotate(
        angle: angle,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: color,
              width: 4,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.all(6),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: IconButton(
              onPressed: null,
              icon: Image.asset(
                image_asset,
                height: 22,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
