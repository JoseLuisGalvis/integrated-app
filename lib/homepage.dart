import 'package:flutter/material.dart';

import 'barcode_scanner.dart';
import 'facial_recognition.dart';
import 'text_recognition.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prototipo Multiplataforma',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

final FacialRecognition _facialRecognition = FacialRecognition();
  final BarcodeScanner _barcodeScanner = BarcodeScanner();
  final TextRecognition _textRecognition = TextRecognition();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> opciones = [
      {
        'titulo': 'Detección de rostros',
        'descripcion': 'Reconocimiento facial utilizando ML Kit',
        'icono': Icons.face,
        'accion': () async => await _facialRecognition.detectFaces(context),
      },
      {
        'titulo': 'Lectura del Código de Barras',
        'descripcion': 'Escaneo de códigos de barras',
        'icono': Icons.qr_code,
        'accion': () async => await _barcodeScanner.scanBarcode(context),
      },
      {
        'titulo': 'Reconocimiento de Texto',
        'descripcion': 'Reconoce texto en imágenes',
        'icono': Icons.text_fields,
        'accion': () async => await _textRecognition.recognizeText(),
      },
      {
        'titulo': 'Image Labeling',
        'descripcion': 'Etiquetado de imágenes utilizando ML Kit',
        'icono': Icons.label,
        'accion': () async {},
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Prototipo Multiplataforma',
          style: TextStyle(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.w800),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 3 / 2,
              ),
              itemCount: opciones.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    await opciones[index]['accion']();
                  },
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  opciones[index]['titulo'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(opciones[index]['descripcion']),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_forward, size: 32),
                            ],
                          ),
                          SizedBox(width: 16),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
