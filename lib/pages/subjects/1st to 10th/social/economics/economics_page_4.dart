import 'package:flutter/material.dart';

class EconomicsPage4 extends StatefulWidget {
  const EconomicsPage4({Key? key}) : super(key: key);

  @override
  State<EconomicsPage4> createState() => _EconomicsPage4State();
}

class _EconomicsPage4State extends State<EconomicsPage4> {
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