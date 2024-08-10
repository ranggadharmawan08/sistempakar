import 'package:get/get.dart';

import '../controllers/daftarfaktaadmin_controller.dart';

class DaftarfaktaadminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DaftarfaktaadminController>(
      () => DaftarfaktaadminController(),
    );
  }
}
