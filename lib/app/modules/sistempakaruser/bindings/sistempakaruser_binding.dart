import 'package:get/get.dart';

import '../controllers/sistempakaruser_controller.dart';

class SistempakaruserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SistempakaruserController>(
      () => SistempakaruserController(),
    );
  }
}
