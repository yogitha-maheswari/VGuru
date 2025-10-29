import 'package:flutter/material.dart';

class HistoryPage9 extends StatefulWidget {
  const HistoryPage9({Key? key}) : super(key: key);

  @override
  State<HistoryPage9> createState() => _HistoryPage9State();
}

class _HistoryPage9State extends State<HistoryPage9> {
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