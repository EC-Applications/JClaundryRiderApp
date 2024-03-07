import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../data/model/response/laundry_order_details_model.dart';
import '../../../../data/model/response/order_details_model.dart';

Future<Uint8List> generatePdf(PdfPageFormat format,
   {@required  LaundryOrderDetails orderDetailsModel}) async {
  final pdf = pw.Document();

  final ByteData data = await rootBundle.load("assets/image/logo_name.png");
  final Uint8List bytes = data.buffer.asUint8List();
  final image = pw.MemoryImage(bytes);

  List<Map<String, dynamic>> apiData = [];
for (var item in orderDetailsModel.details) {
  apiData.add({
    'name': item.laundryItem.name,
    'services': item.service.name,
    'qty': item.quantity,
    'price': item.price,
    'total': item.price * item.quantity, // You may need to adjust this calculation based on your requirements
  });
}

  num overallTotal = 0;
  num addons = 0;
  num subtotal = addons + overallTotal;
  num Discount = 0;

  num  couponDiscount = orderDetailsModel.discountAmount;
  num  vat = orderDetailsModel.taxAmount;
  String DeliveryFee = orderDetailsModel.deliveryCharge;
  num deliveryFeenew = num.parse(DeliveryFee);
  
  num MainTotal = subtotal - couponDiscount + vat + deliveryFeenew;
   //num MainTotal = subtotal ;

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
            pw.SizedBox(height: 3),
            pw.Text('Items Total : RS $overallTotal',
                style: pw.TextStyle(fontSize: 8,)),
            pw.Text('Addon Cost: RS $addons', style: pw.TextStyle(fontSize: 8)),
            pw.Text('SubTotal : RS ${addons + overallTotal}',
                style: pw.TextStyle(fontSize: 8)),
            // pw.Text('Discount: RS $Discount', style: pw.TextStyle(fontSize: 8)),
            pw.Text('Coupon Discount: RS $couponDiscount',
                style: pw.TextStyle(fontSize: 8)),
            pw.Text('VAT/TAX: RS $vat', style: pw.TextStyle(fontSize: 8)),
            pw.Text('Delivery Fee: RS $DeliveryFee',
                style: pw.TextStyle(fontSize: 8)),
            pw.Text('Total: RS ${addons + overallTotal - couponDiscount + vat + deliveryFeenew}', style: pw.TextStyle(fontSize: 8)),
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
