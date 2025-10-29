import 'package:flutter/material.dart';

class MathsPage1 extends StatefulWidget {
  const MathsPage1({Key? key}) : super(key: key);

  @override
  State<MathsPage1> createState() => _MathsPage1State();
}

class _MathsPage1State extends State<MathsPage1> {
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