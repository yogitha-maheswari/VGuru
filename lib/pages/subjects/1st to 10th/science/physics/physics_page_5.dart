import 'package:flutter/material.dart';

class PhysicsPage5 extends StatefulWidget {
  const PhysicsPage5({Key? key}) : super(key: key);

  @override
  State<PhysicsPage5> createState() => _PhysicsPage5State();
}

class _PhysicsPage5State extends State<PhysicsPage5> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed('/science');
          },
        ),
        title: const Text('Physics'),
      ),
      body: const Center(
        child: Text('Welcome to Physics Page'),
      ),
    );
  }
}