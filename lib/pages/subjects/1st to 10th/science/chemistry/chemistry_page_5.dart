import 'package:flutter/material.dart';

class ChemistryPage5 extends StatefulWidget {
  const ChemistryPage5({Key? key}) : super(key: key);

  @override
  State<ChemistryPage5> createState() => _ChemistryPage5State();
}

class _ChemistryPage5State extends State<ChemistryPage5> {
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