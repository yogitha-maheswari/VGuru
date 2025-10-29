import 'package:flutter/material.dart';

class GeographyPage9 extends StatefulWidget {
  const GeographyPage9({Key? key}) : super(key: key);

  @override
  State<GeographyPage9> createState() => _GeographyPage9State();
}

class _GeographyPage9State extends State<GeographyPage9> {
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