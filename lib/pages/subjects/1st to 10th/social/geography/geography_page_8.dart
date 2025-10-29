import 'package:flutter/material.dart';

class GeographyPage8 extends StatefulWidget {
  const GeographyPage8({Key? key}) : super(key: key);

  @override
  State<GeographyPage8> createState() => _GeographyPage8State();
}

class _GeographyPage8State extends State<GeographyPage8> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed('/social');
          },
        ),
        title: const Text('Geography'),
      ),
      body: const Center(
        child: Text('Welcome to Geography Page'),
      ),
    );
  }
}