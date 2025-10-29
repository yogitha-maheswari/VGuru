import 'package:flutter/material.dart';

class HistoryPage5 extends StatefulWidget {
  const HistoryPage5({Key? key}) : super(key: key);

  @override
  State<HistoryPage5> createState() => _HistoryPage5State();
}

class _HistoryPage5State extends State<HistoryPage5> {
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