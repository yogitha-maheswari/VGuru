import 'package:flutter/material.dart';

class GeographyPage1 extends StatefulWidget {
  const GeographyPage1({Key? key}) : super(key: key);

  @override
  State<GeographyPage1> createState() => _GeographyPage1State();
}

class _GeographyPage1State extends State<GeographyPage1> {
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