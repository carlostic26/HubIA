import 'package:flutter/material.dart';

class IA {
  final String? name;
  final String? category;
  final String? imageUrl;
  final String? description;
  final String? webUrl;

  IA({this.name, this.category, this.imageUrl, this.description, this.webUrl});
}

/* class DetailScreen extends StatelessWidget {
  final IA ia;

  DetailScreen({required this.ia});

  @override
  Widget build(BuildContext context) {
    // Implementa la pantalla de detalles aquí
    return Scaffold(
      appBar: AppBar(title: Text(ia.name)),
      body: Center(
        child: Text(ia.description),
      ),
    );
  }
} */
