import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'global_key.dart';
import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Prototipo Multiplataforma',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MainScreen(), // Establecer la pantalla principal
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  final List<Map<String, String>> slides = const [
    {
      'image': 'images/machinelearning.webp',
      'title': 'Aprendizaje automático para aplicaciones multiplataforma',
      'text': 'Prototipo de implementación de ML (machine learning) en dispositivos móviles, web y desktops ',
    },
    {
      'image': 'images/mlkit.jpg',
      'title': 'Google ML Kit ',
      'text': 'Implementación del kit de aprendizaje automático ofrecido por Google para dispositivos móviles',
    },
    {
      'image': 'images/tensorflow.jpeg',
      'title': 'Tensor Flow',
      'text': 'Implementación de Tensor Flow, librerías de creación, entrenamiento e implementación de modelos de aprendizaje automático para diferentes plataformas',
    },
  ];

  final CarouselSliderController _controller = CarouselSliderController();

  int _currentIndex = 0;

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
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CarouselSlider(
              
              options: CarouselOptions(
                height: 400.0,
                autoPlay: false,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: slides.map((slide) {
                return Builder(
                  builder: (BuildContext context) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          
                          child: Image.asset(
                            slide['image']!,
                            fit: BoxFit.contain,
                            height: 270,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          slide['title']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          slide['text']!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    );
                  },
                );
              }).toList(),
              carouselController: _controller,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: slides.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () {
                    _controller.animateToPage(
                      entry.key,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      );
                    setState(() {
                      _currentIndex = entry.key;
                    });
                    
                  },
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (_currentIndex == entry.key
                          ? Colors.green
                          : Colors.grey),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24), // Espacio entre el slider y el contenido siguiente
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen, // Fondo verde claro
                foregroundColor: Colors.white, // Color del texto
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w600, // Peso de la fuente
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Borde redondeado
                ),
                shadowColor: Colors.black.withOpacity(0.5), // Color de sombra
                elevation: 5, // Elevación de la sombra
              ),
              child: const Text( // Este es el child necesario para ElevatedButton
                'Ingresar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}