import 'package:flutter/material.dart';

class EnglishPage7 extends StatefulWidget {
  const EnglishPage7({Key? key}) : super(key: key);

  @override
  State<EnglishPage7> createState() => _EnglishPage7State();
}

class _EnglishPage7State extends State<EnglishPage7> {
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