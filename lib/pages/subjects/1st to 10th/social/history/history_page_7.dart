import 'package:flutter/material.dart';

class HistoryPage7 extends StatefulWidget {
  const HistoryPage7({Key? key}) : super(key: key);

  @override
  State<HistoryPage7> createState() => _HistoryPage7State();
}

class _HistoryPage7State extends State<HistoryPage7> {
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