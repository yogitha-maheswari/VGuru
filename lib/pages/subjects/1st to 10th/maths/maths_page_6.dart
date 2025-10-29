import 'package:flutter/material.dart';

class MathsPage6 extends StatefulWidget {
  const MathsPage6({Key? key}) : super(key: key);

  @override
  State<MathsPage6> createState() => _MathsPage6State();
}

class _MathsPage6State extends State<MathsPage6> {
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