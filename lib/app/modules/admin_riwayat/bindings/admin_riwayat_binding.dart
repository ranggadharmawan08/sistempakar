import 'package:get/get.dart';

import '../controllers/admin_riwayat_controller.dart';

class AdminRiwayatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminRiwayatController>(
      () => AdminRiwayatController(),
    );
  }
}
