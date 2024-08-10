import 'package:get/get.dart';

import '../controllers/userfaq_controller.dart';

class UserfaqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserfaqController>(
      () => UserfaqController(),
    );
  }
}
