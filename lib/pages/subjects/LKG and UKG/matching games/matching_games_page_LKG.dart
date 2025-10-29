import 'package:flutter/material.dart';

class MatchingGamesPageLKG extends StatefulWidget {
  const MatchingGamesPageLKG({Key? key}) : super(key: key);

  @override
  State<MatchingGamesPageLKG> createState() => _MatchingGamesPageLKGState();
}

class _MatchingGamesPageLKGState extends State<MatchingGamesPageLKG> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed('/home');
          },
        ),
        title: const Text('Matching Games'),
      ),
      body: const Center(
        child: Text('Welcome to Matching Games Page'),
      ),
    );
  }
}