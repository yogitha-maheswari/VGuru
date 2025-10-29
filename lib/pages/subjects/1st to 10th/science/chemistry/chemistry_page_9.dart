import 'package:flutter/material.dart';

class ChemistryPage9 extends StatefulWidget {
  const ChemistryPage9({Key? key}) : super(key: key);

  @override
  State<ChemistryPage9> createState() => _ChemistryPage9State();
}

class _ChemistryPage9State extends State<ChemistryPage9> {
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