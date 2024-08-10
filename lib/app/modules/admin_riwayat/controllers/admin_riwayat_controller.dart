import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminRiwayatController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<DocumentSnapshot<Map<String, dynamic>>> results = RxList<DocumentSnapshot<Map<String, dynamic>>>();

  @override
  void onInit() {
    super.onInit();
    fetchDataFromFirestore();
  }

  void fetchDataFromFirestore() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore.collection('hasil').get();
      results.assignAll(querySnapshot.docs);
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
}
