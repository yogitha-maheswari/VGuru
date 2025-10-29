import 'package:flutter/material.dart';

class GeographyPage3 extends StatefulWidget {
  const GeographyPage3({Key? key}) : super(key: key);

  @override
  State<GeographyPage3> createState() => _GeographyPage3State();
}

class _GeographyPage3State extends State<GeographyPage3> {
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