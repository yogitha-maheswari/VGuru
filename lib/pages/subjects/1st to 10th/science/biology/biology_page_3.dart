import 'package:flutter/material.dart';

class BiologyPage3 extends StatefulWidget {
  const BiologyPage3({Key? key}) : super(key: key);

  @override
  State<BiologyPage3> createState() => _BiologyPage3State();
}

class _BiologyPage3State extends State<BiologyPage3> {
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