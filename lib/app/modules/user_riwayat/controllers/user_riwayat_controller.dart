import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRiwayatController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxList<Map<String, dynamic>> results = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDataFromFirestore();
  }

  void fetchDataFromFirestore() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        QuerySnapshot querySnapshot = await _firestore
            .collection('hasil')
            .where('userId', isEqualTo: user.uid)
            .get();
        
        List<Map<String, dynamic>> fetchedResults = querySnapshot.docs.map((doc) => {
          'result': doc['result'],
          'explanation': doc['explanation'],
          'imageUrl': doc['imageUrl'],
        }).toList();
        
        results.assignAll(fetchedResults);
      } else {
        print("User not authenticated");
      }
    } catch (e) {
      print("Error fetching data: $e");
      results.assignAll([
        {
          'result': 'Error fetching data',
          'explanation': '',
          'imageUrl': '',
        }
      ]);
    }
  }
}
