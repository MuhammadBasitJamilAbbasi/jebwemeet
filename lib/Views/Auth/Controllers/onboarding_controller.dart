import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  int _currentIndex = 0;

  int get index => _currentIndex;

  set index(int index) {
    _currentIndex = index;
    update();
  }
}
