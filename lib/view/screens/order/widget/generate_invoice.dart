import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../data/model/response/laundry_order_details_model.dart';


Future<Uint8List> generatePdf(PdfPageFormat format,{@required orderDetailsModel}) async {
  final pdf = pw.Document();

    final ByteData data = await rootBundle.load("assets/image/logo_name.png");
    final Uint8List bytes = data.buffer.asUint8List();
    final image = pw.MemoryImage(bytes);

    List<Map<String, dynamic>> apiData = [
    {'name': 'Towels', 'services': 'Iron', 'qty': 3, 'price': 200, 'total': 600},
    {'name': 'Carpet', 'services': 'Wash', 'qty': 1, 'price': 6000, 'total': 6000},
    {'name': 'Winter Coat', 'services': 'Wash', 'qty': 1, 'price': 2200, 'total': 2200},
  ];
  // ---------------inside widget
 int overallTotal = 0;
 int addons = 0;
 int subtotal = addons+overallTotal;

  int Discount = 0;
  int couponDiscount = 0;
  int vat= 0;
  int DeliveryFee= 0;

int MainTotal = subtotal - Discount - couponDiscount +vat + DeliveryFee;



 for (var item in apiData) {
    overallTotal += item['total'];
  }
 
  pdf.addPage(
    pw.Page(
      pageFormat: format,
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Center(
              child: pw.Image(image)
            ),
             pw.Text('Order ID : ${orderDetailsModel.id}'),
             pw.Text('Name : ${orderDetailsModel.destinationAddress?.contactPersonName ?? ''}'),
             pw.Text('Phone : ${orderDetailsModel.destinationAddress?.contactPersonNumber ?? ''}'),
             pw.Divider(),
                pw.Text('Pickup Info',style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold
                )),
            pw.Text('${orderDetailsModel.pickupAddress.address}'),   
                pw.SizedBox(height: 10),
              pw.Text('Destination Info',style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold
                )),
            pw.Text('${orderDetailsModel.destinationAddress.address}'),   
          
             pw.Divider(),
          pw.SizedBox(height: 10),

        pw.Table(
            border: pw.TableBorder.all(),
            children: [
              pw.TableRow(
                children: [
                  pw.Center(child: pw.Text('Name')),
                  pw.Center(child: pw.Text('Servicces')),
                  pw.Center(child: pw.Text('Qty')),
                  pw.Center(child: pw.Text('Price')),
                  pw.Center(child: pw.Text('Total')),
                ],
              ),
              for (var row in apiData)
                pw.TableRow(
                  children: [
                    pw.Center(child: pw.Text(row['name'].toString())),
                    pw.Center(child: pw.Text(row['services'].toString())),
                    pw.Center(child: pw.Text(row['qty'].toString())),
                    pw.Center(child: pw.Text(row['price'].toString())),
                    pw.Center(child: pw.Text('Rs ${row['total']}')),
                  ],
                ),
            ],
          ),
        pw.Divider(),
          pw.SizedBox(height: 10),
             pw.Text('Items Total : RS $overallTotal'),
             pw.Text('Addon Cost: RS $addons'),
             pw.Text('SubTotal : RS ${addons+overallTotal}'),
             pw.Text('Discount: RS $Discount'),
             pw.Text('Coupon Discount: RS $couponDiscount'),
             pw.Text('VAT/TAX: RS $vat'),
             pw.Text('Delivery Fee: RS $DeliveryFee'),

             pw.SizedBox(height: 30),
             pw.Text('Total: RS $MainTotal'),

                pw.Divider(),
          pw.SizedBox(height: 10),
           pw.Center(child: pw.Text('Thank You')),
          ]
        );
      },
    ),
  );

  return pdf.save();
}