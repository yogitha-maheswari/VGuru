import 'package:flutter/material.dart';

class BiologyPage8 extends StatefulWidget {
  const BiologyPage8({Key? key}) : super(key: key);

  @override
  State<BiologyPage8> createState() => _BiologyPage8State();
}

class _BiologyPage8State extends State<BiologyPage8> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed('/science');
          },
        ),
        title: const Text('Biology'),
      ),
      body: const Center(
        child: Text('Welcome to Biology Page'),
      ),
    );
  }
}