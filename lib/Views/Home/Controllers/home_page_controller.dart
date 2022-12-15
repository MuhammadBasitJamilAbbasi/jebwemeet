import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';

class Home_page_controller extends GetxController {
  String? selectedMartialStatus = "Select Status";
  String? selectedReligion = "Select Religion";
  String? selectedCaste = "Select Caste";
  String? selectedCity = "Select City";
  var lowerValue = 18.0.obs;
  var upperValue = 60.0.obs;
  Stream<QuerySnapshot<Map<String, dynamic>>> queryValue = FirebaseFirestore
      .instance
      .collection("users")
      .where("age", isGreaterThanOrEqualTo: 18)
      .snapshots();

  clearAll(BuildContext context) {
    selectedMartialStatus = "Select Status";
    selectedReligion = "Select Religion";
    selectedCaste = "Select Caste";
    selectedCity = "Select City";
    lowerValue.value = 18.0;
    upperValue.value = 60.0;
    update();
    snackBar(context, "Filters Clear", Colors.pink);
  }

  query() {
    if (selectedCity == "Select City" &&
        selectedCaste == "Select Caste" &&
        selectedReligion == "Select Religion" &&
        lowerValue.value.round() == 18 &&
        upperValue.value.round() == 60 &&
        selectedMartialStatus == "Select Status") {
      queryValue = FirebaseFirestore.instance.collection("users").snapshots();
    } else {
      queryValue = FirebaseFirestore.instance
          .collection("users")
          .where("age", isGreaterThanOrEqualTo: lowerValue.value.round())
          .where("age", isLessThanOrEqualTo: upperValue.value.round())
          .where("martial_status", isEqualTo: selectedMartialStatus)
          .where("address", isEqualTo: selectedCity)
          .where("caste", isEqualTo: selectedCaste)
          .where("religion", isEqualTo: selectedReligion)
          .snapshots();
    }
    update();
    return queryValue;
  }

  selectedMartialFunction(String? value) {
    selectedMartialStatus = value;
    update();
  }

  selectedCityFunction(String? value) {
    selectedCity = value;
    update();
  }

  selectedReligionFunction(String? value) {
    selectedReligion = value;
    update();
  }

  selectedCasteFunction(String? value) {
    selectedCaste = value;
    update();
  }

  // iniCustom() {
  //   // fetch_listing_data(pageNumber: currentPage.value.toString());
  // }
  //
  // late PageController controller;
  //
  // var listingModel = ListingModel().obs;
  // var userlist = UserModel().obs;
/*  late List countList;

  SwipableStackController stackController = SwipableStackController();

  var isLoading = false.obs;
  var isEmpty = true.obs;

  var currentPage = 0.obs;

  void increamentCurrentPage() {
    print("============> CURRENT API");
    currentPage.value++;
    // fetch_listing_data(pageNumber: currentPage.value.toString());
  }*/

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
  /* void onInit() {
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
  }*/
/*  remove_user(Listing e) {
    // Listing_List.value.remove(e);
    refresh();
    update();
    notifyChildrens();
  }*/
}
