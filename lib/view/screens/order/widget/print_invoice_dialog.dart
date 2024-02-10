import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;


void showPrintedConfirmation({@required BuildContext context,@required  String title, @required  String message, @required Callback posmethod}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(title),
          actions: [
            TextButton(

              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel',style: TextStyle(color:Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      .color ),),
            ),
             TextButton(
              onPressed: () {
                try {
  generatePDF(context);
  print("ok");
} catch (error) {
  print("Error: $error");
}

              },
              child: Text('Print'),
            ),
          ],
        );
      },
    );}


Future<void> generatePDF(BuildContext context) async {
  final pdf = pw.Document(
    theme: pw.ThemeData(),
  );
  // Add a page to the PDF
  pdf.addPage(pw.Page(
    build: (pw.Context context) {  // Rename the parameter to avoid conflicts
      return pw.Table(
        children: [
          // Add your table header
          pw.TableRow(
            children: [
              pw.Text('Item', style: pw.TextStyle( fontSize: 22)),
              pw.Text('Quantity', style: pw.TextStyle()),
              pw.Text('Price', style: pw.TextStyle()),
            ],
          ),
          // Add your data rows
          pw.TableRow(
            children: [
              pw.Text('Item 1', style: pw.TextStyle()),
              pw.Text('2', style: pw.TextStyle()),
              pw.Text('\$20.00', style: pw.TextStyle()),
            ],
          ),
          // Add more rows as needed
        ],
      );
    },
  ));

  // Save the PDF to a file
    final documentsDirectory = await getApplicationDocumentsDirectory();
  final file = File(join(documentsDirectory.path, "example.pdf"));
  await file.writeAsBytes(await pdf.save());
  print("PDF File Path: ${file.path}");
  Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PDFView(
          filePath: file.path,
        ),
      ),
    );
  
}

