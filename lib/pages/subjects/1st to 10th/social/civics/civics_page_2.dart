import 'package:flutter/material.dart';

class CivicsPage2 extends StatefulWidget {
  const CivicsPage2({Key? key}) : super(key: key);

  @override
  State<CivicsPage2> createState() => _CivicsPage2State();
}

class _CivicsPage2State extends State<CivicsPage2> {
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