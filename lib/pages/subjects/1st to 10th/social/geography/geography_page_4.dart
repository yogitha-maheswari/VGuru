import 'package:flutter/material.dart';

class GeographyPage4 extends StatefulWidget {
  const GeographyPage4({Key? key}) : super(key: key);

  @override
  State<GeographyPage4> createState() => _GeographyPage4State();
}

class _GeographyPage4State extends State<GeographyPage4> {
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