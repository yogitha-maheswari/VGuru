import 'package:flutter/material.dart';

class HistoryPage2 extends StatefulWidget {
  const HistoryPage2({Key? key}) : super(key: key);

  @override
  State<HistoryPage2> createState() => _HistoryPage2State();
}

class _HistoryPage2State extends State<HistoryPage2> {
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