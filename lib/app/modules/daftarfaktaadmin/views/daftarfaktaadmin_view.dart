import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pakar_sistem/app/routes/app_pages.dart';
import '../controllers/daftarfaktaadmin_controller.dart';

class DaftarfaktaadminView extends GetView<DaftarfaktaadminController> {
  const DaftarfaktaadminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Fakta Admin',
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
          itemCount: controller.faktaList.length,
          itemBuilder: (context, index) {
            final fakta = controller.faktaList[index];
            return ListTile(
              title: Text(fakta['fakta']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      controller.navigateToEdit(fakta.id);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Hapus Fakta",
                        middleText:
                            "Apakah Anda yakin ingin menghapus fakta ini?",
                        textCancel: "Batal",
                        textConfirm: "Hapus",
                        onConfirm: () {
                          controller.deletefakta(fakta.id);
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
