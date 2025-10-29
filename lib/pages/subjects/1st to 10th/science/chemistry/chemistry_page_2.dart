import 'package:flutter/material.dart';

class ChemistryPage2 extends StatefulWidget {
  const ChemistryPage2({Key? key}) : super(key: key);

  @override
  State<ChemistryPage2> createState() => _ChemistryPage2State();
}

class _ChemistryPage2State extends State<ChemistryPage2> {
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