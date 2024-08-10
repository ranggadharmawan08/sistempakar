import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pakar_sistem/app/routes/app_pages.dart';

import '../controllers/masuk_controller.dart';

class MasukView extends GetView<MasukController> {
  const MasukView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: screenHeight * 0.15),
                  Center(
                    child: Text(
                      'Selamat Datang Di Aplikasi',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Sistem Pakar Menentukan Model',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Cukuran Rambut',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Center(
                    child: Text(
                      'Flash Barbershop',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.06),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: TextField(
                      controller: controller.emailController, // Bind controller untuk email
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Obx(() => TextField(
                      controller: controller.passwordController, // Bind controller untuk password
                      obscureText: !controller.passwordVisible.value,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.passwordVisible.value = !controller.passwordVisible.value;
                          },
                          icon: Icon(controller.passwordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                    )),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.LUPAAKUN);
                        },
                        child: Text(
                          'Lupa Password?',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: ElevatedButton(
                      onPressed: () {
                        controller.signInWithEmailAndPassword(
                          controller.emailController.text,
                          controller.passwordController.text,
                        );
                      },
                      child: Text(
                        'Masuk',
                        style: TextStyle(fontSize: screenWidth * 0.045, color: Colors.white),
                        
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        backgroundColor: Colors.blue
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Belum punya akun? ",
                        style: TextStyle(fontSize: screenWidth * 0.04),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.offNamed(Routes.DAFTAR);
                        },
                        child: Text(
                          'Daftar disini',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
