import 'package:flutter/material.dart';

class PhysicsPage7 extends StatefulWidget {
  const PhysicsPage7({Key? key}) : super(key: key);

  @override
  State<PhysicsPage7> createState() => _PhysicsPage7State();
}

class _PhysicsPage7State extends State<PhysicsPage7> {
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