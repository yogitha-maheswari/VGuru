import 'package:flutter/material.dart';
import 'package:vguru/widgets/notes_widget.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // prefer unit (chapter title) if provided, otherwise fall back to subject
    final String subjectName = args?['unit'] as String? ?? args?['subject'] as String? ?? 'English';
    final String topicTitle = args?['topic'] as String? ?? 'Grammar Basics';
    final String content = args?['content'] as String? ?? 'Here goes the detailed notes content for this topic.';

    return NotesPage(
      subjectName: subjectName,
      topicTitle: topicTitle,
      content: content,

      // Provide callbacks that handle navigation / snackbars from here
      onGoToVideo: () {
        Navigator.pushNamed(context, '/video', arguments: {
          'subject': subjectName,
          'topic': topicTitle,
        });
      },
      onGoToQuiz: () {
        Navigator.pushNamed(context, '/quiz', arguments: {
          'subject': subjectName,
          'topic': topicTitle,
        });
      },
    );
  }
}
