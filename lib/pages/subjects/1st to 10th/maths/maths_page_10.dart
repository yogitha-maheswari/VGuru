import 'package:flutter/material.dart';

class MathsPage10 extends StatefulWidget {
  const MathsPage10({Key? key}) : super(key: key);

  @override
  State<MathsPage10> createState() => _MathsPage10State();
}

class _MathsPage10State extends State<MathsPage10> {
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