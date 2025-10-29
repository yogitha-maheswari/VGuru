import 'package:flutter/material.dart';

class MathsPage7 extends StatefulWidget {
  const MathsPage7({Key? key}) : super(key: key);

  @override
  State<MathsPage7> createState() => _MathsPage7State();
}

class _MathsPage7State extends State<MathsPage7> {
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