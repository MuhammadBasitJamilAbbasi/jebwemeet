import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

const String P_LATITUDE = "latitude";
const String P_LONGITUDE = "longitude";
const String P_ADDRESS = "address";
const String P_BUSINESS_ID = "business_id";

class GetLocation {
  String location = 'Null, Press Button';

  static Future<Position> getPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  static Future<String> GetAddressFromLatLong(position) async {
    String Address = 'search';
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    // Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}';
    return Address;
  }

  static Future<String> GetAddressOfStreat(position) async {
    String Address = 'search';
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    // Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    Address = '${place.street}';
    return Address;
  }

  static Future<String> GetAddressOfSubloacality(position) async {
    String Address = 'search';
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    // Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    Address = '${place.subLocality}';
    return Address;
  }

  static Future<String> GetAddressOfLoacality(position) async {
    String Address = 'search';
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    // Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    Address = '${place.locality}';
    return Address;
  }

  static Future<String> GetAddressOfCountry(position) async {
    String Address = 'search';
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    // Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    Address = '${place.country}';
    return Address;
  }

  static Future<String> GetAddressFromLatLong2(lat, long) async {
    String Address = 'search';
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    print(placemarks);
    Placemark place = placemarks[0];
    // Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    Address = '${place.street}, ${place.locality} ${place.country}';
    return Address;
  }

  static DistanceInMeters(double a, double b, double x, double z) {
    return Geolocator.distanceBetween(a, b, x, z);
  }
}
