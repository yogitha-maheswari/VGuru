import 'package:flutter/material.dart';

class CivicsPage1 extends StatefulWidget {
  const CivicsPage1({Key? key}) : super(key: key);

  @override
  State<CivicsPage1> createState() => _CivicsPage1State();
}

class _CivicsPage1State extends State<CivicsPage1> {
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