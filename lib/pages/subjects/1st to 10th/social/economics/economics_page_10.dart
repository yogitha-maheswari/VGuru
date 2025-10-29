import 'package:flutter/material.dart';

class EconomicsPage10 extends StatefulWidget {
  const EconomicsPage10({Key? key}) : super(key: key);

  @override
  State<EconomicsPage10> createState() => _EconomicsPage10State();
}

class _EconomicsPage10State extends State<EconomicsPage10> {
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