import 'package:flutter/material.dart';

class ColoringPageLKG extends StatefulWidget {
  const ColoringPageLKG({Key? key}) : super(key: key);

  @override
  State<ColoringPageLKG> createState() => _ColoringPageLKGState();
}

class _ColoringPageLKGState extends State<ColoringPageLKG> {
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
        title: const Text('Coloring'),
      ),
      body: const Center(
        child: Text('Welcome to Coloring Page'),
      ),
    );
  }
}