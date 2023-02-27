// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:jabwemeet/Components/App_Components.dart';
// import 'package:jabwemeet/Utils/locations.dart';
// import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
// import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';
//
// class kCustomGoogleMap extends StatefulWidget {
//   @override
//   State<kCustomGoogleMap> createState() => _kCustomGoogleMapState();
// }
//
// class _kCustomGoogleMapState extends State<kCustomGoogleMap> {
//   GoogleMapController? mapController;
//
//   final Map<String, Marker> _markers = {};
//   LatLng? center = LatLng(
//       double.parse(Get.find<GetSTorageController>().box.read(P_LATITUDE)),
//       double.parse(Get.find<GetSTorageController>().box.read(P_LONGITUDE)));
//
//   Future? getLocation;
//
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }
//
//   var address = "";
//   var lat = "";
//   var long = "";
//
//   locateMarker(LatLng latLng) async {
//     var current_marker_location =
//         await GetLocation.GetAddressFromLatLong(latLng);
//     var current_street = await GetLocation.GetAddressOfStreat(latLng);
//     var current_locality = await GetLocation.GetAddressOfLoacality(latLng);
//     var current_sublocality =
//         await GetLocation.GetAddressOfSubloacality(latLng);
//     var current_Country = await GetLocation.GetAddressOfCountry(latLng);
//     setState(() {
//       lat = latLng.latitude.toString();
//       long = latLng.longitude.toString();
//       address = current_marker_location;
//       Get.find<RegisterController>().address.value = current_locality;
//       Get.find<GetSTorageController>().box.write("loc", current_locality);
//     });
//   }
//
//   var position;
//   bool isLoading = false;
//   getLocationStart() async {
//     print('Started');
//     position = await Geolocator.getCurrentPosition(
//             desiredAccuracy: LocationAccuracy.high)
//         .then((value) async {
//       setState(() {
//         center = LatLng(value.latitude, value.longitude);
//       });
//     }).catchError((e) {
//       print(e);
//     });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getLocationStart();
//     Get.find<GetSTorageController>()
//         .box
//         .write("loc", GetLocation.GetAddressOfLoacality(position));
//
//     locateMarker(center!);
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     mapController?.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//           child: Stack(
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height - 30,
//                 width: MediaQuery.of(context).size.width,
//                 child: GoogleMap(
//                   onMapCreated: _onMapCreated,
//                   myLocationEnabled: true,
//                   myLocationButtonEnabled: true,
//                   zoomGesturesEnabled: true,
//                   zoomControlsEnabled: true,
//                   mapToolbarEnabled: true,
//                   initialCameraPosition: CameraPosition(
//                     target: center!,
//                     zoom: 15.0,
//                   ),
//                   onTap: (latLang) {
//                     setState(() {
//                       center = latLang;
//                       locateMarker(center!);
//                     });
//                   },
//                   buildingsEnabled: true,
//                   compassEnabled: true,
//                   markers: _markers.values.toSet(),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(18.0),
//                 child: AppComponents().backIcon(() {
//                   Get.back();
//                 }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
