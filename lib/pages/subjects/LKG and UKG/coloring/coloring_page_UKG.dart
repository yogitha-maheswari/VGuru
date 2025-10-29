import 'package:flutter/material.dart';

class ColoringPageUKG extends StatefulWidget {
  const ColoringPageUKG({Key? key}) : super(key: key);

  @override
  State<ColoringPageUKG> createState() => _ColoringPageUKGState();
}

class _ColoringPageUKGState extends State<ColoringPageUKG> {
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