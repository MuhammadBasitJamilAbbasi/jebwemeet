import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Home/Controllers/home_page_controller.dart';
import 'package:jabwemeet/Views/Home/Screens/Home/new_home_swapable.dart';
import 'package:jabwemeet/Views/Home/Screens/Home/plan_subscription.dart';
import 'package:range_slider_flutter/range_slider_flutter.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final controller = Get.find<Home_page_controller>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Home_page_controller>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppComponents().sizedBox30,
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Filters",
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 25),

                        ),
                      ],
                    ),
                   Positioned(
                     top: 8,
                     right: 15,
                     child: InkWell(
                     onTap: () {
                       controller.clearAll(context);
                       Get.offAll(()=> HomeSwapNew());
                     },
                     child: Text(
                       "Clear",
                       style: TextStyle(color: textcolor,fontWeight: FontWeight.w700,fontSize: 16),
                     ),
                   ),)
                  ],
                ),
                AppComponents().sizedBox20,
                AppComponents().sizedBox20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: Text(
                    "Religion",
                    style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w700),
                  ),
                ),
                AppComponents().sizedBox20,
                buildFilterDropDown(
                    text: "Select Religion",
                    list: kReligionList!,
                    value: controller.selectedReligion == ""
                        ? kReligionList![0]
                        : controller.selectedReligion,
                    onchange: (value) {
                      controller.selectedReligionFunction(value.toString());
                      controller.filterReligion = value.toString();
                      controller.update();
                    },
                    controller: controller),
                AppComponents().sizedBox20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Age",
                        style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w700),
                      ),
                      Text(controller.filterlowerValue.round().toString()+"-"+controller.filterupperValue.round().toString()),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: RangeSliderFlutter(
                    values: [
                      controller.filterlowerValue,
                      controller.filterupperValue
                    ],
                    handler: RangeSliderFlutterHandler(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300.withOpacity(0.8),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0.5,0.5)
                          )
                        ],
                        color: textcolor,
                        border:Border.all(color: Colors.white,width: 3),
                        shape: BoxShape.circle
                      )
                    ),
                    rightHandler: RangeSliderFlutterHandler(
                      child: Text(""),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300.withOpacity(0.8),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                  offset: Offset(0.5,0.5)
                              )
                            ],
                            color: textcolor,
                            border:Border.all(color: Colors.white,width: 3),
                            shape: BoxShape.circle
                        )
                    ),

                    tooltip: RangeSliderFlutterTooltip(
                      alwaysShowTooltip: false,
                      disabled: true
                    ),
                    trackBar: RangeSliderFlutterTrackBar(
                      activeTrackBarHeight: 6,
                      inactiveTrackBarHeight: 6,
                      activeDisabledTrackBarColor:Colors.grey.shade200 ,
                      inactiveDisabledTrackBarColor: Colors.grey.shade200,
                      inactiveTrackBar: BoxDecoration(
                        color:Colors.grey.shade200  ,
                        borderRadius: BorderRadius.circular(25)
                      ),
                      activeTrackBar: BoxDecoration(
                        color: textcolor,
                      )
                    ),
                    rangeSlider: true,
                    jump: true,
                    max: 80,
                    min: 18,
                    fontSize: 15,
                    onDragging: (handlerIndex, lowerValue, upperValue) {
                      controller.filterlowerValue = lowerValue;
                      controller.filterupperValue = upperValue;
                      log(controller.filterlowerValue.round().toString());
                      controller.update();
                    },
                  ),
                ),
                AppComponents().sizedBox20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Distance",
                        style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w700),
                      ),
                      Text(controller.selectedMilesRange.round().toString()+"km"),
                    ],
                  ),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 6.0,
                    activeTickMarkColor: textcolor,
                    inactiveTickMarkColor: Colors.grey.shade200,
                    trackShape: RoundedRectSliderTrackShape(),
                    activeTrackColor: textcolor,
                    inactiveTrackColor: Colors.grey.shade200,
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: 16.0,
                      pressedElevation: 8.0,
                    ),
                    minThumbSeparation: 5,
                    thumbColor: textcolor,
                    overlayColor: Colors.pink.withOpacity(0.2),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 32.0),
                    valueIndicatorShape: PaddleSliderValueIndicatorShape(
                    ),
                    valueIndicatorColor: textcolor,
                    valueIndicatorTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  child: Slider(
                    value: controller.selectedMilesRange,
                    onChanged: (value) {
                      controller.selectedMilesRangeFunction(value);
                    },
                      min: 0,
                      max: 1000,
                      divisions: 2,
                    autofocus: true,
                    label: controller.selectedMilesRange
                        .round()
                        .toString()
                  ),
                ),
                AppComponents().sizedBox10,
                /*    AppComponents().sizedBox20,
                Text(
                  "Martial Status is",
                  style: k20styleblack,
                ),
                AppComponents().sizedBox10,
                buildFilterDropDown(
                    text: "Select Status",
                    list: kMartial_StatusList!,
                    value: controller.selectedMartialStatus == ""
                        ? kMartial_StatusList![0]
                        : controller.selectedMartialStatus,
                    onchange: (value) {
                      controller.selectedMartialFunction(value.toString());
                      controller.filterMartialStatus = value.toString();
                      controller.update();
                    },
                    controller: controller),*/
                AppComponents().sizedBox20,
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: kAppButton(
                      buttonText: "Continue",
                      onButtonPressed: () {
                       Get.offAll(()=> HomeSwapNew());
                      },
                    ),
                  ),
                ),
                /* AppComponents().sizedBox20,*/
                /*    Text(
                  "Select Caste is",
                  style: k20styleblack,
                ),
                AppComponents().sizedBox10,
                buildFilterDropDown(
                    text: "Select Caste",
                    list: kcasteList!,
                    value: controller.selectedCaste == ""
                        ? kcasteList![0]
                        : controller.selectedCaste,
                    onchange: (value) {
                      controller.selectedCasteFunction(value.toString());
                      controller.filterCaste = value.toString();
                      controller.update();
                    },
                    controller: controller),*/
                AppComponents().sizedBox20,
                // Text(
                //   "Select City is",
                //   style: k20styleblack,
                // ),
                // AppComponents().sizedBox10,
                /*  buildFilterDropDown(
                    text: "Select City",
                    list: kCityList!,
                    value: controller.selectedCity == ""
                        ? kCityList![0]
                        : controller.selectedCity,
                    onchange: (value) {
                      controller.selectedCityFunction(value.toString());
                      controller.filterCity = value.toString();
                      controller.update();
                      controller.query();
                    },
                    controller: controller),
                AppComponents().sizedBox20,*/




              /*  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => ChooseYourPlan());
                    },
                    child: DottedBorder(
                      color: Colors.deepOrange,
                      radius: Radius.circular(100),
                      strokeWidth: 2,
                      strokeCap: StrokeCap.butt,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.deepOrange.withOpacity(0.1),
                        ),
                        child: Text(
                          "Buy plan for Membership Perks, Verified tick, Unlimited Likes, Read Receipts, Advance Preference",
                          style: k14styleblack,
                        ),
                      ),
                    ),
                  ),
                ),*/
              ]),
        ),
      );
    });
  }
}
