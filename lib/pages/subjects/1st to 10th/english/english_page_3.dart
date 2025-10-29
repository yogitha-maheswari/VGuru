import 'package:flutter/material.dart';

class EnglishPage3 extends StatefulWidget {
  const EnglishPage3({Key? key}) : super(key: key);

  @override
  State<EnglishPage3> createState() => _EnglishPage3State();
}

class _EnglishPage3State extends State<EnglishPage3> {
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