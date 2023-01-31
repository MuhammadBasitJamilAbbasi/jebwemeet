

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/Profile_Controller.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/completeProfile/view/form_1.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/completeProfile/view/form_2.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/completeProfile/view/form_3.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/completeProfile/view/form_4.dart';

class Complete_Profile1 extends StatefulWidget {
  @override
  State<Complete_Profile1> createState() => _Complete_Profile1State();
}

class _Complete_Profile1State extends State<Complete_Profile1> {


  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: GetBuilder<ProfileController>(
        builder: (controller){
          return controller.isLoader ? Center(child: CircularProgressIndicator(),): Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
            child: controller.currentStep==1?  kAppButton(
                buttonText: controller.currentStep == controller.stepLength ? 'Submit' : 'Next',
                onButtonPressed: () {
                  print(controller.stepLength.toString());
                  if(controller.currentStep==controller.stepLength){
                    controller.submitProfile(context);
                  }
                  else {
                    controller.next();
                    setState(() {
                      _scrollController.animateTo(
                        _scrollController.position.minScrollExtent,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 500),
                      );
                    });
                  }
                }):
            Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: (){
                        controller.back();
                        setState(() {
                          _scrollController.animateTo(
                            _scrollController.position.minScrollExtent,
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 500),
                          );
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Center(child: Text("Back",style: k14styleblack,)),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: kAppButton(
                        roundedRight: true,
                        buttonText: controller.currentStep == controller.stepLength ? 'Submit' : 'Next',
                        onButtonPressed: () {
                          print(controller.stepLength.toString());
                          if(controller.currentStep==controller.stepLength){
                            controller.submitProfile(context);
                          }
                          else {
                            controller.next();
                            setState(() {
                              _scrollController.animateTo(
                                _scrollController.position.minScrollExtent,
                                curve: Curves.easeOut,
                                duration: const Duration(milliseconds: 500),
                              );
                            });
                          }
                        }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      body: GetBuilder<ProfileController>(
        builder: (controller){
          return  SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NumberStepper(
                    totalSteps: controller.stepLength,
                    width: MediaQuery.of(context).size.width,
                    curStep: controller.currentStep,
                    stepCompleteColor: textcolor,
                    currentStepColor: textcolor,
                    inactiveColor: Color(0xffbababa),
                    lineWidth: 5.5,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  controller.currentStep == 1
                      ? Form1()
                      : controller.currentStep == 2
                      ? Form_2()
                      : controller.currentStep==3 ? Form_3() :  Form_4(),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class NumberStepper extends StatefulWidget {
  final double width;
  final totalSteps;
  final int curStep;
  final Color stepCompleteColor;
  final Color currentStepColor;
  final Color inactiveColor;
  final double lineWidth;
  NumberStepper({
    required this.width,
    required this.curStep,
    required this.stepCompleteColor,
    required this.totalSteps,
    required this.inactiveColor,
    required this.currentStepColor,
    required this.lineWidth,
  }) : assert(curStep > 0 == true && curStep <= totalSteps + 1);

  @override
  State<NumberStepper> createState() => _NumberStepperState();
}

class _NumberStepperState extends State<NumberStepper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20.0,
        left: 15.0,
        right: 15.0,
      ),
      width: this.widget.width,
      child: Row(
        children: _steps(),
      ),
    );
  }

  getCircleColor(i) {
    var color;
    if (i + 1 < widget.curStep) {
      color = widget.stepCompleteColor;
    } else if (i + 1 == widget.curStep)
      color = widget.currentStepColor;
    else
      color = Colors.white;
    return color;
  }

  getBorderColor(i) {
    var color;
    if (i + 1 < widget.curStep) {
      color = widget.stepCompleteColor;
    } else if (i + 1 == widget.curStep)
      color = widget.currentStepColor;
    else
      color = widget.inactiveColor;

    return color;
  }

  getLineColor(i) {
    var color = widget.curStep > i + 1 ? textcolor : Colors.grey[200];
    return color;
  }


  List<Widget> _steps() {
    var list = <Widget>[];
    for (int i = 0; i < widget.totalSteps; i++) {
      //colors according to state

      var circleColor = getCircleColor(i);
      var borderColor = getBorderColor(i);
      var lineColor = getLineColor(i);

      // step circles
      list.add(
        Container(
          width: 43.0,
          height: 43.0,
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: getInnerElementOfStepper(i),
          decoration: new BoxDecoration(
            color: circleColor,
            borderRadius: new BorderRadius.all(new Radius.circular(25.0)),
            border: new Border.all(
              color: borderColor,
              width: 1.0,
            ),
          ),
        ),
      );
      //line between step circles
      if (i != widget.totalSteps - 1) {
        list.add(
          Expanded(
            child: Container(
              height: widget.lineWidth,
              decoration: BoxDecoration(
                  color: lineColor,
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
        );
      }
    }

    return list;
  }

  Widget getInnerElementOfStepper(index) {
    if (index == 0) {
      return InkWell(
        onTap: () {
          if (widget.curStep == 2 || widget.curStep == 3) {
            setState(() => widget.curStep == 1);
          }
        },
        child: Center(
          child: Text(
            "1",
            style: TextStyle(
              color: widget.curStep > index ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      );
    } else if (index == 1) {
      return InkWell(
        onTap: () {
          if (widget.curStep == 3) {
            setState(() => widget.curStep == 2);
          }
        },
        child: Center(
          child: Text(
            '2',
            style: TextStyle(
              color: widget.curStep > index ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      );
    }
    else if (index == 2) {
      return InkWell(
        onTap: () {
          if (widget.curStep == 4) {
            setState(() => widget.curStep == 3);
          }
        },
        child: Center(
          child: Text(
            '3',
            style: TextStyle(
              color: widget.curStep > index ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      );
    }
    else if (index == 3) {
      return Center(
        child: Text(
          (4).toString(),
          style: TextStyle(
            color: widget.curStep > index ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
      );
    } else
      return Container();
  }
}
