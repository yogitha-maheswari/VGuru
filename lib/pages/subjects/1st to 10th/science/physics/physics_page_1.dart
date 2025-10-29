import 'package:flutter/material.dart';

class PhysicsPage1 extends StatefulWidget {
  const PhysicsPage1({Key? key}) : super(key: key);

  @override
  State<PhysicsPage1> createState() => _PhysicsPage1State();
}

class _PhysicsPage1State extends State<PhysicsPage1> {
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