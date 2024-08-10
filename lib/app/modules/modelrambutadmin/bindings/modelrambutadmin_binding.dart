import 'package:get/get.dart';

import '../controllers/modelrambutadmin_controller.dart';

class ModelrambutadminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModelrambutadminController>(
      () => ModelrambutadminController(),
    );
  }
}
