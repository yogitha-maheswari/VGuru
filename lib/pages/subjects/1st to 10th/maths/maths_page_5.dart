import 'package:flutter/material.dart';

class MathsPage5 extends StatefulWidget {
  const MathsPage5({Key? key}) : super(key: key);

  @override
  State<MathsPage5> createState() => _MathsPage5State();
}

class _MathsPage5State extends State<MathsPage5> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed('/home');
          },
        ),
        title: const Text('Maths'),
      ),
      body: const Center(
        child: Text('Welcome to Maths Page'),
      ),
    );
  }
}