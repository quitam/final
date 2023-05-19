import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCode extends StatefulWidget {
  @override
  final String qrData;

  const QRCode({super.key, required this.qrData});
  State<QRCode> createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Ticket QR')),
      body: Center(
        child: QrImageView(
          data: widget.qrData,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
