import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pakar_sistem/app/routes/app_pages.dart';

class HomeController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<String> accountName = Rx<String>('');
  Rx<String> accountEmail = Rx<String>('');
  Rx<String> profileImageUrl = Rx<String>('');

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  void fetchUserData() {
    try {
      String uid = _auth.currentUser!.uid;
      _firestore.collection('users').doc(uid).snapshots().listen((userDoc) {
        if (userDoc.exists) {
          accountName.value = userDoc.data()?['name'] ?? '';
          accountEmail.value = userDoc.data()?['email'] ?? '';
          profileImageUrl.value = userDoc.data()?['profileImageUrl'] ?? '';
        }
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void signOut() async {
    await _auth.signOut();
    Get.offNamed(Routes.MASUK);
  }
}
