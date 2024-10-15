import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class BarcodeScanner {
  Future<void> scanBarcode(BuildContext context) async {
    if (kIsWeb || Platform.isWindows) {
      // Para web y Windows, usamos ImagePicker
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        String result = '';

        if (kIsWeb) {
          result = await _webBarcodeScanning(image);
        } else if (Platform.isWindows) {
          result = await _windowsBarcodeScanning(image);
        }

        _showResultDialog(context, result);
      }
    } else {
      // Para móvil, usamos QRViewExample
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QRViewExample()),
      );
    }
  }

  Future<String> _webBarcodeScanning(XFile image) async {
    // Implementar usando quagga.js o zxing
    return 'Escaneo de código en web usando quagga.js/zxing (no implementado)';
  }

  Future<String> _windowsBarcodeScanning(XFile image) async {
    // Implementar usando ZXing.NET
    return 'Escaneo de código en Windows usando ZXing.NET (no implementado)';
  }

  void _showResultDialog(BuildContext context, String result) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Resultado de Escaneo de Código'),
        content: Text(result),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({super.key});

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String result = "No se ha escaneado nada aún";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Escanear Código')),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text('Resultado: $result'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code!;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}