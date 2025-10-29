import 'package:flutter/material.dart';

class EnglishPage9 extends StatefulWidget {
  const EnglishPage9({Key? key}) : super(key: key);

  @override
  State<EnglishPage9> createState() => _EnglishPage9State();
}

class _EnglishPage9State extends State<EnglishPage9> {
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
        title: const Text('English'),
      ),
      body: const Center(
        child: Text('Welcome to English Page'),
      ),
    );
  }
}