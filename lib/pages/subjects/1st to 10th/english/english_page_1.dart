import 'package:flutter/material.dart';

class EnglishPage1 extends StatefulWidget {
  const EnglishPage1({Key? key}) : super(key: key);

  @override
  State<EnglishPage1> createState() => _EnglishPage1State();
}

class _EnglishPage1State extends State<EnglishPage1> {
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