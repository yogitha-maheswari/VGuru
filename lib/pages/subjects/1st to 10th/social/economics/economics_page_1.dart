import 'package:flutter/material.dart';

class EconomicsPage1 extends StatefulWidget {
  const EconomicsPage1({Key? key}) : super(key: key);

  @override
  State<EconomicsPage1> createState() => _EconomicsPage1State();
}

class _EconomicsPage1State extends State<EconomicsPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed('/social');
          },
        ),
        title: const Text('Economics'),
      ),
      body: const Center(
        child: Text('Welcome to Economics Page'),
      ),
    );
  }
}