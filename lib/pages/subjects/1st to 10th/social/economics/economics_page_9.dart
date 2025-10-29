import 'package:flutter/material.dart';

class EconomicsPage9 extends StatefulWidget {
  const EconomicsPage9({Key? key}) : super(key: key);

  @override
  State<EconomicsPage9> createState() => _EconomicsPage9State();
}

class _EconomicsPage9State extends State<EconomicsPage9> {
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