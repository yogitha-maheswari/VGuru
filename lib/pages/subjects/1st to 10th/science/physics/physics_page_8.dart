import 'package:flutter/material.dart';

class PhysicsPage8 extends StatefulWidget {
  const PhysicsPage8({Key? key}) : super(key: key);

  @override
  State<PhysicsPage8> createState() => _PhysicsPage8State();
}

class _PhysicsPage8State extends State<PhysicsPage8> {
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