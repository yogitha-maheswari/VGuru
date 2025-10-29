import 'package:flutter/material.dart';

class CivicsPage6 extends StatefulWidget {
  const CivicsPage6({Key? key}) : super(key: key);

  @override
  State<CivicsPage6> createState() => _CivicsPage6State();
}

class _CivicsPage6State extends State<CivicsPage6> {
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