import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Home/Controllers/home_page_controller.dart';
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
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<Home_page_controller>(builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppComponents().sizedBox30,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Filters",
                          style: k25styleblack,
                        ),
                        InkWell(
                          onTap: () {
                            controller.clearAll(context);
                            controller.getData();
                            Get.back();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Clear All",
                                style: k14styleblack,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                "assets/icons/cancel.png",
                                height: 20,
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    AppComponents().sizedBox20,
                    Text(
                      "Select Age is",
                      style: k20styleblack,
                    ),
                    AppComponents().sizedBox30,
                    RangeSliderFlutter(
                      values: [
                        controller.filterlowerValue,
                        controller.filterupperValue
                      ],
                      rangeSlider: true,
                      jump: true,
                      tooltip: RangeSliderFlutterTooltip(
                          alwaysShowTooltip: true,
                          boxStyle: RangeSliderFlutterTooltipBox(
                              decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius: BorderRadius.circular(25)))),
                      max: 80,
                      textPositionTop: -60,
                      handlerHeight: 20,
                      trackBar: RangeSliderFlutterTrackBar(
                        activeTrackBarHeight: 6,
                        inactiveTrackBarHeight: 6,
                        activeTrackBar:
                            BoxDecoration(gradient: kLinearGradient()),
                        inactiveTrackBar: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                        ),
                      ),
                      min: 18,
                      fontSize: 15,
                      textBackgroundColor: Colors.deepOrange,
                      onDragging: (handlerIndex, lowerValue, upperValue) {
                        controller.filterlowerValue = lowerValue;
                        controller.filterupperValue = upperValue;
                        controller.update();
                      },
                    ),
                    AppComponents().sizedBox20,
                    Text(
                      "Range in miles is",
                      style: k20styleblack,
                    ),
                    AppComponents().sizedBox10,
                    Slider(
                      value: controller.selectedMilesRange,
                      onChanged: (value) {
                        controller.selectedMilesRangeFunction(value);
                      },
                      min: 500,
                      max: 1000,
                      divisions: 1,
                      autofocus: true,
                      thumbColor: Colors.deepOrange,
                      label: controller.selectedMilesRange.round().toString() +
                          " Miles",
                    ),
                    Center(
                      child: Text(
                          controller.selectedMilesRange.round().toString() +
                              " Miles"),
                    ),
                    AppComponents().sizedBox20,
                    Text(
                      "Select Religion is",
                      style: k20styleblack,
                    ),
                    AppComponents().sizedBox10,
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
                      child: kCustomButton(
                        label: "Apply Filter",
                        ontap: () {
                          controller.getData();
                          Get.back();
                        },
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
                    Padding(
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
                    ),
                  ]),
            ),
          );
        }),
      ),
    );
  }
}
