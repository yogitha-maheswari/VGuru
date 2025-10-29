import 'package:flutter/material.dart';

class PoemsPageUKG extends StatefulWidget {
  const PoemsPageUKG({Key? key}) : super(key: key);

  @override
  State<PoemsPageUKG> createState() => _PoemsPageUKGState();
}

class _PoemsPageUKGState extends State<PoemsPageUKG> {
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
        title: const Text('Poems'),
      ),
      body: const Center(
        child: Text('Welcome to Poems Page'),
      ),
    );
  }
}