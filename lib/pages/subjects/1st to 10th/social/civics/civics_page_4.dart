import 'package:flutter/material.dart';

class CivicsPage4 extends StatefulWidget {
  const CivicsPage4({Key? key}) : super(key: key);

  @override
  State<CivicsPage4> createState() => _CivicsPage4State();
}

class _CivicsPage4State extends State<CivicsPage4> {
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