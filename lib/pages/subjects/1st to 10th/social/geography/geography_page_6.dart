import 'package:flutter/material.dart';

class GeographyPage6 extends StatefulWidget {
  const GeographyPage6({Key? key}) : super(key: key);

  @override
  State<GeographyPage6> createState() => _GeographyPage6State();
}

class _GeographyPage6State extends State<GeographyPage6> {
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