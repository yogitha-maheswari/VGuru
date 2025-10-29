import 'package:flutter/material.dart';

class EconomicsPage3 extends StatefulWidget {
  const EconomicsPage3({Key? key}) : super(key: key);

  @override
  State<EconomicsPage3> createState() => _EconomicsPage3State();
}

class _EconomicsPage3State extends State<EconomicsPage3> {
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