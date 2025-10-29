import 'package:flutter/material.dart';

class ChemistryPage1 extends StatefulWidget {
  const ChemistryPage1({Key? key}) : super(key: key);

  @override
  State<ChemistryPage1> createState() => _ChemistryPage1State();
}

class _ChemistryPage1State extends State<ChemistryPage1> {
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