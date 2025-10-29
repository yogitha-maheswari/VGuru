import 'package:flutter/material.dart';

class PhysicsPage10 extends StatefulWidget {
  const PhysicsPage10({Key? key}) : super(key: key);

  @override
  State<PhysicsPage10> createState() => _PhysicsPage10State();
}

class _PhysicsPage10State extends State<PhysicsPage10> {
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