import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pakar_sistem/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
            fontFamily: 'Poppins-Medium',
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Obx(() => Text(
                    controller.accountName.value,
                    style: TextStyle(color: Colors.white),
                  )),
              accountEmail: Obx(() => Text(
                    controller.accountEmail.value,
                    style: TextStyle(color: Colors.white),
                  )),
              currentAccountPicture: Obx(() {
                return CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: controller.profileImageUrl.value.isNotEmpty
                      ? NetworkImage(controller.profileImageUrl.value)
                      : null,
                  child: controller.profileImageUrl.value.isEmpty
                      ? Text(
                          controller.accountName.value.isNotEmpty
                              ? controller.accountName.value
                                  .substring(0, 1)
                                  .toUpperCase()
                              : '',
                          style: TextStyle(fontSize: 24.0),
                        )
                      : null,
                );
              }),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFF0083B0), const Color(0xFF01CBEF)],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(
                'Profile',
              ),
              onTap: () {
                Get.toNamed(Routes.PROFILE_USER);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text(
                'FAQ',
              ),
              onTap: () {
                Get.toNamed(Routes.USERFAQ);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'Logout',
              ),
              onTap: () {
                controller.signOut();
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Container(
              height: 200,
              child: CarouselSlider(
                items: [
                  'assets/images/cukuran1.jpg',
                  'assets/images/cukuran2.jpg',
                  'assets/images/cukuran3.jpg',
                  'assets/images/cukuran4.jpg',
                  'assets/images/cukuran5.jpg',
                ].map((item) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(item),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: EdgeInsets.all(5.0),
                  );
                }).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.DAFTARMODEL);
                print('Daftar Model Rambut clicked');
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: 400, // Min width of the container
                    minHeight: 50, // Min height of the container
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECEFF1), // Light gray background
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Daftar Model Rambut',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Menu untuk melihat daftar model rambut',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.SISTEMPAKARUSER);
                print('Sistem Pakar clicked');
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: 400, // Min width of the container
                    minHeight: 50, // Min height of the container
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECEFF1), // Light gray background
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Sistem Pakar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Menu untuk menentukan model rambut anda',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.USER_RIWAYAT);
                print('Riwayat clicked');
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: 400, // Min width of the container
                    minHeight: 50, // Min height of the container
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECEFF1), // Light gray background
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Riwayat',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Menu untuk melihat daftar riwayat',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Pengenalan Modelan Cukuran',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    '1. Fade Haircut',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Fade haircut adalah gaya rambut yang sangat populer di kalangan pria. Potongan ini memiliki sisi yang sangat pendek dan berangsur-angsur menjadi lebih panjang di bagian atas.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    '2. Undercut',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Undercut adalah gaya rambut di mana bagian atas dibiarkan lebih panjang, sementara sisi dan belakang dipotong sangat pendek atau dicukur.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    '3. Pompadour',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Pompadour adalah gaya rambut yang memiliki volume besar di bagian depan yang disisir ke belakang. Gaya ini memerlukan penggunaan produk rambut untuk mempertahankan bentuknya.',
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Jelajahi tempat cukur terbaik:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.location_on, color: Colors.red),
                    title: Text('Flash Barbershop'),
                
                    subtitle: Text('Jl. Bah Kilong, Sukadami, Cikarang Selatan'),
                
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
