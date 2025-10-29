import 'package:flutter/material.dart';

class PhysicsPage2 extends StatefulWidget {
  const PhysicsPage2({Key? key}) : super(key: key);

  @override
  State<PhysicsPage2> createState() => _PhysicsPage2State();
}

class _PhysicsPage2State extends State<PhysicsPage2> {
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