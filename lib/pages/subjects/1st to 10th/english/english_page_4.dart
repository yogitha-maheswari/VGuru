import 'package:flutter/material.dart';

class EnglishPage4 extends StatefulWidget {
  const EnglishPage4({Key? key}) : super(key: key);

  @override
  State<EnglishPage4> createState() => _EnglishPage4State();
}

class _EnglishPage4State extends State<EnglishPage4> {
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