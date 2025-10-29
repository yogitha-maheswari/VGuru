import 'package:flutter/material.dart';

class CivicsPage5 extends StatefulWidget {
  const CivicsPage5({Key? key}) : super(key: key);

  @override
  State<CivicsPage5> createState() => _CivicsPage5State();
}

class _CivicsPage5State extends State<CivicsPage5> {
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