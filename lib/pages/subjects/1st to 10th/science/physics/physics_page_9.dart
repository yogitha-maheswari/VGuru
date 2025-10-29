import 'package:flutter/material.dart';

class PhysicsPage9 extends StatefulWidget {
  const PhysicsPage9({Key? key}) : super(key: key);

  @override
  State<PhysicsPage9> createState() => _PhysicsPage9State();
}

class _PhysicsPage9State extends State<PhysicsPage9> {
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