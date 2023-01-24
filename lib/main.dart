import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemeet/Bindings/Bindings.dart';
import 'package:jabwemeet/Views/Auth/Screens/onboarding2.dart';

import 'Services/notification/firebase_notifications/notification_service.dart';
import 'Utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  /* Code Added By Kamran*/
  await NotificationService.initialize();
  Stripe.publishableKey = stripePublishableKey;
  /*============================================*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialBinding: InitialBindings(),
        theme: ThemeData(
          primarySwatch: Colors.red,
          fontFamily: "Gotham-Font",
        ),
        debugShowCheckedModeBanner: false,
        home: OnboardingScreen()
        // home: StripePaymentScreen(),
        /*=============================*/
        );
  }
}
