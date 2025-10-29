import 'package:flutter/material.dart';

class PhysicsPage3 extends StatefulWidget {
  const PhysicsPage3({Key? key}) : super(key: key);

  @override
  State<PhysicsPage3> createState() => _PhysicsPage3State();
}

class _PhysicsPage3State extends State<PhysicsPage3> {
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