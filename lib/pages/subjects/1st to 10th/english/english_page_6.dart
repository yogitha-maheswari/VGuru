import 'package:flutter/material.dart';

class EnglishPage6 extends StatefulWidget {
  const EnglishPage6({Key? key}) : super(key: key);

  @override
  State<EnglishPage6> createState() => _EnglishPage6State();
}

class _EnglishPage6State extends State<EnglishPage6> {
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