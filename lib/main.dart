import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pakar_sistem/app/modules/fakta/controllers/fakta_controller.dart';
import 'package:pakar_sistem/app/modules/tambahmodelrambut/controllers/tambahmodelrambut_controller.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDJJddlWtNKPlOvz0VDxupStFHJQNP-QtI",
          appId: "1:75721021199:android:e495686452af8491d5907a",
          messagingSenderId: "75721021199",
          projectId: "pakarcukuran-64f17",
          storageBucket: "pakarcukuran-64f17.appspot.com"
          ));
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: BindingsBuilder(() {
        Get.put(FaktaController());
        Get.put(TambahmodelrambutController());
      }),
    ),
  );
}
