import 'package:flutter/material.dart';

class BiologyPage4 extends StatefulWidget {
  const BiologyPage4({Key? key}) : super(key: key);

  @override
  State<BiologyPage4> createState() => _BiologyPage4State();
}

class _BiologyPage4State extends State<BiologyPage4> {
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