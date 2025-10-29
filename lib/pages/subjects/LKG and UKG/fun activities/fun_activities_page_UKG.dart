import 'package:flutter/material.dart';

class FunActivitiesPageUKG extends StatefulWidget {
  const FunActivitiesPageUKG({Key? key}) : super(key: key);

  @override
  State<FunActivitiesPageUKG> createState() => _FunActivitiesPageUKGState();
}

class _FunActivitiesPageUKGState extends State<FunActivitiesPageUKG> {
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
        title: const Text('Fun Activities'),
      ),
      body: const Center(
        child: Text('Welcome to Fun Activities Page'),
      ),
    );
  }
}