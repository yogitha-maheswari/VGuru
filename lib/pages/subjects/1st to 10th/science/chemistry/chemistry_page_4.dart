import 'package:flutter/material.dart';

class ChemistryPage4 extends StatefulWidget {
  const ChemistryPage4({Key? key}) : super(key: key);

  @override
  State<ChemistryPage4> createState() => _ChemistryPage4State();
}

class _ChemistryPage4State extends State<ChemistryPage4> {
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