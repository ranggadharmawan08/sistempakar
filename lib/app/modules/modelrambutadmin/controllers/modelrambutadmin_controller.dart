import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pakar_sistem/app/routes/app_pages.dart';

class ModelrambutadminController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var modelRambutList = <QueryDocumentSnapshot>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchModelRambut();
  }

  void fetchModelRambut() {
    _firestore.collection('model_rambut').snapshots().listen((snapshot) {
      modelRambutList.value = snapshot.docs;
      isLoading.value = false;
    });
  }

  void deleteModelRambut(String id) async {
    try {
      await _firestore.collection('model_rambut').doc(id).delete();
      Get.snackbar(
        'Success',
        'Model rambut berhasil dihapus',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan saat menghapus data',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void navigateToEdit(String id) {
    Get.toNamed(Routes.TAMBAHMODELRAMBUT, arguments: {'id': id, 'isEdit': true});
  }

  void navigateToAdd() {
    Get.toNamed(Routes.TAMBAHMODELRAMBUT, arguments: null);
  }
}
