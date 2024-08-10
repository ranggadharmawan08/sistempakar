import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pakar_sistem/app/routes/app_pages.dart';

class TambahmodelrambutController extends GetxController {
  final TextEditingController modelRambutController = TextEditingController();
  final TextEditingController kodeRambutController = TextEditingController();
  final TextEditingController penjelasanController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  File? _image;
  final ImagePicker _picker = ImagePicker();

  var rules = <String>[].obs; // Observable list of rules

  String? selectedFakta; // Selected value from the dropdown

  File? get image => _image;

  Stream<List<String>> get faktaListStream {
    return _firestore.collection('fakta').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc['fakta'].toString()).toList();
    });
  }

  void fetchData(String documentId) async {
    DocumentSnapshot document = await _firestore.collection('model_rambut').doc(documentId).get();
    modelRambutController.text = document['model_rambut'];
    kodeRambutController.text = document['kode_rambut'];
    penjelasanController.text = document['penjelasan'];
    rules.assignAll(List<String>.from(document['rules']));
    update(); // Make sure to update the UI after fetching data
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      update();  // Update UI
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      final ref = _storage.ref().child('model_rambut_images/${DateTime.now().millisecondsSinceEpoch.toString()}');
      final uploadTask = ref.putFile(image);
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan saat mengupload gambar',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  void addRule() {
    if (selectedFakta != null && selectedFakta!.isNotEmpty) {
      rules.add(selectedFakta!);
      selectedFakta = null;
      update(); // Update the UI
    }
  }

  void removeRule(int index) {
    rules.removeAt(index);
    update(); // Update the UI
  }

  // Mendapatkan ID berikutnya berdasarkan jumlah dokumen saat ini
  String _getNextDocumentId(int currentCount) {
    String nextId = 'M${(currentCount + 1).toString().padLeft(2, '0')}';
    return nextId;
  }

  void simpanData() async {
    final String modelRambut = modelRambutController.text;
    final String kodeRambut = kodeRambutController.text;
    final String penjelasan = penjelasanController.text;

    if (modelRambut.isNotEmpty && kodeRambut.isNotEmpty && penjelasan.isNotEmpty && rules.isNotEmpty) {
      if (_image != null) {
        final imageUrl = await _uploadImage(_image!);
        if (imageUrl != null) {
          try {
            // Hitung jumlah dokumen saat ini di koleksi 'model_rambut'
            QuerySnapshot resultSnapshot = await _firestore.collection('model_rambut').get();
            int currentCount = resultSnapshot.size;

            // Dapatkan ID berikutnya
            String nextDocumentId = _getNextDocumentId(currentCount);

            await _firestore.collection('model_rambut').doc(nextDocumentId).set({
              'model_rambut': modelRambut,
              'kode_rambut': kodeRambut,
              'penjelasan': penjelasan,
              'image_url': imageUrl,
              'rules': rules,
              'created_at': FieldValue.serverTimestamp(),
            });

            // Show success message
            Get.snackbar(
              'Success',
              'Data berhasil disimpan',
              snackPosition: SnackPosition.BOTTOM,
            );

            // Navigate to ModelRambutAdmin page
            Get.offNamed(Routes.MODELRAMBUTADMIN);
          } catch (e) {
            // Show error message if there is an issue
            Get.snackbar(
              'Error',
              'Terjadi kesalahan saat menyimpan data',
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        }
      } else {
        // Show an error message if no image is selected
        Get.snackbar(
          'Error',
          'Pilih gambar terlebih dahulu',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      // Show an error message if fields are empty
      Get.snackbar(
        'Error',
        'Semua field harus diisi dan rules harus ditambahkan',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void updateData(String documentId) async {
    final String modelRambut = modelRambutController.text;
    final String kodeRambut = kodeRambutController.text;
    final String penjelasan = penjelasanController.text;

    if (modelRambut.isNotEmpty && kodeRambut.isNotEmpty && penjelasan.isNotEmpty && rules.isNotEmpty) {
      String? imageUrl;
      if (_image != null) {
        imageUrl = await _uploadImage(_image!);
      }

      try {
        final updateData = {
          'model_rambut': modelRambut,
          'kode_rambut': kodeRambut,
          'penjelasan': penjelasan,
          'rules': rules,
          'updated_at': FieldValue.serverTimestamp(),
        };
        if (imageUrl != null) {
          updateData['image_url'] = imageUrl;
        }

        await _firestore.collection('model_rambut').doc(documentId).update(updateData);

        // Show success message
        Get.snackbar(
          'Success',
          'Data berhasil diperbarui',
          snackPosition: SnackPosition.BOTTOM,
        );

        // Navigate to ModelRambutAdmin page
        Get.offNamed(Routes.MODELRAMBUTADMIN);
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
        'Semua field harus diisi dan rules harus ditambahkan',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    modelRambutController.dispose();
    kodeRambutController.dispose();
    penjelasanController.dispose();
    super.onClose();
  }
}
