import 'package:get/get.dart';

import '../controllers/user_riwayat_controller.dart';

class UserRiwayatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserRiwayatController>(
      () => UserRiwayatController(),
    );
  }
}
