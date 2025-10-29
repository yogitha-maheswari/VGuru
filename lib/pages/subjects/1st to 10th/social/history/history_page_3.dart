import 'package:flutter/material.dart';

class HistoryPage3 extends StatefulWidget {
  const HistoryPage3({Key? key}) : super(key: key);

  @override
  State<HistoryPage3> createState() => _HistoryPage3State();
}

class _HistoryPage3State extends State<HistoryPage3> {
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