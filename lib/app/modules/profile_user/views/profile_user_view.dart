import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/profile_user_controller.dart';

class ProfileUserView extends GetView<ProfileUserController> {
  const ProfileUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileUserView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: controller.updateName,
              controller: TextEditingController(text: controller.name.value),
            ),
            SizedBox(height: 20),
            Obx(() {
              return controller.profileImageUrl.value.isNotEmpty
                  ? Image.network(controller.profileImageUrl.value, height: 200, width: double.infinity, fit: BoxFit.cover)
                  : Placeholder(fallbackHeight: 200, fallbackWidth: double.infinity);
            }),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final picker = ImagePicker();
                final pickedFile = await picker.pickImage(source: ImageSource.gallery);

                if (pickedFile != null) {
                  File image = File(pickedFile.path);
                  await controller.uploadImage(image);
                }
              },
              child: Text('Pick Image'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.saveProfile,
              child: Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
