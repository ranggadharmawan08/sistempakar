import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DaftarmodelController extends GetxController {
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
}
