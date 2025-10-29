import 'package:flutter/material.dart';

class ChemistryPage3 extends StatefulWidget {
  const ChemistryPage3({Key? key}) : super(key: key);

  @override
  State<ChemistryPage3> createState() => _ChemistryPage3State();
}

class _ChemistryPage3State extends State<ChemistryPage3> {
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