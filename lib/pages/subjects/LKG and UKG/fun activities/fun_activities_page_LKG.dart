import 'package:flutter/material.dart';

class FunActivitiesPageLKG extends StatefulWidget {
  const FunActivitiesPageLKG({Key? key}) : super(key: key);

  @override
  State<FunActivitiesPageLKG> createState() => _FunActivitiesPageLKGState();
}

class _FunActivitiesPageLKGState extends State<FunActivitiesPageLKG> {
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