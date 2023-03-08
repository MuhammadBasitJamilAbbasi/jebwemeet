import 'package:get/get.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/LoginController.dart';
import 'package:jabwemeet/Views/Auth/Controllers/Profile_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';
import 'package:jabwemeet/Views/Auth/Controllers/helper_functions.dart';
import 'package:jabwemeet/Views/Home/Controllers/Notifications_controller.dart';
import 'package:jabwemeet/Views/Home/Controllers/home_page_controller.dart';
import 'package:jabwemeet/Views/Home/Controllers/message_controller.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(),);
    Get.lazyPut(() => GetSTorageController(), );
    Get.lazyPut(() => HelpersFunctions(), );
    Get.lazyPut(() => RegisterController(),);
    Get.lazyPut(() => ProfileController(),);
    Get.lazyPut(() => MessageController(),);
    Get.lazyPut(() => Home_page_controller(),);
    Get.lazyPut(() => NotificationController(),);
  }
}
