import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pakar_sistem/app/routes/app_pages.dart';

class FaktaController extends GetxController {
  final TextEditingController faktaController = TextEditingController();
  final TextEditingController kodefaktaController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Mendapatkan ID berikutnya berdasarkan jumlah dokumen saat ini
  Future<String> _getNextDocumentId() async {
    try {
      // Ambil jumlah dokumen saat ini di koleksi 'fakta'
      QuerySnapshot snapshot = await _firestore.collection('fakta').get();
      int count = snapshot.size;

      // Format ID sesuai kebutuhan, contoh: F01, F02, dst.
      String nextId = 'F${(count + 1).toString().padLeft(2, '0')}';
      return nextId;
    } catch (e) {
      print("Error getting next document ID: $e");
      return ''; // Atau lakukan penanganan kesalahan sesuai kebutuhan
    }
  }

  void fetchData(String documentId) async {
    DocumentSnapshot document = await _firestore.collection('fakta').doc(documentId).get();
    faktaController.text = document['fakta'];
    kodefaktaController.text = document['kode_fakta'];
  }

  void simpanData() async {
    final String fakta = faktaController.text;
    final String kodefakta = kodefaktaController.text;

    if (fakta.isNotEmpty && kodefakta.isNotEmpty) {
      try {
        String nextDocumentId = await _getNextDocumentId();

        await _firestore.collection('fakta').doc(nextDocumentId).set({
          'fakta': fakta,
          'kode_fakta': kodefakta,
          'created_at': FieldValue.serverTimestamp(),
        });

        // Show success message
        Get.snackbar(
          'Success',
          'Data berhasil disimpan',
          snackPosition: SnackPosition.BOTTOM,
        );

        // Navigate to Daftarfaktaadmin page
        Get.offNamed(Routes.DAFTARFAKTAADMIN);
      } catch (e) {
        // Show error message if there is an issue
        Get.snackbar(
          'Error',
          'Terjadi kesalahan saat menyimpan data',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      // Show an error message if fields are empty
      Get.snackbar(
        'Error',
        'Semua field harus diisi',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void updateData(String documentId) async {
    final String fakta = faktaController.text;
    final String kodefakta = kodefaktaController.text;

    if (fakta.isNotEmpty && kodefakta.isNotEmpty) {
      try {
        await _firestore.collection('fakta').doc(documentId).update({
          'fakta': fakta,
          'kode_fakta': kodefakta,
          'updated_at': FieldValue.serverTimestamp(),
        });

        // Show success message
        Get.snackbar(
          'Success',
          'Data berhasil diperbarui',
          snackPosition: SnackPosition.BOTTOM,
        );

        // Navigate to Daftarfaktaadmin page
        Get.offNamed(Routes.DAFTARFAKTAADMIN);
      } catch (e) {
        // Show error message if there is an issue
        Get.snackbar(
          'Error',
          'Terjadi kesalahan saat memperbarui data',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      // Show an error message if fields are empty
      Get.snackbar(
        'Error',
        'Semua field harus diisi',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    faktaController.dispose();
    kodefaktaController.dispose();
    super.onClose();
  }
}
