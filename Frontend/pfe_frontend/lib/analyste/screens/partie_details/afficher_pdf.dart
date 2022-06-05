import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class VoirPDF extends StatefulWidget {
  final String localPath;
  const VoirPDF({Key? key , required this.localPath }) : super(key: key);

  @override
  State<VoirPDF> createState() => _VoirPDFState();
}

class _VoirPDFState extends State<VoirPDF>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voir Pdf"),
      ),
      body: widget.localPath != ""
          ? PDFView(
              filePath: widget.localPath,
            )
          :
          Text("No file found")
          
          ,
    );
  }
}