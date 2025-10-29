import 'package:flutter/material.dart';

class HistoryPage4 extends StatefulWidget {
  const HistoryPage4({Key? key}) : super(key: key);

  @override
  State<HistoryPage4> createState() => _HistoryPage4State();
}

class _HistoryPage4State extends State<HistoryPage4> {
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