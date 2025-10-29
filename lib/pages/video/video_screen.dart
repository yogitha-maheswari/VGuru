import 'package:flutter/material.dart';
import 'package:vguru/widgets/video_widget.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String subjectName = args?['subject'] as String? ?? 'Science';
    final String topicTitle = args?['topic'] as String? ?? 'Human Body';

    return VideoPage(
      subjectName: subjectName,
      topicTitle: topicTitle,
      onGoToSummary: () {
        Navigator.pushNamed(context, '/notes', arguments: {
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
