import 'package:flutter/material.dart';

class EconomicsPage7 extends StatefulWidget {
  const EconomicsPage7({Key? key}) : super(key: key);

  @override
  State<EconomicsPage7> createState() => _EconomicsPage7State();
}

class _EconomicsPage7State extends State<EconomicsPage7> {
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
        title: const Text('Economics'),
      ),
      body: const Center(
        child: Text('Welcome to Economics Page'),
      ),
    );
  }
}