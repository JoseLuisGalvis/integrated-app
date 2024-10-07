import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'global_key.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FacialRecognition {
  Future<void> detectFaces() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image;

    // Determinar si usar cámara o selector de imágenes
    if (kIsWeb) {
      image = await _webCaptureImage();
    } else if (Platform.isWindows) {
      image = await _windowsCaptureImage();
    } else {
      image = await _picker.pickImage(source: ImageSource.camera);
    }

    if (image != null) {
      String result = '';

      if (kIsWeb) {
        result = await _webFaceDetection(image);
      } else if (Platform.isWindows) {
        result = await _windowsFaceDetection(image);
      } else {
        result = await _mobileFaceDetection(image);
      }

      showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => AlertDialog(
          title: Text('Resultado de Detección Facial'),
          content: Text(result),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  Future<XFile?> _webCaptureImage() async {
    // Lógica para capturar imagen en la web (ej. usando la API de MediaDevices)
    return null; // Deberás implementar la captura usando algo como TensorFlow.js.
  }

  Future<XFile?> _windowsCaptureImage() async {
    // Aquí debes integrar una solución como OpenCV para capturar imágenes desde la cámara en Windows.
    // Se puede usar FFI para interactuar con bibliotecas C++ como OpenCV si decides hacerlo manualmente.
    return null; // Implementar la captura en Windows
  }

  Future<String> _webFaceDetection(XFile image) async {
    return 'Detección facial en Web no implementada';
  }

  Future<String> _windowsFaceDetection(XFile image) async {
    // Implementa OpenCV o DLib en Windows para la detección facial
    return 'Detección facial en Windows no implementada';
  }

  Future<String> _mobileFaceDetection(XFile image) async {
    // Convertir la imagen a InputImage para Google ML Kit
    final inputImage = InputImage.fromFilePath(image.path);

    final options = FaceDetectorOptions(
      enableLandmarks: true,
      enableContours: true,
      enableClassification: true,
    );

    final faceDetector = FaceDetector(options: options);
    final List<Face> faces = await faceDetector.processImage(inputImage);

    String result = '';

    if (faces.isEmpty) {
      result = 'No se han detectado rostros en la imagen.';
    } else {
      for (Face face in faces) {
        result += 'Rostro detectado en: ${face.boundingBox}\n';

        if (face.smilingProbability != null) {
          result += 'Probabilidad de sonrisa: ${face.smilingProbability!.toStringAsFixed(2)}\n';
        }
        if (face.leftEyeOpenProbability != null && face.rightEyeOpenProbability != null) {
          result += 'Ojo izquierdo: ${face.leftEyeOpenProbability!.toStringAsFixed(2)}, Ojo derecho: ${face.rightEyeOpenProbability!.toStringAsFixed(2)}\n';
        }

        result += '\n';
      }
    }

    faceDetector.close();

    return result;
  }
}







