import 'package:flutter/material.dart';

class ChemistryPage6 extends StatefulWidget {
  const ChemistryPage6({Key? key}) : super(key: key);

  @override
  State<ChemistryPage6> createState() => _ChemistryPage6State();
}

class _ChemistryPage6State extends State<ChemistryPage6> {
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