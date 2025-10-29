import 'package:flutter/material.dart';

class CivicsPage3 extends StatefulWidget {
  const CivicsPage3({Key? key}) : super(key: key);

  @override
  State<CivicsPage3> createState() => _CivicsPage3State();
}

class _CivicsPage3State extends State<CivicsPage3> {
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