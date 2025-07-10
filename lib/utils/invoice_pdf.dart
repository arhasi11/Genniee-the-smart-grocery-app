import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/material.dart';

void generateInvoice(BuildContext context, {
  required String customer,
  required String address,
  required List<Map<String, dynamic>> items,
  required int total,
}) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text("GENNIE INVOICE", style: pw.TextStyle(fontSize: 24)),
          pw.SizedBox(height: 20),
          pw.Text("Customer: $customer"),
          pw.Text("Address: $address"),
          pw.SizedBox(height: 10),
          pw.Text("Items:"),
          ...items.map((item) => pw.Text("- ${item['name']} x${item['quantity']} = ₹${item['price'] * item['quantity']}")),
          pw.SizedBox(height: 10),
          pw.Text("Total: ₹$total", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ],
      ),
    ),
  );

  await Printing.layoutPdf(onLayout: (format) => pdf.save());
}
