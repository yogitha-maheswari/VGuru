import 'package:flutter/material.dart';

class MathsPage4 extends StatefulWidget {
  const MathsPage4({Key? key}) : super(key: key);

  @override
  State<MathsPage4> createState() => _MathsPage4State();
}

class _MathsPage4State extends State<MathsPage4> {
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