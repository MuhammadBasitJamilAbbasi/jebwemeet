import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Home/Controllers/home_page_controller.dart';
//import 'package:marry_muslim/models/listing_custom_model.dart';;
import 'package:swipable_stack/swipable_stack.dart';

class ProfileCard extends StatefulWidget {
  /// Screen to be checked
  final String? page;
  final bool isHome;

//List<userdata> _userdata=[];
  ProfileCard(this.page, this.isHome);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  _get_to_previous() {
    Get.find<home_page_controller>().stackController.canRewind
        ? Get.find<home_page_controller>()
            .stackController
            .rewind(duration: Duration(milliseconds: 1400))
        : null;
  }

  _update_like() {
    //  widget.user!.isLiked = true;
    Get.find<home_page_controller>().stackController.next(
        duration: Duration(milliseconds: 1400),
        swipeDirection: SwipeDirection.right);

    setState(() {});
    // if (!widget.user!.isLiked!) {
    //  all_CRUD_user_operation().add_user_to_interest(widget.user!);
    // }
  }

  _update_Follow() {
    /* print(
        "updating follow current is : ${widget.user!.isFollow = !widget.user!.isFollow!}");
    widget.user!.isFollow = !widget.user!.isFollow!;
    print(
        "updating follow current is : ${widget.user!.isFollow = !widget.user!.isFollow!}");
*/
    Get.find<home_page_controller>().stackController.next(
        duration: Duration(milliseconds: 700),
        swipeDirection: SwipeDirection.up);

    // if (!widget.user!.isFollow!) {
    //   all_CRUD_user_operation().unfollow_user(widget.user!);
    // } else {
    //   all_CRUD_user_operation().add_user_to_follow(widget.user!);
    // }
    setState(() {});
  }

  _ignore_it() async {
    Get.find<home_page_controller>().stackController.next(
        duration: Duration(milliseconds: 1400),
        swipeDirection: SwipeDirection.left);
    //  bool val = await all_CRUD_user_operation().add_user_to_ignore(widget.user!);

    // print(val);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("is BLUR =====> ${widget.user!.imageBlur}");
    // final bool isImageBlur  = true;
    final bool isImageBlur = false;
    return Padding(
      key: UniqueKey(),
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          /*  await Get.to(() => detail_screen(
            user: this.widget.user,
            page: widget.page.toString(),
          ))!.whenComplete(() => setState((){
            print("huhuhuh");
            Get.find<explore_page_ui_controller>().controller!.animateTo(0);
            Get.find<explore_page_ui_controller>().change_index(0);
            Get.find<explore_page_ui_controller>().controller!.animateTo( Get.find<explore_page_ui_controller>().controller!.previousIndex);
          }));*/
        },
        child: Blur(
          colorOpacity: isImageBlur ? 0.5 : 0,
          blurColor: Colors.transparent,
          blur: isImageBlur ? 20 : 0,
          child: Card(
            clipBehavior: Clip.antiAlias,
            color: Colors.white,
            margin: EdgeInsets.zero,
            shape: defaultCardBorder(),
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/unsplash_RDcEWH5hSDE.png",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(7.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hiba Alam",
                          style: k18stylePrimary,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Age: 23",
                                  style: k10stylePrimary,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Profession: HR",
                                  style: k10stylePrimary,
                                ),
                              ],
                            ),
                            Container(
                              height: 24,
                              width: 90,
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              decoration: BoxDecoration(
                                  color: butoncolor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "View Bio",
                                    style: k12styleWhite,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        /* Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20,
                              child: IconButton(
                                onPressed: () {
                                  _get_to_previous();
                                  // Get.find<home_page_controller>()
                                  //     .fetch_listing_data();
                                },
                                icon: Image.asset(
                                  "assets/icons/restore.png",
                                  color: Colors.orange,
                                  height: 22,
                                ),
                              ),
                            ),
                            LikeButton(
                              onTap: (_) async {
                                Future.delayed(Duration(milliseconds: 800))
                                    .then((value) => {
                                          _ignore_it(),
                                        });

                                return Future.value(_);
                              },
                              size: 30,
                              isLiked: null,
                              circleColor: CircleColor(
                                start: Colors.red.shade400,
                                end: Colors.red.shade100,
                              ),
                              bubblesColor: BubblesColor(
                                dotPrimaryColor: Colors.red,
                                dotSecondaryColor: Colors.white,
                              ),
                              likeBuilder: (bool isLiked) {
                                return CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 28,
                                  child: Image.asset(
                                    "assets/icons/passed.png",
                                    height: 29,
                                  ),
                                );
                              },

                              // likeCountPadding: const EdgeInsets.only(left: 15.0),
                            ),
                            //ignore it

                            // CircleAvatar(
                            //   backgroundColor: Colors.white,
                            //   radius: 20,
                            //   child: IconButton(
                            //     onPressed: () async {
                            //       _update_Follow();
                            //     },
                            //     icon: Image.asset(
                            //       "assets/icons/star.png",
                            //       height: 22,
                            //       color: !widget.user!.isFollow!
                            //           ? Colors.blue
                            //           : Colors.grey,
                            //     ),
                            //   ),
                            // ),
                            LikeButton(
                              padding: EdgeInsets.zero,

                              onTap: (_) async {
                                Future.delayed(Duration(milliseconds: 800))
                                    .then((value) =>
                                        {print("asd"), _update_Follow()});

                                return Future.value(_);
                              },
                              size: 30,
                              isLiked: null,
                              circleColor: CircleColor(
                                start: Colors.transparent,
                                end: Colors.transparent,
                              ),
                              bubblesColor: BubblesColor(
                                dotPrimaryColor: Colors.blue,
                                dotSecondaryColor: Colors.lightBlueAccent,
                              ),
                              likeBuilder: (bool isLiked) {
                                return CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  child: Image.asset(
                                    "assets/icons/star.png",
                                    height: 22,
                                    color: Colors.blue,
                                  ),
                                );
                              },

                              // likeCountPadding: const EdgeInsets.only(left: 15.0),
                            ), // follow
                            // CircleAvatar(
                            //   backgroundColor: Colors.white,
                            //   radius: 28,
                            //   child: IconButton(
                            //     onPressed: () async {
                            //       _update_like();
                            //     },
                            //     icon: Image.asset(
                            //       "assets/icons/liked.png",
                            //       height: 29,
                            //       color: !widget.user!.isLiked!
                            //           ? Colors.green
                            //           : Colors.grey,
                            //     ),
                            //   ),
                            // ),
                            //LIKE button
                            LikeButton(
                              onTap: (_) async {
                                print("HITTING HE");
                                Future.delayed(Duration(milliseconds: 800))
                                    .then((value) => {_update_like()});

                                return Future.value(_);
                              },
                              size: 30,
                              isLiked: null,
                              circleColor: CircleColor(
                                start: Colors.green.shade400,
                                end: Colors.green.shade100,
                              ),
                              bubblesColor: BubblesColor(
                                dotPrimaryColor: Colors.green,
                                dotSecondaryColor: Colors.white,
                              ),
                              likeBuilder: (bool isLiked) {
                                return CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 28,
                                  child: Image.asset(
                                    "assets/icons/liked.png",
                                    height: 29,
                                    // color: !widget.user!.isLiked!
                                    //     ? Colors.green
                                    //     : Colors.grey,
                                  ),
                                );
                              },

                              // likeCountPadding: const EdgeInsets.only(left: 15.0),
                            ),
                            //above is like
                            // Get.find<storage_controller>().userModel.value.data!.membership.toString() == "1"? false : true;
                            LikeButton(
                              onTap: (_) async {},
                              size: 30,
                              isLiked: null,
                              circleColor: CircleColor(
                                start: Colors.transparent,
                                end: Colors.transparent,
                              ),
                              bubblesColor: BubblesColor(
                                dotPrimaryColor: Colors.purple,
                                dotSecondaryColor: Colors.white,
                              ),
                              likeBuilder: (bool isLiked) {
                                return CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  child: Image.asset(
                                    "assets/icons/flush.png",
                                    height: 22,
                                  ),
                                );
                              },
                            ) //above is message
                          ],
                        )*/

                        // this.page == 'discover'
                        //     ? SizedBox(height: 70)
                        //     : Container(width: 0, height: 0),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

RoundedRectangleBorder defaultCardBorder() {
  return RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(28.0),
    topRight: Radius.circular(28.0),
    topLeft: Radius.circular(28.0),
    bottomRight: Radius.circular(28.0),
  ));
}
