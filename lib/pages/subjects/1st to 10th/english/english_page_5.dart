import 'package:flutter/material.dart';

class EnglishPage5 extends StatefulWidget {
  const EnglishPage5({Key? key}) : super(key: key);

  @override
  State<EnglishPage5> createState() => _EnglishPage5State();
}

class _EnglishPage5State extends State<EnglishPage5> {
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