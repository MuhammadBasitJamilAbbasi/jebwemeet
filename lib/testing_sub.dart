import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class Paywall extends StatefulWidget {
  final Offering offering;

  const Paywall({Key? key, required this.offering}) : super(key: key);

  @override
  _PaywallState createState() => _PaywallState();
}

class _PaywallState extends State<Paywall> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Wrap(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  height: 70.0,
                  width: double.infinity,
                  decoration:  BoxDecoration(
                      color: textcolor,
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.0))),
                  child: const Center(
                      child:
                      Text('✨ Jab We Meet Premium', style: TextStyle( fontWeight: FontWeight.bold,
                        fontSize: kFontSizeMedium,color: Colors.white))),
                ),
                Container(
                  height: 70.0,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.clear,color: Colors.white,))
                  ],),
                ),
              ],
            ),
            Container(
              height: 20,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(""),
            ),
            ListView.builder(
              itemCount: widget.offering.availablePackages.length,
              itemBuilder: (BuildContext context, int index) {
                var myProductList = widget.offering.availablePackages;
                return Card(
                  color: Colors.white,
                  child: ListTile(
                      onTap: () async {
                        try {
                          await Purchases.purchasePackage(
                              myProductList[index]).then((customerInfo) {
                            print("Check");
                            // appData.entitlementIsActive = customerInfo
                            //     .entitlements.all[entitlementID]!.isActive;
                            (customerInfo.entitlements.all[entitlementID] != null &&
                                customerInfo.entitlements.all[entitlementID]!.isActive || customerInfo.entitlements.all[entitlementID2] != null &&
                                customerInfo.entitlements.all[entitlementID2]!.isActive)
                                ? appData.entitlementIsActive = true
                                : appData.entitlementIsActive = false;
                            print("<===== SubScription");
                            print(customerInfo.activeSubscriptions.length);
                            if(customerInfo.activeSubscriptions.length>0){
                              appData.entitlementIsActive = true;
                            }
                            else{
                              appData.entitlementIsActive = false;
                            }
                            setState(() {});
                            print(customerInfo.activeSubscriptions.length);
                            print("<==========  " +appData.entitlementIsActive.toString() +" ============>");
                            Navigator.pop(context);
                          });

                        } on PlatformException catch (e) {
                          print(e);
                          print(e.message);
                          print("<==================Error=======================>");
                         if(e.toString().contains("ProductAlreadyPurchasedError")){
                           print("Already Purchased");
                         }

                          setState(() {});
                          Navigator.pop(context);
                        }

                      },
                      title: Text(
                        myProductList[index].storeProduct.title=="One Month VIP (Jab We Meet)"? "One Month VIP": "Three Months VIP ",
                        style: kTitleTextStyle,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                            myProductList[index].storeProduct.title=="One Month VIP (Jab We Meet)"? "Buy one month VIP subscription to chat with others, apply more filters, liking unlimited profiles ": "Buy three months VIP subscription to chat with others, apply more filters, liking unlimited profiles",
                          style: kDescriptionTextStyle.copyWith(
                              fontSize: kFontSizeSuperSmall),
                        ),
                      ),
                      trailing: Text(
                          myProductList[index].storeProduct.priceString.replaceAll(".00",""),
                          style: kTitleTextStyle)),
                );
              },
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
            ),
             Padding(
              padding:
              EdgeInsets.only(top: 32, bottom: 16, left: 16.0, right: 16.0),
              child: SizedBox(
                child: Text(
                  "",
                  style: kDescriptionTextStyle,
                ),
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShowDialogToDismiss extends StatelessWidget {
  final String content;
  final String title;
  final String buttonText;

  const ShowDialogToDismiss(
      {Key? key, required this.title, required this.buttonText, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      return AlertDialog(
        title: Text(
          title,
        ),
        content: Text(
          content,
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              buttonText,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    } else {
      return CupertinoAlertDialog(
          title: Text(
            title,
          ),
          content: Text(
            content,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(
                buttonText[0].toUpperCase() +
                    buttonText.substring(1).toLowerCase(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ]);
    }
  }
}


enum Store { appleStore, googlePlay, amazonAppstore }

class StoreConfig {
  final Store store;
  final String apiKey;
  static StoreConfig? _instance;

  factory StoreConfig({required Store store, required String apiKey}) {
    _instance ??= StoreConfig._internal(store, apiKey);
    return _instance!;
  }

  StoreConfig._internal(this.store, this.apiKey);

  static StoreConfig get instance {
    return _instance!;
  }

  static bool isForAppleStore() => _instance!.store == Store.appleStore;

  static bool isForGooglePlay() => _instance!.store == Store.googlePlay;

  static bool isForAmazonAppstore() => _instance!.store == Store.amazonAppstore;
}

//TO DO: add the entitlement ID from the RevenueCat dashboard that is activated upon successful in-app purchase for the duration of the purchase.
const entitlementID = 'jabwemeet_999_1m';
const entitlementID2 = 'jabwemeet_1999_3m';

//TO DO: add your subscription terms and conditions
const footerText =
"""Don't forget to add your subscription terms and conditions. 
Read more about this here: https://www.revenuecat.com/blog/schedule-2-section-3-8-b""";

//TO DO: add the Apple API key for your app from the RevenueCat dashboard: https://app.revenuecat.com
const appleApiKey = 'appl_api_key';

//TO DO: add the Google API key for your app from the RevenueCat dashboard: https://app.revenuecat.com
const googleApiKey = 'goog_aYSJTGPsDmGWnKCcwYpeKIGIrqy';

//TO DO: add the Amazon API key for your app from the RevenueCat dashboard: https://app.revenuecat.com
const amazonApiKey = 'amazon_api_key';

// UI Colors
const kColorBar = Color(0xFfc0c0c0);
const kColorText = Colors.black;
const kColorAccent = Color.fromRGBO(10, 115, 217, 1.0);
const kColorError = Colors.red;
const kColorSuccess = Colors.green;
const kColorNavIcon = Color.fromRGBO(131, 136, 139, 1.0);
const kColorBackground = Color.fromRGBO(30, 28, 33, 1.0);


// Text Styles
const kFontSizeSuperSmall = 12.0;
const kFontSizeNormal = 16.0;
const kFontSizeMedium = 18.0;
const kFontSizeLarge = 96.0;

const kDescriptionTextStyle = TextStyle(
  color: kColorText,
  fontWeight: FontWeight.normal,
  fontSize: kFontSizeNormal,
);

const kTitleTextStyle = TextStyle(
  color: kColorText,
  fontWeight: FontWeight.bold,
  fontSize: kFontSizeMedium,
);

// Inputs
const kButtonRadius = 10.0;

const userInputDecoration = InputDecoration(
  fillColor: Colors.black,
  filled: true,
  hintText: 'Enter App User ID',
  hintStyle: TextStyle(color: kColorText),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(kButtonRadius)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 0),
    borderRadius: BorderRadius.all(Radius.circular(kButtonRadius)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(kButtonRadius)),
  ),
);


class AppData {
  static final AppData _appData = AppData._internal();

  bool entitlementIsActive = false;
  String appUserID = '';

  factory AppData() {
    return _appData;
  }
  AppData._internal();
}

final appData = AppData();

enum TemperatureUnit { f, c }

enum Environment {
  mercury,
  venus,
  earth,
  mars,
  jupiter,
  saturn,
  uranus,
  neptune,
  pluto
}








