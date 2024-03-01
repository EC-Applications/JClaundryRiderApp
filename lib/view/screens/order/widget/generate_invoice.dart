import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../data/model/response/laundry_order_details_model.dart';

Future<Uint8List> generatePdf(PdfPageFormat format,
    {@required orderDetailsModel}) async {
  final pdf = pw.Document();

  final ByteData data = await rootBundle.load("assets/image/logo_name.png");
  final Uint8List bytes = data.buffer.asUint8List();
  final image = pw.MemoryImage(bytes);

  List<Map<String, dynamic>> apiData = [
    {
      'name': 'Towels',
      'services': 'Iron',
      'qty': 3,
      'price': 200,
      'total': 600
    },
    {
      'name': 'Carpet',
      'services': 'Wash',
      'qty': 1,
      'price': 6000,
      'total': 6000
    },
    {
      'name': 'Winter Coat',
      'services': 'Wash',
      'qty': 1,
      'price': 2200,
      'total': 2200
    },
  ];

  int overallTotal = 0;
  int addons = 0;
  int subtotal = addons + overallTotal;

  int Discount = 0;
  int couponDiscount = 0;
  int vat = 0;
  int DeliveryFee = 0;

  int MainTotal = subtotal - Discount - couponDiscount + vat + DeliveryFee;

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
            pw.Center(child: pw.Image(image)),
            pw.Text('Order ID : ${orderDetailsModel.id}',
                style: pw.TextStyle(fontSize: 8)),
            pw.Text(
                'Name : ${orderDetailsModel.destinationAddress?.contactPersonName ?? ''}',
                style: pw.TextStyle(fontSize: 8)),
            pw.Text(
                'Phone : ${orderDetailsModel.destinationAddress?.contactPersonNumber ?? ''}',
                style: pw.TextStyle(fontSize: 8)),

            pw.SizedBox(height: 3),
            //pw.Divider(),
            //     pw.Text('Pickup Info',style: pw.TextStyle(
            //       fontWeight: pw.FontWeight.bold
            //     )),
            // pw.Text('${orderDetailsModel.pickupAddress.address}'),

            pw.Text('Delivery Address',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
            pw.Text('${orderDetailsModel.destinationAddress.address}',
                style: pw.TextStyle(fontSize: 8)),
            // pw.Divider(),
            pw.SizedBox(height: 5),

            for (var row in apiData)
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Data rows
                  pw.Text('${row['services']}',
                      style: pw.TextStyle(
                        fontSize: 8,
                        fontWeight: pw.FontWeight.bold,
                      )),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('${row['name']} (x${row['qty']})',
                          style: pw.TextStyle(fontSize: 8)),
                      pw.Text('${row['price']}',
                          style: pw.TextStyle(fontSize: 8)),
                      pw.Text('Rs ${row['total']}',
                          style: pw.TextStyle(fontSize: 8)),
                    ],
                  ),
                  pw.SizedBox(height: 1),
                ],
              ),

            // pw.Table(
            //   border: pw.TableBorder.all(),
            //   columnWidths: {
            //     0: const pw.FixedColumnWidth(80), // Name
            //     1: const pw.FixedColumnWidth(80), // Services
            //     2: const pw.FixedColumnWidth(30), // Qty
            //     3: const pw.FixedColumnWidth(50), // Price
            //     4: const pw.FixedColumnWidth(70), // Total
            //   },
            //   children: [
            //     pw.TableRow(
            //       children: [
            //         pw.Center(
            //             child:
            //                 pw.Text('Name', style: pw.TextStyle(fontSize: 8))),
            //         pw.Center(
            //             child: pw.Text('Services',
            //                 style: pw.TextStyle(fontSize: 8))),
            //         pw.Center(
            //             child:
            //                 pw.Text('Qty', style: pw.TextStyle(fontSize: 8))),
            //         pw.Center(
            //             child:
            //                 pw.Text('Price', style: pw.TextStyle(fontSize: 8))),
            //         pw.Center(
            //             child:
            //                 pw.Text('Total', style: pw.TextStyle(fontSize: 8))),
            //       ],
            //     ),
            //     for (var row in apiData)
            //       pw.TableRow(
            //         children: [
            //           pw.Center(
            //               child: pw.Text(row['name'].toString(),
            //                   style: pw.TextStyle(fontSize: 8))),
            //           pw.Center(
            //               child: pw.Text(row['services'].toString(),
            //                   style: pw.TextStyle(fontSize: 8))),
            //           pw.Center(
            //               child: pw.Text(row['qty'].toString(),
            //                   style: pw.TextStyle(fontSize: 8))),
            //           pw.Center(
            //               child: pw.Text(row['price'].toString(),
            //                   style: pw.TextStyle(fontSize: 8))),
            //           pw.Center(
            //               child: pw.Text('Rs ${row['total']}',
            //                   style: pw.TextStyle(fontSize: 8))),
            //         ],
            //       ),
            //   ],
            // ),
            // pw.Divider(),
            pw.SizedBox(height: 3),
            pw.Text('Items Total : RS $overallTotal',
                style: pw.TextStyle(fontSize: 8,)),
            pw.Text('Addon Cost: RS $addons', style: pw.TextStyle(fontSize: 8)),
            pw.Text('SubTotal : RS ${addons + overallTotal}',
                style: pw.TextStyle(fontSize: 8)),
            pw.Text('Discount: RS $Discount', style: pw.TextStyle(fontSize: 8)),
            pw.Text('Coupon Discount: RS $couponDiscount',
                style: pw.TextStyle(fontSize: 8)),
            pw.Text('VAT/TAX: RS $vat', style: pw.TextStyle(fontSize: 8)),
            pw.Text('Delivery Fee: RS $DeliveryFee',
                style: pw.TextStyle(fontSize: 8)),
            pw.Text('Total: RS $MainTotal', style: pw.TextStyle(fontSize: 8)),
            pw.Divider(),
            pw.SizedBox(height: 10),
            pw.Center(
                child: pw.Text('Thank You', style: pw.TextStyle(fontSize: 8))),
          ],
        );
      },
    ),
  );

  return pdf.save();
}
