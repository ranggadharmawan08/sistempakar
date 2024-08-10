import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pakar_sistem/app/routes/app_pages.dart';

import '../controllers/daftar_controller.dart';

class DaftarView extends GetView<DaftarController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50),
              Center(
                child: ClipOval(
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(
                      "assets/images/logo-barber.png",
                      height: 200,
                      width: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Silahkan Mendaftar Akun Baru Anda',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(() => TextField(
                      controller: controller.passwordController,
                      obscureText: !controller.passwordVisible.value,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.togglePasswordVisibility();
                          },
                          icon: Icon(controller.passwordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                    )),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(() => TextField(
                      controller: controller.confirmPasswordController,
                      obscureText: !controller.confirmpasswordVisible.value,
                      decoration: InputDecoration(
                        labelText: 'Konfirmasi Password',
                        prefixIcon: Icon(Icons.lock_outline),
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.toggleConfirmPasswordVisibility();
                          },
                          icon: Icon(controller.confirmpasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                    )),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButtonFormField<UserRole>(
                  value: controller.selectedRole,
                  onChanged: (value) {
                    if (value != null) {
                      controller.selectedRole = value;
                    }
                  },
                  items: UserRole.values.map((UserRole role) {
                    return DropdownMenuItem<UserRole>(
                      value: role,
                      child: Text(roleToString(role)),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Role',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ElevatedButton(
                  onPressed: () {
                    String email = controller.emailController.text.trim();
                    String name = controller.nameController.text.trim();
                    String password = controller.passwordController.text.trim();
                    String confirmPassword =
                        controller.confirmPasswordController.text.trim();

                    if (password != confirmPassword) {
                      Get.snackbar('Error',
                          'Password dan Konfirmasi Password tidak cocok');
                      return;
                    }

                    controller.registerWithEmailAndPassword(
                        email, password, name);
                  },
                  child: Text('Daftar', style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                  ),),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Colors.blue),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sudah punya akun? "),
                  TextButton(
                    onPressed: () {
                      Get.offNamed(Routes.MASUK);
                    },
                    child: Text(
                      'Masuk',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk mengonversi UserRole menjadi string
  String roleToString(UserRole role) {
    switch (role) {
      case UserRole.user:
        return 'User';
      case UserRole.admin:
        return 'Admin';
      default:
        return 'User';
    }
  }
}
