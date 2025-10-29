import 'package:flutter/material.dart';

class MathsPage2 extends StatefulWidget {
  const MathsPage2({Key? key}) : super(key: key);

  @override
  State<MathsPage2> createState() => _MathsPage2State();
}

class _MathsPage2State extends State<MathsPage2> {
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