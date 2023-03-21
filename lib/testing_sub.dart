import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:purchases_flutter/purchases_flutter.dart';



final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();

class AppContainer extends StatefulWidget {
  const AppContainer({Key? key}) : super(key: key);

  @override
  AppContainerState createState() => AppContainerState();
}

class AppContainerState extends State<AppContainer> {
  int currentIndex = 0;

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  Future<void> initPlatformState() async {
    // Enable debug logs before calling `configure`.
    await Purchases.setLogLevel(LogLevel.debug);

    /*
    - appUserID is nil, so an anonymous ID will be generated automatically by the Purchases SDK. Read more about Identifying Users here: https://docs.revenuecat.com/docs/user-ids
    - observerMode is false, so Purchases will automatically handle finishing transactions. Read more about Observer Mode here: https://docs.revenuecat.com/docs/observer-mode
    */
    PurchasesConfiguration configuration;
    if (StoreConfig.isForAmazonAppstore()) {
      configuration = AmazonConfiguration(StoreConfig.instance.apiKey)
        ..appUserID = null
        ..observerMode = false;
    } else {
      configuration = PurchasesConfiguration(StoreConfig.instance.apiKey)
        ..appUserID = null
        ..observerMode = false;
    }
    await Purchases.configure(configuration);

    appData.appUserID = await Purchases.appUserID;

    Purchases.addCustomerInfoUpdateListener((customerInfo) async {
      appData.appUserID = await Purchases.appUserID;

      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      (customerInfo.entitlements.all[entitlementID] != null &&
          customerInfo.entitlements.all[entitlementID]!.isActive || customerInfo.entitlements.all[entitlementID2] != null &&
          customerInfo.entitlements.all[entitlementID2]!.isActive)
          ? appData.entitlementIsActive = true
          : appData.entitlementIsActive = false;

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: kColorBar,
      tabBar: CupertinoTabBar(
        backgroundColor: kColorBar,
        activeColor: kColorAccent,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.wb_sunny,
              size: 24.0,
            ),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_rounded,
              size: 24.0,
            ),
            label: 'User',
          ),
        ],
        onTap: (index) {
          // back home only if not switching tab
          if (currentIndex == index) {
            switch (index) {
              case 0:
                firstTabNavKey.currentState!.popUntil((r) => r.isFirst);
                break;
              case 1:
                secondTabNavKey.currentState!.popUntil((r) => r.isFirst);
                break;
            }
          }
          currentIndex = index;
        },
      ),
      tabBuilder: (context, index) {
        if (index == 0) {
          return CupertinoTabView(
            navigatorKey: firstTabNavKey,
            builder: (BuildContext context) =>  WeatherScreen(),
          );
        } else {
          return CupertinoTabView(
            navigatorKey: secondTabNavKey,
            builder: (BuildContext context) =>  UserScreen(),
          );
        }
      },
    );
  }
}


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


class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool _isLoading = false;

  /*
    We should check if we can magically change the weather
    (subscription active) and if not, display the paywall.
  */
  void openSubscriptionSheetMethod() async {
    setState(() {
      _isLoading = true;
    });

    CustomerInfo customerInfo = await Purchases.getCustomerInfo();

    if (customerInfo.entitlements.all[entitlementID] != null &&
        customerInfo.entitlements.all[entitlementID]!.isActive == true ||  customerInfo.entitlements.all[entitlementID2] != null &&
        customerInfo.entitlements.all[entitlementID2]!.isActive == true) {
      appData.currentData = WeatherData.generateData();

      setState(() {
        _isLoading = false;
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
          backgroundColor: kColorBackground,
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openSubscriptionSheetMethod();
  }

  @override
  Widget build(BuildContext context) {
    return TopBar(
        text: "✨ Magic Weather",
        style: kTitleTextStyle,
        uniqueHeroTag: 'weather',
        child: Scaffold(
          backgroundColor: appData.currentData.weatherColor,
          body:  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "${appData.currentData.emoji}\n${appData.currentData.temperature}°${appData.currentData.unit.toString().split('.')[1].toUpperCase()}",
                          textAlign: TextAlign.center,
                          style: kDescriptionTextStyle.copyWith(
                              fontSize: kFontSizeLarge),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.near_me),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                    appData.currentData.environment
                                        .toString()
                                        .split('.')[1]
                                        .toUpperCase(),
                                    style: kDescriptionTextStyle.copyWith(
                                        fontSize: kFontSizeMedium,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: TextButton(
                    onPressed: () => openSubscriptionSheetMethod(),
                    child: Text(
                      "✨ Change the Weather",
                      style: kDescriptionTextStyle.copyWith(
                          fontSize: kFontSizeMedium,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
        ));
  }
}
class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  _manageUser(String task, String newAppUserID) async {
    setState(() {
      _isLoading = true;
    });

    /*
      How to login and identify your users with the Purchases SDK.

      Read more about Identifying Users here: https://docs.revenuecat.com/docs/user-ids
    */

    try {
      if (task == "login") {
        await Purchases.logIn(newAppUserID);
      } else if (task == "logout") {
        await Purchases.logOut();
      } else if (task == "restore") {
        await Purchases.restorePurchases();
      }

      appData.appUserID = await Purchases.appUserID;
    } on PlatformException catch (e) {
      await showDialog(
          context: context,
          builder: (BuildContext context) => ShowDialogToDismiss(
              title: "Error", content: e.message!, buttonText: 'OK'));
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TopBar(
        text: "User",
        style: kTitleTextStyle,
        uniqueHeroTag: 'user',
        child: Scaffold(
          backgroundColor: kColorBackground,
          body:  SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 32.0, right: 8.0, left: 8.0, bottom: 8.0),
                      child: Text(
                        'Current User Identifier',
                        textAlign: TextAlign.center,
                        style: kTitleTextStyle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      appData.appUserID ?? '',
                      textAlign: TextAlign.center,
                      style: kDescriptionTextStyle,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        top: 24.0, bottom: 8.0, left: 8.0, right: 8.0),
                    child: Text(
                      'Subscription Status',
                      textAlign: TextAlign.center,
                      style: kTitleTextStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      appData.entitlementIsActive == true
                          ? 'Active'
                          : 'Not Active',
                      textAlign: TextAlign.center,
                      style: kDescriptionTextStyle.copyWith(
                          color: (appData.entitlementIsActive == true)
                              ? kColorSuccess
                              : kColorError),
                    ),
                  ),
                  Visibility(
                    visible: appData.appUserID.contains("RCAnonymousID:"),
                    child: const Padding(
                      padding: EdgeInsets.only(
                          top: 24.0, bottom: 8.0, left: 8.0, right: 8.0),
                      child: Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style: kTitleTextStyle,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: appData.appUserID.contains("RCAnonymousID:"),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          style: kDescriptionTextStyle,
                          onSubmitted: (value) {
                            if (value != '') _manageUser('login', value);
                          },
                          decoration: userInputDecoration),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Column(
                      children: [
                        Visibility(
                          visible:
                          !appData.appUserID.contains("RCAnonymousID:"),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              onPressed: () {
                                _manageUser('logout', "null");
                              },
                              child: Text(
                                "Logout",
                                style: kDescriptionTextStyle.copyWith(
                                    fontSize: kFontSizeMedium,
                                    fontWeight: FontWeight.bold,
                                    color: kColorError),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            onPressed: () {
                              _manageUser('restore', "null");
                            },
                            child: Text(
                              "Restore Purchases",
                              style: kDescriptionTextStyle.copyWith(
                                  fontSize: kFontSizeMedium,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ));
  }
}


class TopBar extends StatelessWidget {
  final String text;

  final TextStyle style;
  final String uniqueHeroTag;
  final Widget child;

  const TopBar({
    Key? key,
    required this.text,
    required this.style,
    required this.uniqueHeroTag,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      return Scaffold(
        backgroundColor: kColorBar,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: kColorText,
          ),
          backgroundColor: kColorBar,
          title: Text(
            text,
            style: style,
          ),
        ),
        body: child,
      );
    } else {
      return CupertinoPageScaffold(
        backgroundColor: kColorBar,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: kColorBar,
          heroTag: uniqueHeroTag,
          border: null,
          transitionBetweenRoutes: false,
          middle: Text(
            text,
            style: style,
          ),
        ),
        child: child,
      );
    }
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

// Weather Colors
const kWeatherReallyCold = Color.fromRGBO(3, 75, 132, 1);
const kWeatherCold = Color.fromRGBO(0, 39, 96, 1);
const kWeatherCloudy = Color.fromRGBO(51, 0, 58, 1);
const kWeatherSunny = Color.fromRGBO(212, 70, 62, 1);
const kWeatherHot = Color.fromRGBO(181, 0, 58, 1);
const kWeatherReallyHot = Color.fromRGBO(204, 0, 58, 1);

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
  WeatherData currentData = WeatherData.testCold;

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

class WeatherData {
  String emoji;
  Color weatherColor;
  String temperature;
  TemperatureUnit unit;
  Environment environment;

  WeatherData(
      {required this.emoji,
        required this.weatherColor,
        required this.temperature,
        required this.unit,
        required this.environment});

  static WeatherData testCold = WeatherData(
      emoji: "🥶",
      weatherColor: kWeatherReallyCold,
      temperature: "14",
      unit: TemperatureUnit.f,
      environment: Environment.earth);

  static generateData() {
    const int min = -20;
    const int max = 120;
    final num randomTemperature = min + (Random().nextInt(max - min));

    String temperature = randomTemperature.toString();
    String emoji = "🥶";
    Color weatherColor = kWeatherReallyCold;

    if (randomTemperature < 0) {
      emoji = "🥶";
      weatherColor = kWeatherReallyCold;
    } else if (randomTemperature < 32) {
      emoji = "❄️";
      weatherColor = kWeatherCold;
    } else if (randomTemperature < 60) {
      emoji = "☁️";
      weatherColor = kWeatherCloudy;
    } else if (randomTemperature < 90) {
      emoji = "🌤";
      weatherColor = kWeatherSunny;
    } else if (randomTemperature < 129) {
      emoji = "🥵";
      weatherColor = kWeatherHot;
    } else {
      emoji = "☄️";
      weatherColor = kWeatherReallyHot;
    }

    return WeatherData(
        emoji: emoji,
        weatherColor: weatherColor,
        temperature: temperature,
        unit: TemperatureUnit.f,
        environment: Environment.earth);
  }
}







