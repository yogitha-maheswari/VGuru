import 'package:flutter/material.dart';
import 'package:vguru/widgets/chapter_widget.dart';

class EnglishPage10 extends StatefulWidget {
  const EnglishPage10({Key? key}) : super(key: key);

  @override
  State<EnglishPage10> createState() => _EnglishPage10State();
}

class _EnglishPage10State extends State<EnglishPage10> {
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
        title: const Text('English'),
      ),
      body: Chapters(
        subjectName: 'English',
        chapters: const [
          {
            'title': 'Reading Comprehension',
            'topics': ['Nouns and Pronouns', 'Verbs and Tenses', 'Adverbs'],
          },
          {
            'title': 'Grammar Basics',
            'topics': ['Adjectives', 'Prepositions', 'Conjunctions'],
          },
          {
            'title': 'Writing & Composition',
            'topics': ['Phrasal Verbs', 'Idioms', 'Proverbs'],
          },
        ],
      ),
    );
  }
}

