import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pakar_sistem/app/routes/app_pages.dart';

import '../controllers/fakta_controller.dart';

class FaktaView extends GetView<FaktaController> {
  const FaktaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>? ?? {};
    final String? documentId = arguments['id'] as String?;

    if (documentId != null) {
      controller.fetchData(documentId);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Masukkan Fakta',
          style: TextStyle(
            fontFamily: 'Poppins-Medium',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF01CBEF),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Get.offAllNamed(Routes.DAFTARFAKTAADMIN);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.faktaController,
              decoration: const InputDecoration(
                labelText: 'Fakta',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller.kodefaktaController,
              decoration: const InputDecoration(
                labelText: 'Kode Fakta',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (documentId != null) {
                  controller.updateData(documentId);
                } else {
                  controller.simpanData();
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
