import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pakar_sistem/app/routes/app_pages.dart';

import '../controllers/userfaq_controller.dart';

class UserfaqView extends GetView<UserfaqController> {
  const UserfaqView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FAQ',
          style: TextStyle(
            fontFamily: 'Poppins-Medium',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.offAllNamed(Routes.HOME);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFFFFFFFF),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              faqItem(
                '1. Cara Merubah Profile Anda',
                '1. Klik Icon 3 Garis. \n2. Klik Profile. \n3. Ubah Profile Sesuai Keinginan Anda. \n4. Lalu klik simpan',
              ),
              faqItem(
                '2. Cara Menggunakan Aplikasi Sistem Pakar',
                '1. Klik Sistem Pakar Pada Home. \n2. Pada Halaman Sistem Pakar Silahkan Pilih Fakta. \n3. Pastikan Anda Memilih Fakta Yang Sesuai. \n4. Lalu Klik Dapatkan Model Rambut.',
              ),
              faqItem(
                '3. Tentang Aplikasi',
                'Aplikasi Ini Merupakan Aplikasi Sistem Pakar Untuk Menentukan Model Cukuran, Yang Berbasis Android Dengan Cepat dan Akurat',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget faqItem(String title, String content) {
    List<InlineSpan> textSpans = [];

    // Split content by newline character \n
    List<String> paragraphs = content.split('\n');

    // Create TextSpan for each paragraph
    for (String paragraph in paragraphs) {
      textSpans.add(
        TextSpan(
          text: paragraph,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: Color(0xFF000000),
          ),
        ),
      );
      // Add a new line widget after each paragraph except the last one
      if (paragraphs.last != paragraph) {
        textSpans.add(const TextSpan(text: '\n'));
      }
    }

    return CustomExpansionTile(
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Color(0xFF000000),
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListView(shrinkWrap: true, children: [
            RichText(
              text: TextSpan(children: textSpans),
            ),
          ]),
        ),
      ],
    );
  }


class CustomExpansionTile extends StatefulWidget {
  final Widget title;
  final List<Widget> children;

  const CustomExpansionTile({
    required this.title,
    required this.children,
  });

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: widget.title,
          trailing: Icon(
            _isExpanded ? Icons.expand_less : Icons.expand_more,
          ),
          onTap: _handleTap,
        ),
        _isExpanded
            ? Column(
                children: widget.children,
              )
            : Container(),
      ],
    );
  }
}
