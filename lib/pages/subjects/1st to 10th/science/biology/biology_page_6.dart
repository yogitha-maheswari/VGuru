import 'package:flutter/material.dart';

class BiologyPage6 extends StatefulWidget {
  const BiologyPage6({Key? key}) : super(key: key);

  @override
  State<BiologyPage6> createState() => _BiologyPage6State();
}

class _BiologyPage6State extends State<BiologyPage6> {
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