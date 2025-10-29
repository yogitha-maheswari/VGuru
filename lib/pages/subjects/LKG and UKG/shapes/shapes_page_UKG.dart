import 'package:flutter/material.dart';

class ShapesPageUKG extends StatefulWidget {
  const ShapesPageUKG({Key? key}) : super(key: key);

  @override
  State<ShapesPageUKG> createState() => _ShapesPageUKGState();
}

class _ShapesPageUKGState extends State<ShapesPageUKG> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed('/home');
          },
        ),
        title: const Text('Shapes'),
      ),
      body: const Center(
        child: Text('Welcome to Shapes Page'),
      ),
    );
  }
}