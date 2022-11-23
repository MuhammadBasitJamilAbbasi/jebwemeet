import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemeet/Bindings/Bindings.dart';
import 'package:jabwemeet/Views/Auth/Screens/JabWeMetScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  // getlocation();

/*  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));*/
}

// getlocation() async {
//   Position position = await GetLocation.getGeoLocationPosition();
//   Get.find<GetSTorageController>()
//       .box
//       .write(P_LATITUDE, position.latitude.toString());
//   Get.find<GetSTorageController>()
//       .box
//       .write(P_LONGITUDE, position.longitude.toString());
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBindings(),
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: GoogleFonts.montserrat().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      // home: HomePage(),
      home: JabWeMet_Screen(),
    );
  }
}
