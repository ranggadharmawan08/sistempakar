import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pakar_sistem/app/routes/app_pages.dart';

import '../controllers/sistempakaruser_controller.dart';

class SistempakaruserView extends GetView<SistempakaruserController> {
  const SistempakaruserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SistempakaruserController());

    return Scaffold(
      appBar: CustomAppBar(
        title: const Text(
          'Sistem Pakar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.lightBlue, // Light blue with opacity
                  Colors.white, // Solid white
                ],
                stops: [0.0, 0.7], // Gradient stops to control the fading effect
              ),
            ),
          ),
          FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection('fakta').get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('Tidak ada fakta tersedia.'));
              }

              List<DocumentSnapshot> documents = snapshot.data!.docs;

              return ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  const Text(
                    'Pilih Fakta:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ...documents.map((doc) {
                    String fact = doc['fakta'];
                    return Obx(() {
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: CheckboxListTile(
                          title: Text(fact),
                          value: controller.selectedFacts.contains(fact),
                          onChanged: (bool? value) {
                            controller.toggleFact(fact);
                          },
                          activeColor: Colors.lightBlue,
                          checkColor: Colors.white,
                        ),
                      );
                    });
                  }).toList(),
                  const SizedBox(height: 20),
                  Center(
                    child: CustomElevatedButton(
                      onPressed: () async {
                        await controller.getModelRambut();
                      },
                      text: const Text(
                        'Dapatkan Model Rambut',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(() {
                    if (controller.result.value.isEmpty) {
                      return SizedBox.shrink(); // This hides the card when no result is available
                    }

                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.result.value,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            if (controller.explanation.isNotEmpty) ...[
                              const Text(
                                'Penjelasan:',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                controller.explanation.value,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                            const SizedBox(height: 10),
                            if (controller.imageUrl.isNotEmpty) ...[
                              const Text(
                                'Gambar:',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  controller.imageUrl.value,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Color backgroundColor;

  const CustomAppBar({
    required this.title,
    required this.backgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      backgroundColor: backgroundColor,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white,),
        onPressed: () {
          Get.offAllNamed(Routes.HOME);
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget text;

  const CustomElevatedButton({
    required this.onPressed,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightBlue,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        textStyle: const TextStyle(fontSize: 16),
      ),
      child: text,
    );
  }
}
