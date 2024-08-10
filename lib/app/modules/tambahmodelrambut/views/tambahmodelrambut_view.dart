import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pakar_sistem/app/routes/app_pages.dart';
import '../controllers/tambahmodelrambut_controller.dart';

class TambahmodelrambutView extends GetView<TambahmodelrambutController> {
  const TambahmodelrambutView({Key? key}) : super(key: key);

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
          'Masukkan Model Rambut',
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
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.offAllNamed(Routes.MODELRAMBUTADMIN);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: controller.modelRambutController,
                decoration: const InputDecoration(
                  labelText: 'Model Rambut',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.kodeRambutController,
                decoration: const InputDecoration(
                  labelText: 'Kode Rambut',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.penjelasanController,
                decoration: const InputDecoration(
                  labelText: 'Penjelasan',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    controller.image != null
                        ? ClipOval(
                            child: Image.file(
                              controller.image!,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipOval(
                            child: Container(
                              color: Colors.grey[200],
                              height: 150,
                              width: 150,
                              child: const Icon(
                                Icons.image,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: controller.pickImage,
                      child: const Text('Pilih Gambar'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              StreamBuilder<List<String>>(
                stream: controller.faktaListStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return const Text('Error loading data');
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No data available');
                  }
                  final availableFaktaList = snapshot.data!
                      .where((fakta) => !controller.rules.contains(fakta))
                      .toList();

                  return DropdownButtonFormField<String>(
                    value: controller.selectedFakta,
                    hint: const Text('Pilih Aturan'),
                    items: availableFaktaList.map((fakta) {
                      return DropdownMenuItem<String>(
                        value: fakta,
                        child: Text(fakta),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedFakta = value;
                      controller.update(); // Update the UI
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: controller.addRule,
                child: const Text('Tambah Aturan'),
              ),
              const SizedBox(height: 20),
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.rules.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(controller.rules[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => controller.removeRule(index),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 80),
              ElevatedButton(
                onPressed: () {
                  if (documentId != null) {
                    controller.updateData(documentId);
                  } else {
                    controller.simpanData();
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 15.0,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
