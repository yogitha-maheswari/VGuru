import 'package:flutter/material.dart';

class EnglishPage8 extends StatefulWidget {
  const EnglishPage8({Key? key}) : super(key: key);

  @override
  State<EnglishPage8> createState() => _EnglishPage8State();
}

class _EnglishPage8State extends State<EnglishPage8> {
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