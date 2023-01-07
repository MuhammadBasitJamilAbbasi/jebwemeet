import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Models/plan_model.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:pay/pay.dart';

class ChooseYourPlan extends StatefulWidget {
  const ChooseYourPlan({Key? key}) : super(key: key);

  @override
  State<ChooseYourPlan> createState() => _ChooseYourPlanState();
}

class _ChooseYourPlanState extends State<ChooseYourPlan> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          color: Colors.grey.shade200,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              AppComponents().sizedBox20,
              AppComponents().backIcon(() {
                Get.back();
              }),
              AppComponents().sizedBox20,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Choose Your Plan", style: k20styleblack),
                ],
              ),
              AppComponents().sizedBox10,
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  itemCount: planslist.length,
                  itemBuilder: (context, index) {
                    return kPlanWidget(
                        plan: planslist[index],
                        selectedFunction: () {},
                        color: Colors.white,
                        apple_pay: () {},
                        google_pay: () {});
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class kPlanWidget extends StatefulWidget {
  final PlanModel plan;
  final apple_pay;
  final google_pay;
  final color;
  final selectedFunction;

  kPlanWidget(
      {required this.plan,
      required this.apple_pay,
      required this.google_pay,
      required this.selectedFunction,
      required this.color});

  @override
  State<kPlanWidget> createState() => _kPlanWidgetState();
}

class _kPlanWidgetState extends State<kPlanWidget> {
  List<PaymentItem> paymentItems = [
    const PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];

  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  void onApplePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //  Navigator.pushNamed(context, routes.benefits_of_plan);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: widget.color,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                spreadRadius: 1,
                blurRadius: 0.5,
                offset: const Offset(1, 1),
              )
            ],
            borderRadius: BorderRadius.circular(20)),
        height: 170,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.plan.name!,
                    style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.plan.price} \PKR / ${widget.plan.days} days',
                        style: const TextStyle(
                          color: Colors.grey,
                          //fontFamily: 'Stolzl',
                          fontSize: 13,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            /* Expanded(
              flex: 2,
              child: Text(
                '${widget.plan.description}',
                style: GoogleFonts.roboto(
                    color: Colors.blue,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal),
              ),
            ),*/
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  // Official Google pay button
                  Expanded(
                      child: Platform.isAndroid
                          ? GooglePayButton(
                              // width: 100,
                              // height: 90,
                              onError: (Object? error) {
                                //debugPrint('error');
                                log('error is $error');
                                // User canceled payment authorization
                              },
                              childOnError: Text('errror'),
                              onPressed: () {
                                debugPrint('pressed');
                              },
                              paymentConfigurationAsset: "gpay.json",
                              paymentItems: paymentItems,
                              // style: GooglePayButtonStyle.white,
                              type: GooglePayButtonType.subscribe,
                              margin: const EdgeInsets.only(top: 15.0),
                              onPaymentResult: (data) {
                                log("Payment Result");
                                log(data.toString());
                              },
                              loadingIndicator: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : ApplePayButton(
                              onError: (Object? error) {
                                //debugPrint('error');
                                log('error is $error');
                              },
                              childOnError: const Text('errror'),
                              onPressed: () {
                                debugPrint('pressed');
                              },
                              paymentConfigurationAsset: 'gpay.json',
                              paymentItems: paymentItems,
                              style: ApplePayButtonStyle.black,
                              type: ApplePayButtonType.buy,
                              margin: const EdgeInsets.only(top: 15.0),
                              onPaymentResult: onApplePayResult,
                              loadingIndicator: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )),

                  //Testing Api For Google button
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<PlanModel> planslist = [
  PlanModel(
    name: "Weekly Plan",
    days: "8",
    price: "1000",
    status: "Active",
    id: "1",
  ),
  PlanModel(
    name: "Monthly Plan",
    days: "30",
    price: "3000",
    status: "Active",
    id: "1",
  ),
];
