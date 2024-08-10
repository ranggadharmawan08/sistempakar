import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pakar_sistem/app/routes/app_pages.dart';

class MasukController extends GetxController {
  var passwordVisible = false.obs;
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      
      // Setelah login berhasil, arahkan ke halaman sesuai dengan role
      String uid = _auth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      String role = userDoc['role'];

      // Misalnya, arahkan ke halaman berbeda berdasarkan role
      if (role == 'user') {
        Get.offNamed(Routes.HOME);
      } else if (role == 'admin') {
        Get.offNamed(Routes.ADMINHOME);
      } else {
        // Handle role lainnya jika diperlukan
        Get.snackbar('Error', 'Role tidak valid');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
