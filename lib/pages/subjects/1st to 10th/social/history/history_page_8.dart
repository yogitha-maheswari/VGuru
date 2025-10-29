import 'package:flutter/material.dart';

class HistoryPage8 extends StatefulWidget {
  const HistoryPage8({Key? key}) : super(key: key);

  @override
  State<HistoryPage8> createState() => _HistoryPage8State();
}

class _HistoryPage8State extends State<HistoryPage8> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed('/social');
          },
        ),
        title: const Text('History'),
      ),
      body: const Center(
        child: Text('Welcome to History Page'),
      ),
    );
  }
}