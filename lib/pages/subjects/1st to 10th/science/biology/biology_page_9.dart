import 'package:flutter/material.dart';

class BiologyPage9 extends StatefulWidget {
  const BiologyPage9({Key? key}) : super(key: key);

  @override
  State<BiologyPage9> createState() => _BiologyPage9State();
}

class _BiologyPage9State extends State<BiologyPage9> {
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