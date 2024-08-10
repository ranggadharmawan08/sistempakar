import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pakar_sistem/app/routes/app_pages.dart';

enum UserRole {
  user,
  admin,
  // tambahkan peran lainnya jika diperlukan
}

class DaftarController extends GetxController {
  var passwordVisible = false.obs;
  var confirmpasswordVisible = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Role yang dipilih (default: user)
  UserRole selectedRole = UserRole.user;

  @override
  void onClose() {
    // Clean up the controllers when the view is disposed
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    confirmpasswordVisible.value = !confirmpasswordVisible.value;
  }

  Future<void> registerWithEmailAndPassword(String email, String password, String name) async {
    try {
      var userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'role': roleToString(selectedRole), // Konversi enum ke string
      });

      Get.snackbar('Pendaftaran Berhasil', 'Akun telah berhasil didaftarkan');
      Get.offNamed(Routes.MASUK);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Fungsi untuk mengonversi enum UserRole menjadi string
  String roleToString(UserRole role) {
    switch (role) {
      case UserRole.user:
        return 'user';
      case UserRole.admin:
        return 'admin';
      default:
        return 'user'; // Defaultnya user
    }
  }
}
