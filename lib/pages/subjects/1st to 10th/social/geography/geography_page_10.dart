import 'package:flutter/material.dart';

class GeographyPage10 extends StatefulWidget {
  const GeographyPage10({Key? key}) : super(key: key);

  @override
  State<GeographyPage10> createState() => _GeographyPage10State();
}

class _GeographyPage10State extends State<GeographyPage10> {
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