


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jabwemeet/Services/api/purchase_api.dart';
import 'dart:io' show Platform;

import 'package:purchases_flutter/models/purchases_configuration.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {



  Future<void> initPlatformState() async {
    await Purchases.setDebugLogsEnabled(true);

    PurchasesConfiguration? configuration;
    if (Platform.isAndroid) {
      configuration = PurchasesConfiguration('goog_aYSJTGPsDmGWnKCcwYpeKIGIrqy');

    }
    // else if (Platform.isIOS) {
    //   configuration = PurchasesConfiguration(<public_ios_sdk_key>);
    // }
    await Purchases.configure(configuration!);
    fetchOffer();
  }


  Future fetchOffer() async {
    try {
      Offerings offerings = await Purchases.getOfferings();
      if (offerings.current != null) {
        // Display current offering with offerings.current
        print(offerings.getOffering('jabwemeet_999_1m'));
        print(offerings.getOffering('jabwemeet_1999_3m'));
      }
    } on PlatformException catch (e) {
      // optional error handling
    }
    //
    // final offerings= await PurchaseApi.fetchOffers();
    // if(offerings.isEmpty){
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Plans")));
    // }
    // else{
    //   final offer= offerings.first;
    //   print("something");
    //   print('offer: ${offer}');
    //   final packages=offerings.map((offer) => offer.availablePackages).expand((pair) => pair).toList();
    // }
  }

  purchaseee(Package package)async{
    try {
      CustomerInfo customerInfo = await Purchases.purchasePackage(package);
      var isPro = customerInfo.entitlements.all['jabwemeet_999_1m']!.isActive;
    if (isPro) {
    // Unlock that great "pro" content
    }
    } on PlatformException catch (e) {
    var errorCode = PurchasesErrorHelper.getErrorCode(e);
    if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
    print(e);
    }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    fetchOffer();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("data"),
        ),
      ),
    );
  }
}
