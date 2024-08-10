import 'package:get/get.dart';

import '../controllers/daftarmodel_controller.dart';

class DaftarmodelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DaftarmodelController>(
      () => DaftarmodelController(),
    );
  }
}
