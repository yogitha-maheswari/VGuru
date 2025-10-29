import 'package:flutter/material.dart';

class HistoryPage1 extends StatefulWidget {
  const HistoryPage1({Key? key}) : super(key: key);

  @override
  State<HistoryPage1> createState() => _HistoryPage1State();
}

class _HistoryPage1State extends State<HistoryPage1> {
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