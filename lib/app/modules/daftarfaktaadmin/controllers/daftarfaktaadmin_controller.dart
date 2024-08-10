import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pakar_sistem/app/routes/app_pages.dart';

class DaftarfaktaadminController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var faktaList = <QueryDocumentSnapshot>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchfakta();
  }

  void fetchfakta() {
    _firestore.collection('fakta').snapshots().listen((snapshot) {
      faktaList.value = snapshot.docs;
      isLoading.value = false;
    });
  }

  void deletefakta(String id) async {
    try {
      await _firestore.collection('fakta').doc(id).delete();
      Get.snackbar(
        'Success',
        'Fakta berhasil dihapus',
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
    Get.toNamed(Routes.FAKTA, arguments: {'id': id, 'isEdit': true});
  }

  void navigateToAdd() {
    Get.toNamed(Routes.FAKTA, arguments: null);
  }
}
