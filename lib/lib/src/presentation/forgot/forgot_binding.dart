import 'package:get/get.dart';
import 'package:plass_getx/lib/src/presentation/forgot/forgot_controller.dart';

class ForgotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotController());
  }
}
