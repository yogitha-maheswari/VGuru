import 'package:flutter/material.dart';

class CivicsPage9 extends StatefulWidget {
  const CivicsPage9({Key? key}) : super(key: key);

  @override
  State<CivicsPage9> createState() => _CivicsPage9State();
}

class _CivicsPage9State extends State<CivicsPage9> {
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