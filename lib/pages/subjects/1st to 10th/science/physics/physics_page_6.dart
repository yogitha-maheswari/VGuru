import 'package:flutter/material.dart';

class PhysicsPage6 extends StatefulWidget {
  const PhysicsPage6({Key? key}) : super(key: key);

  @override
  State<PhysicsPage6> createState() => _PhysicsPage6State();
}

class _PhysicsPage6State extends State<PhysicsPage6> {
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