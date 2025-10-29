import 'package:flutter/material.dart';

class PoemsPageLKG extends StatefulWidget {
  const PoemsPageLKG({Key? key}) : super(key: key);

  @override
  State<PoemsPageLKG> createState() => _PoemsPageLKGState();
}

class _PoemsPageLKGState extends State<PoemsPageLKG> {
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