import 'package:flutter/material.dart';

class EconomicsPage8 extends StatefulWidget {
  const EconomicsPage8({Key? key}) : super(key: key);

  @override
  State<EconomicsPage8> createState() => _EconomicsPage8State();
}

class _EconomicsPage8State extends State<EconomicsPage8> {
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