import 'package:get/get.dart';

import '../controllers/tambahmodelrambut_controller.dart';

class TambahmodelrambutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahmodelrambutController>(
      () => TambahmodelrambutController(),
    );
  }
}
