import 'package:flutter/material.dart';

class BiologyPage2 extends StatefulWidget {
  const BiologyPage2({Key? key}) : super(key: key);

  @override
  State<BiologyPage2> createState() => _BiologyPage2State();
}

class _BiologyPage2State extends State<BiologyPage2> {
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