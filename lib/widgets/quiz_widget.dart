import 'package:flutter/material.dart';

class QuizData {
  final String title;
  final String subtitle;
  final List<QuestionData> questions;

  QuizData({required this.title, required this.subtitle, required this.questions});
}

class QuestionData {
  final String question;
  final List<String> options;
  final int correctIndex;

  QuestionData({required this.question, required this.options, this.correctIndex = -1});
}

class QuizPage extends StatefulWidget {
  final QuizData quiz;
  final String subjectName;
  final String topicName;
  final VoidCallback? onGoToVideo;
  final VoidCallback? onGoToSummary;

  const QuizPage({
    Key? key,
    required this.quiz,
    required this.subjectName,
    required this.topicName,
    this.onGoToVideo,
    this.onGoToSummary,
  }) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestion = 0;
  late List<int> _selectedOptions;
  late List<bool> _revealedAnswers;

  @override
  void initState() {
    super.initState();
    _selectedOptions = List<int>.filled(widget.quiz.questions.length, -1);
    _revealedAnswers = List<bool>.filled(widget.quiz.questions.length, false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final quiz = widget.quiz;

    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 800;
    final horizontalPadding = isWide ? 48.0 : 20.0;
    final cardPadding = isWide ? 24.0 : 16.0;
    const double actionHeight = 48;

    if (quiz.questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.surface,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(
          child: Text('No questions available', style: theme.textTheme.bodyLarge),
        ),
      );
    }

    final qIndex = _currentQuestion.clamp(0, quiz.questions.length - 1);
    final question = quiz.questions[qIndex];

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 920),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ---------- Header ----------
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        widget.subjectName,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${widget.topicName} - Quiz',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ---------- Quiz Card ----------
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(cardPadding),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.background,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: theme.colorScheme.primary.withOpacity(0.06)),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            quiz.title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            quiz.subtitle,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Question ${qIndex + 1} of ${quiz.questions.length}',
                                style: theme.textTheme.bodyMedium,
                              ),
                              Text(
                                '${_answeredCount()}/${quiz.questions.length} answered',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: (qIndex + 1) / quiz.questions.length,
                              minHeight: 8,
                              backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                              color: theme.colorScheme.primary,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Clear Section row with arrow icons (previous / next) and clear action
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Previous arrow
                              SizedBox(
                                height: 40,
                                width: 40,
                                child: OutlinedButton(
                                  onPressed: qIndex > 0
                                      ? () {
                                          setState(() {
                                            _currentQuestion = qIndex - 1;
                                          });
                                        }
                                      : null,
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: qIndex > 0 ? theme.colorScheme.onSurface : theme.colorScheme.onSurface.withOpacity(0.38),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),

                              // Clear Selection button
                              TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    _selectedOptions = List<int>.filled(widget.quiz.questions.length, -1);
                                    _revealedAnswers = List<bool>.filled(widget.quiz.questions.length, false);
                                    _currentQuestion = 0;
                                  });
                                },
                                icon: Icon(Icons.clear, color: theme.colorScheme.primary, size: 18),
                                label: Text(
                                  'Clear Selection',
                                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary),
                                ),
                                style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6)),
                              ),
                              const SizedBox(width: 8),

                              // Next / Finish arrow
                              SizedBox(
                                height: 40,
                                width: 40,
                                child: ElevatedButton(
                                  onPressed: qIndex < quiz.questions.length - 1
                                      ? () {
                                          setState(() {
                                            _currentQuestion = qIndex + 1;
                                          });
                                        }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                  child: Icon(
                                    qIndex < quiz.questions.length - 1 ? Icons.arrow_forward : Icons.check,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          Text(
                            question.question,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),

                          const SizedBox(height: 16),

                          ...List.generate(question.options.length, (optIndex) {
                            final isSelected = _selectedOptions[qIndex] == optIndex;
                            final isCorrect = optIndex == question.correctIndex;
                            final revealed = _revealedAnswers[qIndex];
                            Color? tileColor;
                            Widget? secondary;
                            if (revealed) {
                              if (isCorrect) {
                                tileColor = Colors.green.withOpacity(0.1);
                                secondary = const Icon(Icons.check, color: Colors.green);
                              } else if (isSelected && !isCorrect) {
                                tileColor = Colors.red.withOpacity(0.1);
                                secondary = const Icon(Icons.close, color: Colors.red);
                              }
                            }

                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: tileColor ?? Colors.transparent,
                                border: Border.all(
                                  color: isSelected
                                      ? theme.colorScheme.primary.withOpacity(0.6)
                                      : theme.colorScheme.onSurface.withOpacity(0.1),
                                  width: 1,
                                ),
                              ),
                              child: RadioListTile<int>(
                                value: optIndex,
                                groupValue: _selectedOptions[qIndex],
                                onChanged: revealed
                                    ? null
                                    : (val) {
                                        setState(() {
                                          _selectedOptions[qIndex] = val!;
                                          _revealedAnswers[qIndex] = true;
                                        });
                                      },
                                title: Text(
                                  question.options[optIndex],
                                  style: theme.textTheme.bodyLarge,
                                ),
                                secondary: secondary,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // ---------- Bottom Buttons ----------
                LayoutBuilder(builder: (ctx, constraints) {
                  final bool compact = constraints.maxWidth < 520;

                  Widget buildPrimaryButton({required VoidCallback? onPressed, required String label}) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: 320,
                          height: actionHeight,
                          child: ElevatedButton(
                            onPressed: onPressed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child: Text(
                              label,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    Widget buildSecondaryButton({required VoidCallback? onPressed, required String label}) {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: 320,
                          height: actionHeight,
                          child: OutlinedButton(
                            onPressed: onPressed,
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: theme.colorScheme.onSurface.withOpacity(0.5),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child: Text(
                              label,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    
                  if (compact) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        buildPrimaryButton(onPressed: widget.onGoToVideo, label: "GO TO VIDEO"),
                        const SizedBox(height: 12),
                        buildSecondaryButton(onPressed: widget.onGoToSummary, label: "GO TO NOTES"),
                      ],
                    );
                  }

                  return Row(
                    children: [
                      Expanded(child: buildPrimaryButton(onPressed: widget.onGoToVideo, label: "GO TO VIDEO")),
                      const SizedBox(width: 16),
                      Expanded(child: buildSecondaryButton(onPressed: widget.onGoToSummary, label: "GO TO NOTES")),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int _answeredCount() => _selectedOptions.where((v) => v >= 0).length;
}
