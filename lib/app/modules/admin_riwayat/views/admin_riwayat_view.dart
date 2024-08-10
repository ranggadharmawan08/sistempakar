import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pakar_sistem/app/routes/app_pages.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import '../controllers/admin_riwayat_controller.dart';

class AdminRiwayatView extends GetView<AdminRiwayatController> {
  const AdminRiwayatView({Key? key}) : super(key: key);

  Future<void> _exportToPdf() async {
    final pdf = pw.Document();
    final date = DateTime.now();

    // Define fonts as pw.Font inside the async function
    final pw.Font regularFont =
        pw.Font.ttf(await rootBundle.load("assets/fonts/Poppins-Regular.ttf"));

    // Check for storage permissions
    if (!(await _requestStoragePermission())) {
      print('Storage permission denied');
      return;
    }

    // Get the Downloads directory
    Directory? downloadsDirectory = await getDownloadsDirectory();
    if (downloadsDirectory == null) {
      print('Could not get the downloads directory');
      return;
    }

    // Add content to PDF
    for (var result in controller.results) {
      final Uint8List imageBytes = await _getImageBytes(result['imageUrl']);

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header
                pw.Container(
                  alignment: pw.Alignment.center,
                  margin: pw.EdgeInsets.only(bottom: 10),
                  child: pw.Text(
                    'Laporan Riwayat Hasil Sistem Pakar',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 14,
                      font: regularFont,
                    ),
                  ),
                ),
                // Table
                pw.Table.fromTextArray(
                  headerStyle: pw.TextStyle(
                    font: regularFont,
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  cellStyle: pw.TextStyle(
                    font: regularFont,
                    fontSize: 10,
                  ),
                  headerAlignment: pw.Alignment.center,
                  cellAlignment: pw.Alignment.center,
                  cellHeight: 20,
                  headerHeight: 30,
                  headerDecoration: pw.BoxDecoration(
                    color: PdfColors.grey300,
                  ),
                  cellPadding:
                      pw.EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                  headers: ['Hasil', 'Penjelasan', 'Gambar'],
                  data: [
                    [
                      result['result'],
                      result['explanation'],
                      pw.Image(pw.MemoryImage(imageBytes), width: 150),
                    ],
                  ],
                ),
              ],
            );
          },
        ),
      );
    }

    // Save PDF to file
    final path =
        '${downloadsDirectory.path}/admin_riwayat_${date.toIso8601String()}.pdf';
    final file = File(path);
    await file.writeAsBytes(await pdf.save());

    // Open the PDF
    // await OpenFile.open(file.path);
    print('PDF saved to: $path');
  }

  Future<Uint8List> _getImageBytes(String imageUrl) async {
    // Method to fetch image bytes via HTTP request
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      throw Exception('Failed to fetch image bytes: $e');
    }
  }

  Future<bool> _requestStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      return true;
    } else {
      return false;
    }
  }

  Future<Directory?> getDownloadsDirectory() async {
    if (Platform.isAndroid) {
      final directory = await getExternalStorageDirectory();
      if (directory != null) {
        final downloadsDirectory = Directory('${directory.path}/Download');
        if (await downloadsDirectory.exists()) {
          return downloadsDirectory;
        } else {
          await downloadsDirectory.create(recursive: true);
          return downloadsDirectory;
        }
      }
    } else if (Platform.isIOS) {
      return await getApplicationDocumentsDirectory();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Riwayat',
          style: TextStyle(
            fontFamily: 'Poppins-Medium',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF01CBEF),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf, color: Colors.red),
            onPressed: _exportToPdf,
          ),
        ],
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
        if (controller.results.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              constraints: BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(controller.results.length, (index) {
                  var result = controller.results[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            result['result'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (result['explanation'].isNotEmpty) ...[
                            const Text(
                              'Penjelasan:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              result['explanation'],
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 10),
                          ],
                          if (result['imageUrl'].isNotEmpty) ...[
                            const Text(
                              'Gambar:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                result['imageUrl'],
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
              ),
            ),
          ),
        );
      }),
    );
  }
}
