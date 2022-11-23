import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:marry_muslim/models/listing_custom_model.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:jabwemeet/Models/Listing_model.dart';

class home_page_controller extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    if (stackController.hasListeners) {
      stackController.removeListener(() {});
    }
    stackController = SwipableStackController()
      ..addListener(() {
        update();
      });
    controller = PageController(initialPage: 0);
  }

  clearMessageDot() {
    print("clearing dot");
    listingModel.value.data?.unreadMessage = false;
    print("cleared ${listingModel.value.data?.unreadMessage}");
    update();
  }

  iniCustom() {
    // fetch_listing_data(pageNumber: currentPage.value.toString());
  }

  late PageController controller;

  var listingModel = ListingModel().obs;
  RxList<Listing> Listing_List = RxList<Listing>([]);

  SwipableStackController stackController = SwipableStackController();

  var isLoading = false.obs;
  var isEmpty = true.obs;

  var currentPage = 0.obs;

  void increamentCurrentPage() {
    print("============> CURRENT API");
    currentPage.value++;
    // fetch_listing_data(pageNumber: currentPage.value.toString());
  }

/*
  Future fetch_listing_data({required String pageNumber}) async {
    print("fetch_listing_data() in home page controller");
    isLoading.value = true;
    Listing_List.value.clear();
    try {
      var detail = await listing_services.fetch_listing(pageNumber: pageNumber);
      print("yes 3 ");
      if (detail != null) {
        if (detail is ListingModel) {
          print("yes");
          listingModel.value = detail;
          print("yes 2");
          if (detail.data!.listing!.isNotEmpty)
            Listing_List.value.addAll(detail.data!.listing!);
          stackController.currentIndex = 0;
          print(Listing_List.value.length.toString() +
              "this is total list lenght lisiting");
          print(detail.data!.listing!.length.toString() +
              "this is total list lenght lisiting");
          update();
          if (Listing_List.value.length == 0) {
            isLoading.value = false;
            isEmpty.value = true;
          }
        }
        isLoading.value = false;
        isEmpty.value = false;
      } else {
        isLoading.value = false;
        isEmpty.value = true;
        print("ERRRRRRRRRROR FROM ELSE");
      }
    } catch (E) {
      print("aaaaaaaaaa" + E.toString());
      isLoading.value = false;
      isEmpty.value = true;
    }
  }
*/

  remove_user(Listing e) {
    Listing_List.value.remove(e);
    refresh();
    update();
    notifyChildrens();
  }
}
