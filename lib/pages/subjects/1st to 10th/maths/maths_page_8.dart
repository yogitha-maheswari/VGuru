import 'package:flutter/material.dart';

class MathsPage8 extends StatefulWidget {
  const MathsPage8({Key? key}) : super(key: key);

  @override
  State<MathsPage8> createState() => _MathsPage8State();
}

class _MathsPage8State extends State<MathsPage8> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed('/home');
          },
        ),
        title: const Text('Maths'),
      ),
      body: const Center(
        child: Text('Welcome to Maths Page'),
      ),
    );
  }
}