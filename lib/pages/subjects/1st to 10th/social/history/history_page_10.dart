import 'package:flutter/material.dart';

class HistoryPage10 extends StatefulWidget {
  const HistoryPage10({Key? key}) : super(key: key);

  @override
  State<HistoryPage10> createState() => _HistoryPage10State();
}

class _HistoryPage10State extends State<HistoryPage10> {
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