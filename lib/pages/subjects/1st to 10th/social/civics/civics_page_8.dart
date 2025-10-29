import 'package:flutter/material.dart';

class CivicsPage8 extends StatefulWidget {
  const CivicsPage8({Key? key}) : super(key: key);

  @override
  State<CivicsPage8> createState() => _CivicsPage8State();
}

class _CivicsPage8State extends State<CivicsPage8> {
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
        title: const Text('Civics'),
      ),
      body: const Center(
        child: Text('Welcome to Civics Page'),
      ),
    );
  }
}