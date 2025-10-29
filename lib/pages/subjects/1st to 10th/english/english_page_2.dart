import 'package:flutter/material.dart';

class EnglishPage2 extends StatefulWidget {
  const EnglishPage2({Key? key}) : super(key: key);

  @override
  State<EnglishPage2> createState() => _EnglishPage2State();
}

class _EnglishPage2State extends State<EnglishPage2> {
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