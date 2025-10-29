import 'package:flutter/material.dart';

class MathsPage3 extends StatefulWidget {
  const MathsPage3({Key? key}) : super(key: key);

  @override
  State<MathsPage3> createState() => _MathsPage3State();
}

class _MathsPage3State extends State<MathsPage3> {
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