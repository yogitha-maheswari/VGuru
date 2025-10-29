import 'package:flutter/material.dart';

class ShapesPageLKG extends StatefulWidget {
  const ShapesPageLKG({Key? key}) : super(key: key);

  @override
  State<ShapesPageLKG> createState() => _ShapesPageLKGState();
}

class _ShapesPageLKGState extends State<ShapesPageLKG> {
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