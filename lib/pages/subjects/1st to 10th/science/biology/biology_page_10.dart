import 'package:flutter/material.dart';

class BiologyPage10 extends StatefulWidget {
  const BiologyPage10({Key? key}) : super(key: key);

  @override
  State<BiologyPage10> createState() => _BiologyPage10State();
}

class _BiologyPage10State extends State<BiologyPage10> {
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