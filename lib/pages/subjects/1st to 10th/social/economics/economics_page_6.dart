import 'package:flutter/material.dart';

class EconomicsPage6 extends StatefulWidget {
  const EconomicsPage6({Key? key}) : super(key: key);

  @override
  State<EconomicsPage6> createState() => _EconomicsPage6State();
}

class _EconomicsPage6State extends State<EconomicsPage6> {
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