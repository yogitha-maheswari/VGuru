import 'package:flutter/material.dart';

class EconomicsPage5 extends StatefulWidget {
  const EconomicsPage5({Key? key}) : super(key: key);

  @override
  State<EconomicsPage5> createState() => _EconomicsPage5State();
}

class _EconomicsPage5State extends State<EconomicsPage5> {
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