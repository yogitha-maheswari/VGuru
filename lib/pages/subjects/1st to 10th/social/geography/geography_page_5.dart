import 'package:flutter/material.dart';

class GeographyPage5 extends StatefulWidget {
  const GeographyPage5({Key? key}) : super(key: key);

  @override
  State<GeographyPage5> createState() => _GeographyPage5State();
}

class _GeographyPage5State extends State<GeographyPage5> {
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
        title: const Text('Geography'),
      ),
      body: const Center(
        child: Text('Welcome to Geography Page'),
      ),
    );
  }
}