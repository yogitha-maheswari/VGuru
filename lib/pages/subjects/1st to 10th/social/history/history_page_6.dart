import 'package:flutter/material.dart';

class HistoryPage6 extends StatefulWidget {
  const HistoryPage6({Key? key}) : super(key: key);

  @override
  State<HistoryPage6> createState() => _HistoryPage6State();
}

class _HistoryPage6State extends State<HistoryPage6> {
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