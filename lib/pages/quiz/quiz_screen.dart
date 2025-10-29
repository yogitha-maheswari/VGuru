import 'package:flutter/material.dart';
import 'package:vguru/widgets/quiz_widget.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String subjectName = args?['subject'] ?? 'General Studies';
    final String topicTitle = args?['topic'] ?? 'Introduction to Concepts';

    final quiz = QuizData(
      title: 'Test Your Understanding',
      subtitle: 'Answer the following sample questions to test your knowledge.',
      questions: [
        QuestionData(
          question: 'Sample Question 1: What is the correct answer?',
          options: [
            'Wrong Answer 1',
            'Wrong Answer 2',
            'Correct Answer',
            'Wrong Answer 3',
          ],
          correctIndex: 2,
        ),
        QuestionData(
          question: 'Sample Question 2: Choose the right statement.',
          options: [
            'Correct Answer',
            'Wrong Answer 1',
            'Wrong Answer 2',
            'Wrong Answer 3',
          ],
          correctIndex: 0,
        ),
        QuestionData(
          question: 'Sample Question 3: Which one is true?',
          options: [
            'Wrong Answer 1',
            'Correct Answer',
            'Wrong Answer 2',
            'Wrong Answer 3',
          ],
          correctIndex: 1,
        ),
      ],
    );

    return QuizPage(
      quiz: quiz,
      subjectName: subjectName,
      topicName: topicTitle,
      onGoToVideo: () {
        Navigator.pushNamed(context, '/video', arguments: {
          'subject': subjectName,
          'topic': topicTitle,
        });
      },
      onGoToSummary: () {
        Navigator.pushNamed(context, '/notes', arguments: {
          'subject': subjectName,
          'topic': topicTitle,
        });
      },
    );
  }
}
