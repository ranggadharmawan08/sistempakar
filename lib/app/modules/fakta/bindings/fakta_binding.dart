import 'package:get/get.dart';

import '../controllers/fakta_controller.dart';

class FaktaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaktaController>(
      () => FaktaController(),
    );
  }
}
