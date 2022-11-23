import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jabwemeet/Models/Explore_page_model.dart';
import 'package:jabwemeet/Models/Listing_model.dart';
import 'package:jabwemeet/Utils/constants.dart';

const String INTERNETDISCONNECTIONTEXT = 'Check Your Internet Connection';

showToast(String message) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: primarycolor,
    textColor: Colors.white,
    fontSize: 14,
  );
}

Future<bool> isNetworkAvailable() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

class Functions {
  static String idGenerator() {
    //generate unique number
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }

  static String? kBmBformatter(String currentBalance) {
    try {
      // suffix = {' ', 'k', 'M', 'B', 'T', 'P', 'E'};
      double value = double.parse(currentBalance);
      print(value);
      if (value.isNegative) {
        if (value > -1000) {
          print("negative hey");
          // less than a million
          return value.toInt().toStringAsFixed(0);
        } else if (value <= -1000 && value > (-1000 * 10 * 100)) {
          // less than
          double result = value / 1000;
          // var resultint=result.toInt();
          return result.toStringAsFixed(1) + "K";
        }
        if (value > -1000000) {
          // less than a million
          return value.toStringAsFixed(1);
        } else if (value <= -1000000 && value > (-1000000 * 10 * 100)) {
          // less than 100 million as
          double result = value / 1000000;
          return result.toStringAsFixed(1) + "M";
        } else if (value >= (1000000 * 10 * 100) &&
            value < (1000000 * 10 * 100 * 100)) {
          // less than 100 billion
          double result = value / (1000000 * 10 * 100);
          return result.toStringAsFixed(1) + "B";
        } else if (value >= (1000000 * 10 * 100 * 100) &&
            value < (1000000 * 10 * 100 * 100 * 100)) {
          // less than 100 trillion
          double result = value / (1000000 * 10 * 100 * 100);
          return result.toStringAsFixed(1) + "T";
        }
      }

      ///FROM HERE
      if (value < 1000) {
        // less than a million
        return value.toInt().toStringAsFixed(0);
      } else if (value >= 1000 && value < (1000 * 10 * 100)) {
        // less than
        double result = value / 1000;
        // var resultint=result.toInt();
        return result.toStringAsFixed(1) + "K";
      }
      if (value < 1000000) {
        // less than a million
        return value.toStringAsFixed(1);
      } else if (value >= 1000000 && value < (1000000 * 10 * 100)) {
        // less than 100 million
        double result = value / 1000000;
        return result.toStringAsFixed(1) + "M";
      } else if (value >= (1000000 * 10 * 100) &&
          value < (1000000 * 10 * 100 * 100)) {
        // less than 100 billion
        double result = value / (1000000 * 10 * 100);
        return result.toStringAsFixed(1) + "B";
      } else if (value >= (1000000 * 10 * 100 * 100) &&
          value < (1000000 * 10 * 100 * 100 * 100)) {
        // less than 100 trillion
        double result = value / (1000000 * 10 * 100 * 100);
        return result.toStringAsFixed(1) + "T";
      }
    } catch (e) {
      print(e);
    }
  }

  static String? twodigitformatter(String currentBalance) {
    try {
      // suffix = {' ', 'k', 'M', 'B', 'T', 'P', 'E'};
      double value = double.parse(currentBalance);
      if (value < 100) {
        // less than a million
        return value.toDouble().toStringAsFixed(2);
      } else if (value >= 1000 && value < (1000 * 10 * 100)) {
        // less than
        double result = value / 1000;
        // var resultint=result.toInt();
        return result.toStringAsFixed(1) + "K";
      }
      if (value < 1000000) {
        // less than a million
        return value.toStringAsFixed(1);
      } else if (value >= 1000000 && value < (1000000 * 10 * 100)) {
        // less than 100 million
        double result = value / 1000000;
        return result.toStringAsFixed(1) + "M";
      } else if (value >= (1000000 * 10 * 100) &&
          value < (1000000 * 10 * 100 * 100)) {
        // less than 100 billion
        double result = value / (1000000 * 10 * 100);
        return result.toStringAsFixed(1) + "B";
      } else if (value >= (1000000 * 10 * 100 * 100) &&
          value < (1000000 * 10 * 100 * 100 * 100)) {
        // less than 100 trillion
        double result = value / (1000000 * 10 * 100 * 100);
        return result.toStringAsFixed(1) + "T";
      }
    } catch (e) {
      print(e);
    }
  }

  static String convert_to_DateTime(String datetime) {
    if (datetime.toString() == "" ||
        datetime.toString() == "null" ||
        datetime.toString() == "No-Api-Data") {
      return "";
    }
    print("Formatting ${datetime}");

    DateTime time = DateTime.parse(datetime);
    return time.toIso8601String();
  }

  static String formate_Date(String datetime) {
    if (datetime.toString() == "" || datetime.toString() == "null") {
      return "";
    }

    DateTime time = DateTime.parse(datetime);
    String formattedDate = DateFormat.yMMMMd().format(time);
    return formattedDate.toString();
  }

  static String formate_DateTime(String datetime) {
    if (datetime.toString() == "" || datetime.toString() == "null") {
      return "";
    }
    DateTime time = DateTime.parse(datetime);
    String Day = "EEE"..toString().toUpperCase();
    String formattedDate =
        DateFormat('${Day.toUpperCase()} d MMM y').format(time);

    return formattedDate.toUpperCase();
  }

  static String calculateAge(String datetime) {
    try {
      DateTime time = DateTime.parse(datetime);
      DateTime now = DateTime.now();
      int val = now.difference(time).inDays ~/ 365;
      return val.toString();
    } catch (e) {
      return "";
    }
  }

  static String? checkDateToday(String dateString) {
    //  example, dateString = "2020-01-26";

    DateTime checkedTime = DateTime.parse(dateString);
    DateTime currentTime = DateTime.now();

    if ((currentTime.year == checkedTime.year) &&
        (currentTime.month == checkedTime.month) &&
        (currentTime.day == checkedTime.day)) {
      return "TODAY";
    } else if ((currentTime.year == checkedTime.year) &&
        (currentTime.month == checkedTime.month)) {
      if ((checkedTime.day - currentTime.day) == 1) {
        return "YESTERDAY";
      } else if ((currentTime.day - checkedTime.day) == -1) {
        return "TOMORROW";
      } else {
        return "";
      }
    } else {
      return "";
    }
  }

  static Datum convertListingToDatum(Listing listing) {
    Map<String, dynamic> map = listing.toJson();
    Datum.fromJson(map);
    return Datum.fromJson(map);
  }

  static Listing convertDatumToListing(Datum listing) {
    Map<String, dynamic> map = listing.toJson();

    return Listing.fromJson(map);
  }

/*
  static String convertoTimeAgo(int timestap) {
  if(timestap == ""){
  return "";
  }
  print("converting $timestap");
  try {
  var date = DateTime.fromMillisecondsSinceEpoch(timestap * 1000);
  var result = GetTimeAgo.parse(date);
  // print("ago wala");
  // print(result);
  return result.toString();
  } catch (e) {
  print(e);
  return "";
  }
  }
*/

/*
  static String convertoTimeAgo2(int timestap) {
  if(timestap == ""){
  return "";
  }
  print("converting $timestap");
  try {
  var date = DateTime.fromMillisecondsSinceEpoch(timestap);
  var result = GetTimeAgo.parse(date);
  // print("ago wala");
  // print(result);
  return result.toString();
  } catch (e) {
  print(e);
  return "";
  }
  }
*/

  static String convertoDateTime(int timestap) {
    if (timestap == 0) {
      return "";
    }
    try {
      var date = DateTime.fromMillisecondsSinceEpoch(timestap * 1000);
      var result = DateFormat("DD/MM/yyyy").format(date);
      return result.toString();
    } catch (e) {
      return "";
    }
  }

  static String calculateAgeByDateTime(DateTime datetime) {
    try {
      DateTime now = DateTime.now();
      int val = now.difference(datetime).inDays ~/ 365;
      return val.toString();
    } catch (e) {
      return "";
    }
  }
}

class PreloaderCircular extends StatelessWidget {
  final double size;

  final Color preloaderColor;
  final Color bgColor;

  const PreloaderCircular({
    this.size = 64,
    this.bgColor = Colors.white,
    this.preloaderColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.all(20),
        child: Theme(
          data: ThemeData(accentColor: Colors.red),
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Get.theme.primaryColor,
            backgroundColor: Colors.grey.shade100,
          ),
        ),
      ),
    );
  }
}
