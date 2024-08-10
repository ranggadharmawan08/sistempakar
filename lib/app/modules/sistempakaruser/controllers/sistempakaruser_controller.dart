import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SistempakaruserController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var selectedFacts = <String>[].obs;
  var result = ''.obs;
  var explanation = ''.obs;
  var imageUrl = ''.obs;

  void toggleFact(String fact) {
    if (selectedFacts.contains(fact)) {
      selectedFacts.remove(fact);
    } else {
      selectedFacts.add(fact);
    }
  }

  Future<void> getModelRambut() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      // Ambil semua aturan dan hasil dari koleksi 'model_rambut'
      QuerySnapshot modelRambutSnapshot = await _firestore.collection('model_rambut').get();
      List<Map<String, dynamic>> rules = modelRambutSnapshot.docs.map((doc) {
        return {
          'rules': List<String>.from(doc['rules']),
          'model_rambut': doc['model_rambut'] as String,
          'penjelasan': doc['penjelasan'] as String,
          'image_url': doc['image_url'] as String,
        };
      }).toList();

      print("Rules: $rules");
      print("Selected Facts: $selectedFacts");

      // Implementasi forward chaining
      for (var rule in rules) {
        List<String> ruleFacts = rule['rules'];
        bool allFactsMatch = ruleFacts.every((fact) => selectedFacts.contains(fact));
        if (allFactsMatch) {
          result.value = rule['model_rambut'];
          explanation.value = rule['penjelasan'];
          imageUrl.value = rule['image_url'];

          // Simpan hasil ke Firestore sebagai dokumen baru dengan ID otomatis
          await _firestore.collection('hasil').add({
            'userId': user.uid,
            'result': rule['model_rambut'],
            'explanation': rule['penjelasan'],
            'imageUrl': rule['image_url'],
            'timestamp': Timestamp.now(),
          });

          return;
        }
      }

      // Jika tidak ada kecocokan
      result.value = 'Tidak ditemukan model rambut yang sesuai.';
      explanation.value = '';
      imageUrl.value = '';

    } catch (e) {
      print("Error: $e");
      result.value = 'Terjadi kesalahan saat mengambil data.';
      explanation.value = '';
      imageUrl.value = '';
    }
  }
}
