import 'package:flutter/material.dart';

class MatchingGamesPageUKG extends StatefulWidget {
  const MatchingGamesPageUKG({Key? key}) : super(key: key);

  @override
  State<MatchingGamesPageUKG> createState() => _MatchingGamesPageUKGState();
}

class _MatchingGamesPageUKGState extends State<MatchingGamesPageUKG> {
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