import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:pakar_sistem/app/routes/app_pages.dart';
import 'dart:io';

class ProfileUserController extends GetxController {
var name = ''.obs;
  var profileImageUrl = ''.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void onInit() {
    super.onInit();
    _loadUserProfile();
  }

  void _loadUserProfile() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists) {
          name.value = doc['name'] ?? '';
          profileImageUrl.value = doc['profileImageUrl'] ?? '';
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile: $e');
    }
  }

  void updateName(String value) {
    name.value = value;
  }

  Future<void> uploadImage(File image) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String filePath = 'profile_images/${user.uid}.png';
        await _storage.ref(filePath).putFile(image);
        String downloadURL = await _storage.ref(filePath).getDownloadURL();
        profileImageUrl.value = downloadURL;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image: $e');
    }
  }

  Future<void> saveProfile() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'name': name.value,
          'profileImageUrl': profileImageUrl.value,
        });
        Get.snackbar('Success', 'Profile updated successfully');
        Get.offNamed(Routes.HOME);  // Arahkan ke halaman Admin Home setelah profil berhasil disimpan
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: $e');
    }
  }
}
