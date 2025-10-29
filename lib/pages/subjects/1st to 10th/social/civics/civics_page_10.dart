import 'package:flutter/material.dart';

class CivicsPage10 extends StatefulWidget {
  const CivicsPage10({Key? key}) : super(key: key);

  @override
  State<CivicsPage10> createState() => _CivicsPage10State();
}

class _CivicsPage10State extends State<CivicsPage10> {
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