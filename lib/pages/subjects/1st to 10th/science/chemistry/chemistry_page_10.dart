import 'package:flutter/material.dart';

class ChemistryPage10 extends StatefulWidget {
  const ChemistryPage10({Key? key}) : super(key: key);

  @override
  State<ChemistryPage10> createState() => _ChemistryPage10State();
}

class _ChemistryPage10State extends State<ChemistryPage10> {
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