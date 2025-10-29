import 'package:flutter/material.dart';

class ChemistryPage8 extends StatefulWidget {
  const ChemistryPage8({Key? key}) : super(key: key);

  @override
  State<ChemistryPage8> createState() => _ChemistryPage8State();
}

class _ChemistryPage8State extends State<ChemistryPage8> {
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
        title: const Text('Chemistry'),
      ),
      body: const Center(
        child: Text('Welcome to Chemistry Page'),
      ),
    );
  }
}