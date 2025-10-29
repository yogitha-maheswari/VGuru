import 'package:flutter/material.dart';

class CivicsPage7 extends StatefulWidget {
  const CivicsPage7({Key? key}) : super(key: key);

  @override
  State<CivicsPage7> createState() => _CivicsPage7State();
}

class _CivicsPage7State extends State<CivicsPage7> {
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