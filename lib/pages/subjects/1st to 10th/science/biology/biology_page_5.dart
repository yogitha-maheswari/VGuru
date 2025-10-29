import 'package:flutter/material.dart';

class BiologyPage5 extends StatefulWidget {
  const BiologyPage5({Key? key}) : super(key: key);

  @override
  State<BiologyPage5> createState() => _BiologyPage5State();
}

class _BiologyPage5State extends State<BiologyPage5> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed('/science');
          },
        ),
        title: const Text('Biology'),
      ),
      body: const Center(
        child: Text('Welcome to Biology Page'),
      ),
    );
  }
}