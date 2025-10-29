import 'package:flutter/material.dart';

class GeographyPage7 extends StatefulWidget {
  const GeographyPage7({Key? key}) : super(key: key);

  @override
  State<GeographyPage7> createState() => _GeographyPage7State();
}

class _GeographyPage7State extends State<GeographyPage7> {
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