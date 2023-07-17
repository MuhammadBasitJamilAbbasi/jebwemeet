import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Bindings/Bindings.dart';
import 'package:jabwemeet/Views/Auth/Screens/Splash_Screen.dart';
import 'Services/notification/firebase_notifications/notification_service.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await InAppPurchase.instance.getPlatformAddition();
  // await PurchaseApi.init();
  // await ScreenProtector.protectDataLeakageOn();

  await NotificationService.initialize();
  // Stripe.publishableKey = stripePublishableKey;
  /*============================================*/


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
        initialBinding: InitialBindings(),
        defaultTransition: Transition.noTransition,
        theme: ThemeData(
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: Colors.white,
          backgroundColor: Colors.white,
          fontFamily: "Gotham-Font",
        ),
        debugShowCheckedModeBanner: false,
        home: Splash_Screen(),
        // home: StripePaymentScreen(),
        /*=============================*/
        );
  }
}



/*
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<ProductDetails> _products = [];
  bool _isAvailable = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final bool isAvailable = await InAppPurchase.instance.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = false;
        _isLoading = false;
      });
      return;
    }

    final Set<String> _kIds = <String>{'jabwemeet_999_1m', 'jabwemeet_1999_3m'};
    final ProductDetailsResponse response =
    await InAppPurchase.instance.queryProductDetails(_kIds);

    setState(() {
      _isAvailable = true;
      _isLoading = false;
      _products = response.productDetails;
    });
  }

  void _buyProduct(ProductDetails product) {
    log("<=========_buyProduct call =============>");
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
  }

  void _buySubscription(ProductDetails subscription) async {
    log("<=========_buySubscription call =============>");
    final PurchaseParam purchaseParam = await
    PurchaseParam(productDetails: subscription, applicationUserName: "sajwal", );
    InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam).then((value) =>  log("<========= call complete=============>"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : !_isAvailable
          ? const Center(child: Text('In-App purchase is not available'))
          : ListView.builder(
        itemCount: _products.length,
        itemBuilder: (BuildContext context, int index) {
          final ProductDetails product = _products[index];
          return ListTile(
            title: Text(product.title),
            subtitle: Text(product.description),
            trailing: product.price.isNotEmpty
                ? Text(product.price)
                : null,
            onTap: () => product.price != null
                ? _buySubscription(product)
                : _buyProduct(product),
          );
        },
      ),
    );
  }
}

class MyApppp extends StatefulWidget {
  @override
  _MyAppppState createState() => _MyAppppState();
}

class _MyAppppState extends State<MyApppp> {
  List<ProductDetails> _products = [];

  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  Future<void> _getProductList() async {
    final Set<String> _kIds = <String>{'jabwemeet_999_1m', 'jabwemeet_1999_3m'};
    final ProductDetailsResponse response =
    await InAppPurchase.instance.queryProductDetails(_kIds);
    setState(() {
      _products = response.productDetails;
    });
  }

  Future<void> _buyProduct(ProductDetails product) async {
    final PurchaseParam purchaseParam =
    PurchaseParam(productDetails: product, applicationUserName: "Okay");
    await InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('In-App Purchase Example'),
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (BuildContext context, int index) {
          final ProductDetails product = _products[index];
          return ListTile(
            title: Text(product.title),
            subtitle: Text(product.description),
            trailing: InkWell(
              child: Text(product.price),
              onTap: () => _buyProduct(product),
            ),
          );
        },
      ),
    );
  }
}*/
