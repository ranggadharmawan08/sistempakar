import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pakar_sistem/app/modules/adminhome/views/adminhome_view.dart';
import 'package:pakar_sistem/app/modules/home/views/home_view.dart';
import 'package:pakar_sistem/app/modules/masuk/views/masuk_view.dart';

import '../controllers/splashscreeen_controller.dart';

class SplashscreeenView extends GetView<SplashscreeenController> {
  const SplashscreeenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Function to check login status based on Firebase Auth
    void checkLoginStatus() async {
      // Delay for splash screen effect
      await Future.delayed(const Duration(seconds: 3));

      // Check if user is logged in
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // If user is logged in, get user data from Firestore
        DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        String role = userDoc['role'];

        // Navigate based on role
        if (role == 'user') {
          Get.offNamed('/home', arguments: PageTransition(type: PageTransitionType.fade, child: HomeView(), duration: Duration(seconds: 1)));
        } else if (role == 'admin') {
          Get.offNamed('/adminhome', arguments: PageTransition(type: PageTransitionType.fade, child: AdminhomeView(), duration: Duration(seconds: 1)));
        } else {
          // Handle other roles if needed
          Get.offNamed('/masuk', arguments: PageTransition(type: PageTransitionType.fade, child: MasukView(), duration: Duration(seconds: 1)));
        }
      } else {
        // If user is not logged in, navigate to login screen
        Get.offNamed('/masuk', arguments: PageTransition(type: PageTransitionType.fade, child: MasukView(), duration: Duration(seconds: 1)));
      }
    }

    // Call function to check login status when view is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkLoginStatus();
    });

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/splashscreen.png",
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: ClipOval(
              child: Container(
                color: Colors.black.withOpacity(0.5), // Dark background with some opacity
                padding: const EdgeInsets.all(5), // Add some padding
                child: Image.asset(
                  "assets/images/logo-barber.png",
                  height: 200, // Adjust the size as needed
                  width: 200,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
