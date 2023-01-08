import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../Utils/constants.dart';

class StripePaymentScreen extends StatefulWidget {
  const StripePaymentScreen({Key? key}) : super(key: key);

  @override
  State<StripePaymentScreen> createState() => _StripePaymentScreenState();
}

class _StripePaymentScreenState extends State<StripePaymentScreen> {
  /*
  1: First Create Payment Intent.
  2: Then on that basis create Payment Request
  */
  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: context.height * 1,
          width: context.width * 1,
          child: ListView(shrinkWrap: true, children: [
            ElevatedButton(
              onPressed: () async {
                await makePayment();
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(context.width * 0.8, 70),
                backgroundColor: Colors.orange,
              ),
              child: const Text("Pay With Flutter Stripe",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Colors.black)),
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent('10', 'USD');
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
                  // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
                  style: ThemeMode.light,
                  merchantDisplayName: 'Kamran'))
          .then((value) {});

      ///Now Finally Display Payment Sheet
      displayPaymentSheet();
    } catch (e, s) {
      log('exception:$e $s');
    }
  }

  // Display Payment Sheet Method
  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Payment Successful"),
                        ],
                      ),
                    ],
                  ),
                ));
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));
        /*
        Set the PaymentIntent to null Again so that same
        intent won't be used for the different Payments Again.
        */
        paymentIntent = null;
      }).onError((error, stackTrace) {
        log('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      log('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (ex) {
      log('$ex');
    }
  }

  // This Method Creates The Intent For Payment
  // Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    //Creating Request to the Server. That is why we are using HTTP Request.
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $stripeSecretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      log('Payment Intent Body->>> ${response.body.toString()}');
      log("Testing");
      return jsonDecode(response.body);
    } on StripeException catch (ex) {
      log('err charging user: ${ex.toString()}');
    }
  }

/*
  Since Stripe Amount Works in Scents hence
  we are converting String into the Int
*/
  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }
}
