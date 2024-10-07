import 'package:flutter/material.dart';
import 'facial_recognition.dart';
import 'barcode_scanner.dart';
import 'text_recognition.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FacialRecognition _facialRecognition = FacialRecognition();
  final BarcodeScanner _barcodeScanner = BarcodeScanner();
  final TextRecognition _textRecognition = TextRecognition();

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.all(16.0), // Añadir un poco de padding
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                await _facialRecognition.detectFaces();
              },
              child: Card(
                elevation: 4,
                child: Container(
                  width: double.infinity, // Ocupa el 100% del ancho
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start, // Alinea el contenido a la izquierda
                    children: [
                      Icon(Icons.face, size: 32), // Ícono para Reconocimiento Facial
                      SizedBox(width: 8), // Espacio entre el ícono y el texto
                      Text(
                        'Reconocimiento Facial',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                // Aquí puedes cambiar la función a la que quieres llamar
                await _barcodeScanner.scanBarcode(context);
              },
              child: Card(
                elevation: 4,
                child: Container(
                  width: double.infinity, // Ocupa el 100% del ancho
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start, // Alinea el contenido a la izquierda
                    children: [
                      Icon(Icons.barcode_reader, size: 32), // Ícono para Lectura del Código de Barras
                      SizedBox(width: 8), // Espacio entre el ícono y el texto
                      Text(
                        'Lectura del Código de Barras',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                await _textRecognition.recognizeText();
              },
              child: Card(
                elevation: 4,
                child: Container(
                  width: double.infinity, // Ocupa el 100% del ancho
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start, // Alinea el contenido a la izquierda
                    children: [
                      Icon(Icons.text_fields, size: 32), // Ícono para Reconocimiento de Texto
                      SizedBox(width: 8), // Espacio entre el ícono y el texto
                      Text(
                        'Reconocimiento de Texto',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                // Aquí puedes añadir la funcionalidad que quieras
              },
              child: Card(
                elevation: 4,
                child: Container(
                  width: double.infinity, // Ocupa el 100% del ancho
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start, // Alinea el contenido a la izquierda
                    children: [
                      Icon(Icons.label, size: 32), // Ícono para Image Labeling
                      SizedBox(width: 8), // Espacio entre el ícono y el texto
                      Text(
                        'Image Labeling',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Espacio entre las Cards
            SizedBox(height: 16), // Espacio entre las Cards
            Card(
              elevation: 16,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 235, // Altura de la Card
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/ml.png'), // Cambia esta ruta a tu imagen
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(16), // Borde redondeado (0.5em ≈ 8px)
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 235,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black54, // Fondo semitransparente
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Machine Learning',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
