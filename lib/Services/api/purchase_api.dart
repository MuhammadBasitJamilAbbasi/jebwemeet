import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseApi {
  // static const _apikey='goog_aYSJTGPsDmGWnKCcwYpeKIGIrqy';
  static const _apikey='goog_aYSJTGPsDmGWnKCcwYpeKIGIrqy';
  static Future init() async{
    await Purchases.setLogLevel(LogLevel.debug);
    await PurchasesConfiguration(_apikey);
    await PurchaseApi.fetchOffers();
  }

  static Future<List<Offering>> fetchOffers() async{
    try{
      final offerings= await Purchases.getOfferings();
      final current= offerings.current;
      print("<================= Purchase Api ==============>");
      print(current!.availablePackages);
      return current ==null ? [] : [current];
    } on PlatformException catch (e){
      return [];
    }
  }
  static Future<bool> purchasePackage(Package package)async{
    try{
      await Purchases.purchasePackage(package);
      return true;
    }
    catch(e){
      print("Error");
      print(e.toString());
      return false;
    }
  }

}