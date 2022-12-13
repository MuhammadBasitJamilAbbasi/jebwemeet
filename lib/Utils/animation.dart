import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationLottie extends StatefulWidget {
  const AnimationLottie({Key? key}) : super(key: key);

  @override
  State<AnimationLottie> createState() => _AnimationLottieState();
}

class _AnimationLottieState extends State<AnimationLottie>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      
      'Assets/json/no_data.json',
      animate: true,
      repeat: true,
      controller: _controller,
      onLoaded: (composition) {
        _controller
          ..duration = composition.duration
          ..forward();
      },
    );
  }
}
