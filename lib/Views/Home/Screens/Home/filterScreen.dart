import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Home/Controllers/home_page_controller.dart';
import 'package:jabwemeet/Views/Home/Screens/Home/new_home_swapable.dart';
import 'package:jabwemeet/Views/Home/Screens/Home/plan_subscription.dart';
import 'package:jabwemeet/testing_sub.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:range_slider_flutter/range_slider_flutter.dart';


import 'dart:async';
import 'dart:io';
final bool _kAutoConsume = Platform.isIOS || true;

const String _kConsumableId = 'jabwemeet_999_1m';
const String _kUpgradeId = 'jabwemeet_1999_3m';
const String _kSilverSubscriptionId = 'jabwemeet_999_1m';
const String _kGoldSubscriptionId = 'jabwemeet_1999_3m';
const List<String> _kProductIds = <String>[
  _kConsumableId,
  _kUpgradeId,
  _kSilverSubscriptionId,
  _kGoldSubscriptionId,
];


class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  

  bool _isLoading = false;
  void openSubscriptionSheetMethod() async {
    setState(() {
      _isLoading = true;
    });

    CustomerInfo customerInfo = await Purchases.getCustomerInfo();

    if (customerInfo.entitlements.all[entitlementID] != null &&
        customerInfo.entitlements.all[entitlementID]!.isActive == true ||  customerInfo.entitlements.all[entitlementID2] != null &&
        customerInfo.entitlements.all[entitlementID2]!.isActive == true) {

      setState(() {
        _isLoading = false;
          appData.entitlementIsActive = true;
      });
    } else {
      Offerings? offerings;
      try {
        offerings = await Purchases.getOfferings();
      } on PlatformException catch (e) {
        await showDialog(
            context: context,
            builder: (BuildContext context) => ShowDialogToDismiss(
                title: "Error", content: e.message!, buttonText: 'OK'));
      }

      setState(() {
        _isLoading = false;
      });

      if (offerings == null || offerings.current == null) {
        // offerings are empty, show a message to your user
      } else {
        // current offering is available, show paywall
        await showModalBottomSheet(
          useRootNavigator: true,
          isDismissible: true,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
                  return Paywall(
                    offering: offerings!.current!,
                  );
                });
          },
        );
      }
    }
  }

  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(Duration(minutes: 15), (Timer t) => openSubscriptionSheetMethod());
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: GetBuilder<Home_page_controller>(builder: (controller) {
          return SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
              AppComponents().sizedBox30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 45,
                        width: 50,
                        child: AppComponents().backIcon(() {
                          Get.back();
                        }),
                      ),
                      Text(
                        "Filters",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 25),
                      ),
                      InkWell(
                        onTap: () {
                          controller.clearAll(context);
                          Get.offAll(() => HomeSwapNew());
                        },
                        child: Text(
                          "Clear",
                          style: TextStyle(
                              color: textcolor,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
              AppComponents().sizedBox20,
              AppComponents().sizedBox20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Text(
                  "Religion",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ),
              AppComponents().sizedBox20,
              buildFilterDropDown(
                  text: "Select Religion",
                  list: kReligionList!,
                  value: controller.selectedReligion == ""
                      ? kReligionList![0]
                      : controller.selectedReligion,
                  onchange: (value) {
                    controller.selectedReligionFunction(value.toString());
                    controller.filterReligion = value.toString();
                    controller.update();
                  },
                  controller: controller),
              AppComponents().sizedBox20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Age",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(controller.filterlowerValue.round().toString() +
                        "-" +
                        controller.filterupperValue.round().toString()),
                  ],
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.only(right: 10),
                child: RangeSliderFlutter(
                  values: [
                    controller.filterlowerValue,
                    controller.filterupperValue
                  ],
                  handler: RangeSliderFlutterHandler(
                      decoration: BoxDecoration(
                          boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300.withOpacity(0.8),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0.5, 0.5))
                      ],
                          color: textcolor,
                          border: Border.all(color: Colors.white, width: 3),
                          shape: BoxShape.circle)),
                  rightHandler: RangeSliderFlutterHandler(
                      child: Text(""),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300.withOpacity(0.8),
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: Offset(0.5, 0.5))
                          ],
                          color: textcolor,
                          border: Border.all(color: Colors.white, width: 3),
                          shape: BoxShape.circle)),
                  tooltip: RangeSliderFlutterTooltip(
                      alwaysShowTooltip: false, disabled: true),
                  trackBar: RangeSliderFlutterTrackBar(
                      activeTrackBarHeight: 6,
                      inactiveTrackBarHeight: 6,
                      activeDisabledTrackBarColor: Colors.grey.shade200,
                      inactiveDisabledTrackBarColor: Colors.grey.shade200,
                      inactiveTrackBar: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(25)),
                      activeTrackBar: BoxDecoration(
                        color: textcolor,
                      )),
                  rangeSlider: true,
                  jump: true,
                  max: 80,
                  min: 18,
                  fontSize: 15,
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    controller.filterlowerValue = lowerValue;
                    controller.filterupperValue = upperValue;
                    log(controller.filterlowerValue.round().toString());
                    controller.update();
                  },
                ),
              ),
              AppComponents().sizedBox20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Distance",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(controller.selectedMilesRange.round().toString() + "km"),
                  ],
                ),
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 6.0,
                  activeTickMarkColor: textcolor,
                  inactiveTickMarkColor: Colors.grey.shade200,
                  trackShape: RoundedRectSliderTrackShape(),
                  activeTrackColor: textcolor,
                  inactiveTrackColor: Colors.grey.shade200,
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 16.0,
                    pressedElevation: 8.0,
                  ),
                  minThumbSeparation: 5,
                  thumbColor: textcolor,
                  overlayColor: Colors.pink.withOpacity(0.2),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 32.0),
                  valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                  valueIndicatorColor: textcolor,
                  valueIndicatorTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                child: Slider(
                    value: controller.selectedMilesRange,
                    onChanged: (value) {
                      controller.selectedMilesRangeFunction(value);
                    },
                    min: 0,
                    max: 3000,
                    divisions: 60,
                    autofocus: true,
                    label: controller.selectedMilesRange.round().toString()),
              ),
                  AppComponents().sizedBox10,
                 appData.entitlementIsActive? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Martial Status",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      AppComponents().sizedBox10,
                      buildFilterDropDown(
                          text: "Select Status",
                          list: kMartial_StatusList!,
                          value: controller.selectedMartialStatus == ""
                              ? kMartial_StatusList![0]
                              : controller.selectedMartialStatus,
                          onchange: (value) {
                            controller.selectedMartialFunction(value.toString());
                            controller.filterMartialStatus = value.toString();
                            controller.update();
                          },
                          controller: controller),
                    ],
                  ) : SizedBox.shrink(),
                  // AppComponents().sizedBox20,
                  // _buildProductList(),
              AppComponents().sizedBox20,
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: kAppButton(
                    buttonText: "Continue",
                    onButtonPressed: () {
                      Get.to(()=> HomeSwapNew());
                    },
                  ),
                ),
              ),
              /* AppComponents().sizedBox20,*/
              /*    Text(
                      "Select Caste is",
                      style: k20styleblack,
                    ),
                    AppComponents().sizedBox10,
                    buildFilterDropDown(
                        text: "Select Caste",
                        list: kcasteList!,
                        value: controller.selectedCaste == ""
                            ? kcasteList![0]
                            : controller.selectedCaste,
                        onchange: (value) {
                          controller.selectedCasteFunction(value.toString());
                          controller.filterCaste = value.toString();
                          controller.update();
                        },
                        controller: controller),*/
              AppComponents().sizedBox20,
              // Text(
              //   "Select City is",
              //   style: k20styleblack,
              // ),
              // AppComponents().sizedBox10,
              /*  buildFilterDropDown(
                        text: "Select City",
                        list: kCityList!,
                        value: controller.selectedCity == ""
                            ? kCityList![0]
                            : controller.selectedCity,
                        onchange: (value) {
                          controller.selectedCityFunction(value.toString());
                          controller.filterCity = value.toString();
                          controller.update();
                          controller.query();
                        },
                        controller: controller),
                    AppComponents().sizedBox20,*/

              /*  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => ChooseYourPlan());
                        },
                        child: DottedBorder(
                          color: Colors.deepOrange,
                          radius: Radius.circular(100),
                          strokeWidth: 2,
                          strokeCap: StrokeCap.butt,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.center,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.deepOrange.withOpacity(0.1),
                            ),
                            child: Text(
                              "Buy plan for Membership Perks, Verified tick, Unlimited Likes, Read Receipts, Advance Preference",
                              style: k14styleblack,
                            ),
                          ),
                        ),
                      ),
                    ),*/
            ]),
          );
        }),
      ),
    ));
  }
// Card _buildConnectionCheckTile() {
//   if (_loading) {
//     return const Card(child: ListTile(title: Text('Trying to connect...')));
//   }
//   final Widget storeHeader = ListTile(
//     leading: Icon(_isAvailable ? Icons.check : Icons.block,
//         color: _isAvailable
//             ? Colors.green
//             : ThemeData.light().colorScheme.error),
//     title:
//     Text('The store is ${_isAvailable ? 'available' : 'unavailable'}.'),
//   );
//   final List<Widget> children = <Widget>[storeHeader];
//
//   if (!_isAvailable) {
//     children.addAll(<Widget>[
//       const Divider(),
//       ListTile(
//         title: Text('Not connected',
//             style: TextStyle(color: ThemeData.light().colorScheme.error)),
//         subtitle: const Text(
//             'Unable to connect to the payments processor. Has this app been configured correctly? See the example README for instructions.'),
//       ),
//     ]);
//   }
//   return Card(child: Column(children: children));
// }
//
//   Widget _buildProductList() {
//   if (_loading) {
//     return ListTile(
//         leading: CircularProgressIndicator(),
//         title: Text('Fetching products...'));
//   }
//   if (!_isAvailable) {
//     return  ListTile();
//   }
//   // const ListTile productHeader = ListTile(title: Text('Products for Sale'));
//   final List<ListTile> productList = <ListTile>[];
//   if (_notFoundIds.isNotEmpty) {
//     productList.add(ListTile(
//         title: Text('[${_notFoundIds.join(", ")}] not found',
//             style: TextStyle(color: ThemeData.light().colorScheme.error)),
//         subtitle: const Text(
//             'This app needs special configuration to run. Please see example/README.md for instructions.')));
//   }
//
//   // This loading previous purchases code is just a demo. Please do not use this as it is.
//   // In your app you should always verify the purchase data using the `verificationData` inside the [PurchaseDetails] object before trusting it.
//   // We recommend that you use your own server to verify the purchase data.
//   final Map<String, PurchaseDetails> purchases =
//   Map<String, PurchaseDetails>.fromEntries(
//       _purchases.map((PurchaseDetails purchase) {
//         if (purchase.pendingCompletePurchase) {
//           _inAppPurchase.completePurchase(purchase);
//         }
//         return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
//       }));
//   productList.addAll(_products.map(
//         (ProductDetails productDetails) {
//       final PurchaseDetails? previousPurchase = purchases[productDetails.id];
//       return ListTile(
//         title: Text(
//           productDetails.title=="Three Month VIP (Jab We Meet)" ? "Buy three months VIP subscription to apply more filters " : "Buy one month VIP subscription to apply more filters ",
//         style: k14styleblackBold,),
//         subtitle: Text(
//           productDetails.description,
//         ),
//         trailing: previousPurchase != null
//             ? IconButton(
//             onPressed: () => confirmPriceChange(context),
//             icon: const Icon(Icons.upgrade))
//             : TextButton(
//           style: TextButton.styleFrom(
//             backgroundColor: textcolor,
//             // TODO(darrenaustin): Migrate to new API once it lands in stable: https://github.com/flutter/flutter/issues/105724
//             // ignore: deprecated_member_use
//             primary: Colors.white,
//           ),
//           onPressed: () {
//             late PurchaseParam purchaseParam;
//
//             if (Platform.isAndroid) {
//               // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
//               // verify the latest status of you your subscription by using server side receipt validation
//               // and update the UI accordingly. The subscription purchase status shown
//               // inside the app may not be accurate.
//               final GooglePlayPurchaseDetails? oldSubscription =
//               _getOldSubscription(productDetails, purchases);
//
//               purchaseParam = GooglePlayPurchaseParam(
//                   productDetails: productDetails,
//                   changeSubscriptionParam: (oldSubscription != null)
//                       ? ChangeSubscriptionParam(
//                     oldPurchaseDetails: oldSubscription,
//                     prorationMode:
//                     ProrationMode.immediateWithTimeProration,
//                   )
//                       : null);
//             } else {
//               purchaseParam = PurchaseParam(
//                 productDetails: productDetails,
//               );
//             }
//
//             if (productDetails.id == _kConsumableId) {
//               _inAppPurchase.buyConsumable(
//                   purchaseParam: purchaseParam,
//                   autoConsume: _kAutoConsume);
//             } else {
//               _inAppPurchase.buyNonConsumable(
//                   purchaseParam: purchaseParam);
//             }
//           },
//           child: Text(productDetails.price.replaceAll(".00",""))
//         ),
//       );
//     },
//   ));
//
//   return DottedBorder(
//     borderType: BorderType.RRect,
//     color: textcolor,
//     child: Column(
//         children:  productList),
//   );
// }
//
// Card _buildConsumableBox() {
//   if (_loading) {
//     return const Card(
//         child: ListTile(
//             leading: CircularProgressIndicator(),
//             title: Text('Fetching consumables...')));
//   }
//   if (!_isAvailable || _notFoundIds.contains(_kConsumableId)) {
//     return const Card();
//   }
//   const ListTile consumableHeader =
//   ListTile(title: Text('Purchased consumables'));
//   final List<Widget> tokens = _consumables.map((String id) {
//     return GridTile(
//       child: IconButton(
//         icon: const Icon(
//           Icons.stars,
//           size: 42.0,
//           color: Colors.orange,
//         ),
//         splashColor: Colors.yellowAccent,
//         onPressed: () => consume(id),
//       ),
//     );
//   }).toList();
//   return Card(
//       child: Column(children: <Widget>[
//         consumableHeader,
//         const Divider(),
//         GridView.count(
//           crossAxisCount: 5,
//           shrinkWrap: true,
//           padding: const EdgeInsets.all(16.0),
//           children: tokens,
//         )
//       ]));
// }
//
// Widget _buildRestoreButton() {
//   if (_loading) {
//     return Container();
//   }
//
//   return Padding(
//     padding: const EdgeInsets.all(4.0),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: <Widget>[
//         TextButton(
//           style: TextButton.styleFrom(
//             backgroundColor: Theme.of(context).primaryColor,
//             // TODO(darrenaustin): Migrate to new API once it lands in stable: https://github.com/flutter/flutter/issues/105724
//             // ignore: deprecated_member_use
//             primary: Colors.white,
//           ),
//           onPressed: () => _inAppPurchase.restorePurchases(),
//           child: const Text('Restore purchases'),
//         ),
//       ],
//     ),
//   );
// }
//
// Future<void> consume(String id) async {
//   await ConsumableStore.consume(id);
//   final List<String> consumables = await ConsumableStore.load();
//   setState(() {
//     _consumables = consumables;
//   });
// }
//
// void showPendingUI() {
//   setState(() {
//     _purchasePending = true;
//   });
// }
//
// Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
//   // IMPORTANT!! Always verify purchase details before delivering the product.
//   if (purchaseDetails.productID == _kConsumableId) {
//     await ConsumableStore.save(purchaseDetails.purchaseID!);
//     final List<String> consumables = await ConsumableStore.load();
//     setState(() {
//       _purchasePending = false;
//       _consumables = consumables;
//     });
//   } else {
//     setState(() {
//       _purchases.add(purchaseDetails);
//       _purchasePending = false;
//     });
//   }
// }
//
// void handleError(IAPError error) {
//   setState(() {
//     _purchasePending = false;
//   });
// }
//
// Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
//   // IMPORTANT!! Always verify a purchase before delivering the product.
//   // For the purpose of an example, we directly return true.
//   return Future<bool>.value(true);
// }
//
// void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
//   // handle invalid purchase here if  _verifyPurchase` failed.
// }
//
// Future<void> _listenToPurchaseUpdated(
//     List<PurchaseDetails> purchaseDetailsList) async {
//   for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
//     if (purchaseDetails.status == PurchaseStatus.pending) {
//       showPendingUI();
//     } else {
//       if (purchaseDetails.status == PurchaseStatus.error) {
//         handleError(purchaseDetails.error!);
//       } else if (purchaseDetails.status == PurchaseStatus.purchased ||
//           purchaseDetails.status == PurchaseStatus.restored) {
//         final bool valid = await _verifyPurchase(purchaseDetails);
//         if (valid) {
//           deliverProduct(purchaseDetails);
//         } else {
//           _handleInvalidPurchase(purchaseDetails);
//           return;
//         }
//       }
//       if (Platform.isAndroid) {
//         if (!_kAutoConsume && purchaseDetails.productID == _kConsumableId) {
//           final InAppPurchaseAndroidPlatformAddition androidAddition =
//           _inAppPurchase.getPlatformAddition<
//               InAppPurchaseAndroidPlatformAddition>();
//           await androidAddition.consumePurchase(purchaseDetails);
//         }
//       }
//       if (purchaseDetails.pendingCompletePurchase) {
//         await _inAppPurchase.completePurchase(purchaseDetails);
//       }
//     }
//   }
// }
//
// Future<void> confirmPriceChange(BuildContext context) async {
//   if (Platform.isAndroid) {
//     final InAppPurchaseAndroidPlatformAddition androidAddition =
//     _inAppPurchase
//         .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
//     final BillingResultWrapper priceChangeConfirmationResult =
//     await androidAddition.launchPriceChangeConfirmationFlow(
//       sku: 'purchaseId',
//     );
//     if (mounted) {
//       if (priceChangeConfirmationResult.responseCode == BillingResponse.ok) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('Price change accepted'),
//         ));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(
//             priceChangeConfirmationResult.debugMessage ??
//                 'Price change failed with code ${priceChangeConfirmationResult.responseCode}',
//           ),
//         ));
//       }
//     }
//   }
//   if (Platform.isIOS) {
//     final InAppPurchaseStoreKitPlatformAddition iapStoreKitPlatformAddition =
//     _inAppPurchase
//         .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
//     await iapStoreKitPlatformAddition.showPriceConsentIfNeeded();
//   }
// }
//
// GooglePlayPurchaseDetails? _getOldSubscription(
//     ProductDetails productDetails, Map<String, PurchaseDetails> purchases) {
//   // This is just to demonstrate a subscription upgrade or downgrade.
//   // This method assumes that you have only 2 subscriptions under a group, 'subscription_silver' & 'subscription_gold'.
//   // The 'subscription_silver' subscription can be upgraded to 'subscription_gold' and
//   // the 'subscription_gold' subscription can be downgraded to 'subscription_silver'.
//   // Please remember to replace the logic of finding the old subscription Id as per your app.
//   // The old subscription is only required on Android since Apple handles this internally
//   // by using the subscription group feature in iTunesConnect.
//   GooglePlayPurchaseDetails? oldSubscription;
//   if (productDetails.id == _kSilverSubscriptionId &&
//       purchases[_kGoldSubscriptionId] != null) {
//     oldSubscription =
//     purchases[_kGoldSubscriptionId]! as GooglePlayPurchaseDetails;
//   } else if (productDetails.id == _kGoldSubscriptionId &&
//       purchases[_kSilverSubscriptionId] != null) {
//     oldSubscription =
//     purchases[_kSilverSubscriptionId]! as GooglePlayPurchaseDetails;
//   }
//   return oldSubscription;
// }
}

// /// Example implementation of the
// /// [`SKPaymentQueueDelegate`](https://developer.apple.com/documentation/storekit/skpaymentqueuedelegate?language=objc).
// ///
// /// The payment queue delegate can be implementated to provide information
// /// needed to complete transactions.
// class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
//   @override
//   bool shouldContinueTransaction(
//       SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
//     return true;
//   }
//
//   @override
//   bool shouldShowPriceConsent() {
//     return false;
//   }
// }

