// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:pay/pay.dart';
//
// class PaymentScreen extends StatelessWidget {
//   PaymentScreen({Key? key}) : super(key: key);
//   List<PaymentItem> paymentItems = [
//     const PaymentItem(
//       label: 'Total',
//       amount: '99.99',
//       status: PaymentItemStatus.final_price,
//     )
//   ];
//   void onGooglePayResult(paymentResult) {
//     debugPrint(paymentResult.toString());
//   }
//
//   void onApplePayResult(paymentResult) {
//     debugPrint(paymentResult.toString());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.grey.shade200,
//         height: MediaQuery.of(context).size.height,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 70),
//             const Center(
//               child: Text(
//                 "Payment",
//                 style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height * 0.3),
//             // kCommonButton(
//             //   label: "PAY",
//             //   ontap: () {
//             //     Navigator.pushNamed(context, routes.createAd);
//             //   },
//             // ),
//             GooglePayButton(
//               // width: 100,
//               // height: 90,
//               onError: (Object? error) {
//                 //debugPrint('error');
//                 log('error is $error');
//               },
//               childOnError: Text('errror'),
//               onPressed: () {
//                 debugPrint('pressed');
//               },
//               paymentConfigurationAsset: "gpay.json",
//               paymentItems: paymentItems,
//               // style: GooglePayButtonStyle.white,
//               type: GooglePayButtonType.buy,
//               margin: const EdgeInsets.only(top: 15.0),
//               onPaymentResult: (data) {},
//               loadingIndicator: const Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//             // GooglePayButton(
//             //   paymentConfigurationAsset: 'gpay.json',
//             //   paymentItems: paymentItems,
//             //   //style: GooglePayButtonStyle.black,
//             //   type: GooglePayButtonType.pay,
//             //   margin: const EdgeInsets.only(top: 15.0),
//             //   onPaymentResult: onGooglePayResult,
//             //   loadingIndicator: const Center(
//             //     child: CircularProgressIndicator(),
//             //   ),
//             // ),
//             // ApplePayButton(
//             //   paymentConfigurationAsset: 'gpay.json',
//             //   paymentItems: paymentItems,
//             //   style: ApplePayButtonStyle.black,
//             //   type: ApplePayButtonType.buy,
//             //   margin: const EdgeInsets.only(top: 15.0),
//             //   onPaymentResult: onApplePayResult,
//             //   loadingIndicator: const Center(
//             //     child: CircularProgressIndicator(),
//             //   ),
//             // )
//           ],
//         ),
//       ),
//     );
//   }
// }
