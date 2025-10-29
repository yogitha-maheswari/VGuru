import 'package:flutter/material.dart';

class ChemistryPage7 extends StatefulWidget {
  const ChemistryPage7({Key? key}) : super(key: key);

  @override
  State<ChemistryPage7> createState() => _ChemistryPage7State();
}

class _ChemistryPage7State extends State<ChemistryPage7> {
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