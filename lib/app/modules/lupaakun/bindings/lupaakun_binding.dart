import 'package:get/get.dart';

import '../controllers/lupaakun_controller.dart';

class LupaakunBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LupaakunController>(
      () => LupaakunController(),
    );
  }
}
