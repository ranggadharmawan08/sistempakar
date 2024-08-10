import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pakar_sistem/app/routes/app_pages.dart';
import '../controllers/modelrambutadmin_controller.dart';

class ModelrambutadminView extends GetView<ModelrambutadminController> {
  const ModelrambutadminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Model Rambut Admin',
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
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.offAllNamed(Routes.ADMINHOME);
          },
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.modelRambutList.length,
          itemBuilder: (context, index) {
            final modelRambut = controller.modelRambutList[index];
            final imageUrl = modelRambut['image_url'];

            return ListTile(
              title: Text(modelRambut['model_rambut']),
              subtitle: Text(modelRambut['penjelasan']),
              leading: imageUrl != null
                  ? Image.network(
                      imageUrl,
                      width: 50, // Adjust according to your UI design
                      height: 50, // Adjust according to your UI design
                      fit:
                          BoxFit.cover, // Adjust the image fitting as necessary
                    )
                  : SizedBox
                      .shrink(), // Display image if available, else shrink the SizedBox
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      controller.navigateToEdit(modelRambut.id);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Hapus Model Rambut",
                        middleText:
                            "Apakah Anda yakin ingin menghapus model rambut ini?",
                        textCancel: "Batal",
                        textConfirm: "Hapus",
                        onConfirm: () {
                          controller.deleteModelRambut(modelRambut.id);
                          Get.back();
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.navigateToAdd();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
