import 'package:flutter/material.dart';

class EconomicsPage2 extends StatefulWidget {
  const EconomicsPage2({Key? key}) : super(key: key);

  @override
  State<EconomicsPage2> createState() => _EconomicsPage2State();
}

class _EconomicsPage2State extends State<EconomicsPage2> {
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