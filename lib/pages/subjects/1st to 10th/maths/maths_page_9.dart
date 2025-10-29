import 'package:flutter/material.dart';

class MathsPage9 extends StatefulWidget {
  const MathsPage9({Key? key}) : super(key: key);

  @override
  State<MathsPage9> createState() => _MathsPage9State();
}

class _MathsPage9State extends State<MathsPage9> {
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