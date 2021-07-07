import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/pdfViewerScreen';

  @override
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  @override
  Widget build(BuildContext context) {
    final file = ModalRoute.of(context)!.settings.arguments as File;
    final name = basename(file.path);
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
          centerTitle: true,
        ),
        body: PDFView(
          filePath: file.path,
        ));
  }
}
