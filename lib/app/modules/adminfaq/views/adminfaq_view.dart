import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pakar_sistem/app/routes/app_pages.dart';
import '../controllers/adminfaq_controller.dart';

class AdminfaqView extends GetView<AdminfaqController> {
  const AdminfaqView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FAQ',
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
            Get.offAllNamed(Routes.ADMINHOME);
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
                '1. Cara Menambahkan Pasien',
                '1. Buka fitur pasien. \n2. Klik tombol tambah. \n3. Isi field. \n4. Lalu klik simpan',
              ),
              faqItem(
                '2. Prosedur Pendaftaran Pasien',
                '1. Klik list salah satu pasien. \n2. Maka terbuka halaman detail pasien. \n3. klik tombol Tambah antrian pasien. \n4. Pasien berada dalam antrian.',
              ),
              faqItem(
                '3. Pencatatan Riwayat Medis',
                '1. Buka fitur rekam medis. \n2. Klik tombol tambah. \n3. Isi field. \n4. Lalu klik simpan',
              ),
              faqItem(
                '4. Prosedur Antrian Baru',
                '1. Klik list salah satu pasien. \n2. Maka terbuka halaman detail pasien. \n3. klik tombol Tambah antrian pasien. \n4. Pasien berada dalam antrian.',
              ),
              faqItem(
                '5. Prosedur Hapus dan Ubah',
                '1. Geser list di halaman rekam medis atau pasien. \n2. Akan muncul ikon ubah berbentuk pensil dan hapus berbentuk tempat sampah. \n3. Ketika klik ikon ubah maka akan kehalaman ubah dan silahkan ubah data sesuai keperluan lalu klik simpan. \n4. Jika klik ikon hapus maka akan muncul menu untuk yakin menghapus data atau tidak.',
              ),
              faqItem(
                '6. Prosedur Validasi Status',
                '1. Klik fitur antrian pasien. \n2. Klik salah satu list pasien yang ingin validasi. \n3. Mengisi form rekam medis. \n4. Klik tombol simpan. \n5. Validasi selesai',
              ),
              faqItem(
                '7. Tentang Aplikasi',
                'Aplikasi ini merupakan aplikasi pendataan klinik, berbasis mobile android yang menerapkan sistem pendataan yang efektif dan efisien',
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
