import 'package:flutter/material.dart';

class BiologyPage7 extends StatefulWidget {
  const BiologyPage7({Key? key}) : super(key: key);

  @override
  State<BiologyPage7> createState() => _BiologyPage7State();
}

class _BiologyPage7State extends State<BiologyPage7> {
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