import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vguru/pages/test/test_completion_page.dart';
import 'package:vguru/utils/test_utils.dart';
import 'package:vguru/widgets/question_option_tile.dart';

class TestQuestionPage extends StatefulWidget {
  final String testName;
  final String subjectDisplay;
  final int questions;
  final int marks;
  final int time;

  const TestQuestionPage({
    super.key,
    required this.testName,
    required this.subjectDisplay,
    required this.questions,
    required this.marks,
    required this.time,
  });

  @override
  State<TestQuestionPage> createState() => _TestQuestionPageState();
}

class _TestQuestionPageState extends State<TestQuestionPage>
    with WidgetsBindingObserver {
  late final int totalSeconds;
  late Duration _remainingTime;
  late Timer _timer;
  int _screenSwitches = 0;
  late final int minAttemptMinutes;
  int _elapsedSeconds = 0;
  bool _canSubmit = false;

  late final List<Map<String, dynamic>> _questions;
  late List<int?> _selectedAnswers;
  int _currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    totalSeconds = widget.time * 60;
    _remainingTime = Duration(seconds: totalSeconds);
    minAttemptMinutes = widget.time >= 10 ? 10 : widget.time;

    final sample = TestUtils.sampleQuestions;
    _questions = List.generate(widget.questions, (i) {
      final base = sample[i % sample.length];
      return {
        'question': base['question'] ?? 'Sample Question ${i + 1}',
        'options': (base['options'] is Iterable)
            ? List<String>.from((base['options'] as Iterable).cast<String>())
            : <String>['A', 'B', 'C', 'D'],
        'topic': base['topic'] ?? 'General',
      };
    });

    _selectedAnswers = List<int?>.filled(widget.questions, null);

    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _screenSwitches++;
      if (_screenSwitches < 3) {
        TestUtils.showWarningDialog(context, _screenSwitches);
      } else {
        TestUtils.showAutoSubmitCountdown(context, _autoSubmitTest);
      }
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (_remainingTime.inSeconds > 0) {
          _remainingTime -= const Duration(seconds: 1);
          _elapsedSeconds = totalSeconds - _remainingTime.inSeconds;
          if (!_canSubmit && _elapsedSeconds >= (minAttemptMinutes * 60)) {
            _canSubmit = true;
          }
        } else {
          _timer.cancel();
          _autoSubmitTest();
        }
      });
    });
  }

  void _autoSubmitTest() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => TestCompletionPage(
          questions: _questions,
          selectedAnswers: _selectedAnswers,
          timeLeft: _remainingTime,
          screenSwitches: _screenSwitches,
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    final result = await TestUtils.showExitDialog(context);
    if (result == true) {
      _timer.cancel();
      _autoSubmitTest();
      return true;
    }
    return false;
  }

  void _selectAnswer(int index) {
    setState(() => _selectedAnswers[_currentQuestionIndex] = index);
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() => _currentQuestionIndex++);
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() => _currentQuestionIndex--);
    }
  }

  VoidCallback? _getNextButtonAction() {
    if (_currentQuestionIndex == _questions.length - 1) {
      final allAnswered = _selectedAnswers.every((a) => a != null);
      return (allAnswered && _canSubmit) ? _confirmAndSubmit : null;
    }
    return _nextQuestion;
  }

  void _confirmAndSubmit() {
    TestUtils.showConfirmSubmitDialog(context, onSubmit: () {
      _timer.cancel();
      _autoSubmitTest();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final compact = width < 700;

    final int marksPerQuestion = (widget.marks / widget.questions).round();
    final currentQuestion = _questions[_currentQuestionIndex];

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            '${widget.testName} - ${widget.subjectDisplay}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: false,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 18, top: 8, bottom: 8),
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(1, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  TestUtils.formatTime(_remainingTime),
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],

        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary.withOpacity(0.04),
                theme.colorScheme.secondary.withOpacity(0.04),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            final double horizontalPadding = compact ? 20 : 48;
            return SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 920),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // ---------- Question Number Grid ----------
                        TestUtils.questionNumberGrid(
                          theme,
                          constraints,
                          _questions.length,
                          _currentQuestionIndex,
                          _selectedAnswers,
                          onTap: (idx) =>
                              setState(() => _currentQuestionIndex = idx),
                        ),
                        const SizedBox(height: 16),

                        // ---------- Question Card ----------
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.background,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color:
                                  theme.colorScheme.primary.withOpacity(0.08),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // --- Header ---
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Question ${_currentQuestionIndex + 1} of ${_questions.length}",
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "$marksPerQuestion Marks",
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: theme.colorScheme.onSurface
                                          .withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),

                              // --- Question Text ---
                              Text(
                                currentQuestion['question'] ?? '',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(height: 14),

                              // --- Options ---
                              ...List.generate(
                                currentQuestion['options'].length,
                                (index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3),
                                  child: QuestionOptionTile(
                                    optionText:
                                        currentQuestion['options'][index],
                                    index: index,
                                    isSelected:
                                        _selectedAnswers[_currentQuestionIndex] ==
                                            index,
                                    onTap: () => _selectAnswer(index),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 60),

                        // ---------- Action Buttons ----------
                        TestUtils.actionButtons(
                          theme: theme,
                          compact: compact,
                          currentIndex: _currentQuestionIndex,
                          totalQuestions: _questions.length,
                          onPrevious: _previousQuestion,
                          onNextOrSubmit: _getNextButtonAction(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
