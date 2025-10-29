import 'package:flutter/material.dart';

class PhysicsPage4 extends StatefulWidget {
  const PhysicsPage4({Key? key}) : super(key: key);

  @override
  State<PhysicsPage4> createState() => _PhysicsPage4State();
}

class _PhysicsPage4State extends State<PhysicsPage4> {
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