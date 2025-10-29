import 'package:flutter/material.dart';

class GeographyPage2 extends StatefulWidget {
  const GeographyPage2({Key? key}) : super(key: key);

  @override
  State<GeographyPage2> createState() => _GeographyPage2State();
}

class _GeographyPage2State extends State<GeographyPage2> {
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