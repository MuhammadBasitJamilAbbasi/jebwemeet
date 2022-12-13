import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Home/Controllers/home_page_controller.dart';
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
                            controller.query();
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
                        controller.lowerValue.value,
                        controller.upperValue.value
                      ],
                      rangeSlider: true,
                      jump: true,
                      tooltip: RangeSliderFlutterTooltip(
                        alwaysShowTooltip: true,
                      ),
                      max: 80,
                      textPositionTop: -80,
                      handlerHeight: 30,
                      trackBar: RangeSliderFlutterTrackBar(
                        activeTrackBarHeight: 10,
                        inactiveTrackBarHeight: 10,
                        activeTrackBar:
                            BoxDecoration(gradient: kLinearGradient()),
                        inactiveTrackBar: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                        ),
                      ),
                      min: 0,
                      fontSize: 15,
                      textBackgroundColor: Colors.red,
                      onDragging: (handlerIndex, lowerValue, upperValue) {
                        controller.lowerValue.value = lowerValue;
                        controller.upperValue.value = upperValue;
                        controller.update();
                        controller.query();
                      },
                    ),
                    AppComponents().sizedBox20,
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
                          controller.query();
                        },
                        controller: controller),
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
                          controller.query();
                        },
                        controller: controller),
                    AppComponents().sizedBox20,
                    Text(
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
                          controller.query();
                        },
                        controller: controller),
                    AppComponents().sizedBox20,
                    Text(
                      "Select City is",
                      style: k20styleblack,
                    ),
                    AppComponents().sizedBox10,
                    buildFilterDropDown(
                        text: "Select City",
                        list: kCityList!,
                        value: controller.selectedCity == ""
                            ? kCityList![0]
                            : controller.selectedCity,
                        onchange: (value) {
                          controller.selectedCityFunction(value.toString());
                          controller.query();
                        },
                        controller: controller),
                    AppComponents().sizedBox20,
                  ]),
            ),
          );
        }),
      ),
    );
  }
}
