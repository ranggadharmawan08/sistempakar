import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/lupaakun_controller.dart';

class LupaakunView extends GetView<LupaakunController> {
  const LupaakunView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                },
              ),
              SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    ClipOval(
                      child: Container(
                        color: Colors.black.withOpacity(
                            0.5), // Dark background with some opacity
                        padding: const EdgeInsets.all(5), // Add some padding
                        child: Image.asset(
                          "assets/images/logo-barber.png",
                          height: 150, // Adjust the size as needed
                          width: 150,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Lupa Password',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Masukkan email Anda untuk menerima instruksi reset password.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    controller.resetPassword(controller.emailController.text);
                  },
                  child: Text(
                    'Kirim',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Anda akan menerima email dengan instruksi untuk mengatur ulang kata sandi.',
                  style: TextStyle(fontSize: 14,),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
