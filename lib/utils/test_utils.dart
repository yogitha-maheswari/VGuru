import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class TestUtils {
  // ✅ Sample questions
  static final List<Map<String, dynamic>> sampleQuestions = [
    {
      'question': 'This is a sample question 1?',
      'options': ['Option A', 'Option B', 'Option C', 'Option D'],
      'correctIndex': 1,
      'topic': 'Topic 1',
    },
    {
      'question': 'This is a sample question 2?',
      'options': ['Option A', 'Option B', 'Option C', 'Option D'],
      'correctIndex': 2,
      'topic': 'Topic 1',
    },
    {
      'question': 'This is a sample question 3?',
      'options': ['Option A', 'Option B', 'Option C', 'Option D'],
      'correctIndex': 0,
      'topic': 'Topic 2',
    },
    {
      'question': 'This is a sample question 4?',
      'options': ['Option A', 'Option B', 'Option C', 'Option D'],
      'correctIndex': 0,
      'topic': 'Topic 2',
    },
    {
      'question': 'This is a sample question 5?',
      'options': ['Option A', 'Option B', 'Option C', 'Option D'],
      'correctIndex': 2,
      'topic': 'Topic 3',
    },
    {
      'question': 'This is a sample question 6?',
      'options': ['Option A', 'Option B', 'Option C', 'Option D'],
      'correctIndex': 1,
      'topic': 'Topic 3',
    },
    {
      'question': 'This is a sample question 7?',
      'options': ['Option A', 'Option B', 'Option C', 'Option D'],
      'correctIndex': 0,
      'topic': 'Topic 4',
    },
    {
      'question': 'This is a sample question 8?',
      'options': ['Option A', 'Option B', 'Option C', 'Option D'],
      'correctIndex': 2,
      'topic': 'Topic 4',
    },
    {
      'question': 'This is a sample question 9?',
      'options': ['Option A', 'Option B', 'Option C', 'Option D'],
      'correctIndex': 1,
      'topic': 'Topic 5',
    },
    {
      'question': 'This is a sample question 10?',
      'options': ['Option A', 'Option B', 'Option C', 'Option D'],
      'correctIndex': 1,
      'topic': 'Topic 5',
    },
  ];

  // ✅ Format duration as mm:ss
  static String formatTime(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  // ✅ Calculate score
  static int calculateScore(
    List<int?> selectedAnswers,
    List<Map<String, dynamic>> questions,
  ) {
    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      final correct = questions[i]['correctIndex'];
      if (selectedAnswers[i] != null && selectedAnswers[i] == correct) {
        score++;
      }
    }
    return score;
  }

  // ✅ Screen switch warning (safe)
  static Future<void> showWarningDialog(
      BuildContext context, int screenSwitches) async {
    if (!context.mounted) return;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text("Warning!"),
        content: Text(
          "You switched away from the test $screenSwitches time(s).\n\n"
          "If you switch ${3 - screenSwitches} more time(s), your test will be auto-submitted.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  // ✅ Auto-submit countdown popup (safe)
  static void showAutoSubmitCountdown(
      BuildContext context, VoidCallback onAutoSubmit) {
    if (!context.mounted) return;

    int countdown = 5;
    Timer? countdownTimer;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            countdownTimer ??=
                Timer.periodic(const Duration(seconds: 1), (t) {
              if (!ctx.mounted) {
                t.cancel();
                countdownTimer = null;
                return;
              }

              if (countdown > 1) {
                countdown--;
                setStateDialog(() {});
              } else {
                t.cancel();
                countdownTimer = null;
                if (ctx.mounted) Navigator.of(ctx).pop();
                // Delay the submit slightly to avoid calling context right after dialog close
                Future.delayed(const Duration(milliseconds: 100), onAutoSubmit);
              }
            });

            return AlertDialog(
              title: const Text(
                "Auto Submission",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text(
                "You switched away 3 times.\n\n"
                "Your test will be automatically submitted in $countdown seconds.",
                style: TextStyle(
                  fontSize: 16,
                  color: countdown <= 2 ? Colors.red : Colors.black87,
                  fontWeight: countdown <= 2
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            );
          },
        );
      },
    ).then((_) {
      // Cleanup timer when dialog closed manually (just in case)
      countdownTimer?.cancel();
    });
  }

  // ✅ Confirm exit (safe)
  static Future<bool?> showExitDialog(BuildContext context) async {
    if (!context.mounted) return null;

    final theme = Theme.of(context);
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Exit test?"),
        content:
            const Text("Leaving will submit the test. Are you sure you want to exit?"),
        actions: [
          TextButton(
            onPressed: () {
              if (ctx.mounted) Navigator.of(ctx).pop(false);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (ctx.mounted) Navigator.of(ctx).pop(true);
            },
            child: Text("Exit", style: TextStyle(color: theme.colorScheme.error)),
          ),
        ],
      ),
    );
  }

  // ✅ Confirm submission (safe)
  static void showConfirmSubmitDialog(BuildContext context,
      {required VoidCallback onSubmit}) {
    if (!context.mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text("Submit test?"),
        content: const Text("Are you sure you want to submit the test now?"),
        actions: [
          TextButton(
            onPressed: () {
              if (ctx.mounted) Navigator.of(ctx).pop();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (ctx.mounted) Navigator.of(ctx).pop();
              onSubmit();
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  // ✅ Info header widget
  static Widget infoHeader(ThemeData theme,
      {required String subject, required int questions, required int marks}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _infoTile("Subject", subject, theme),
          _infoTile("Questions", questions.toString(), theme),
          _infoTile("Marks", marks.toString(), theme),
        ],
      ),
    );
  }

  static Widget _infoTile(String title, String value, ThemeData theme) {
    return Column(
      children: [
        Text(
          title,
          style:
              theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style:
              theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // ✅ Question number grid widget
  static Widget questionNumberGrid(
    ThemeData theme,
    BoxConstraints constraints,
    int total,
    int currentIndex,
    List<int?> selectedAnswers, {
    required Function(int) onTap,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: total,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: min(10, max(3, (constraints.maxWidth ~/ 70).toInt())),
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, idx) {
        final isCurrent = idx == currentIndex;
        final answered = selectedAnswers[idx] != null;
        return GestureDetector(
          onTap: () => onTap(idx),
          child: Container(
            decoration: BoxDecoration(
              color: isCurrent
                  ? theme.colorScheme.primary
                  : (answered
                      ? theme.colorScheme.primary.withOpacity(0.08)
                      : theme.colorScheme.surface),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isCurrent
                    ? theme.colorScheme.primary
                    : theme.dividerColor.withOpacity(0.6),
                width: isCurrent ? 2 : 1,
              ),
            ),
            child: Center(
              child: Text(
                '${idx + 1}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isCurrent
                      ? theme.colorScheme.onPrimary
                      : (answered
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ✅ Action buttons (reusable)
  static Widget actionButtons({
    required ThemeData theme,
    required bool compact,
    required int currentIndex,
    required int totalQuestions,
    required VoidCallback? onPrevious,
    required VoidCallback? onNextOrSubmit,
  }) {
    const double actionHeight = 48;
    const double actionWidth = 320;

    Widget buildPrimaryButton(
        {required VoidCallback? onPressed, required String label}) {
      return Align(
        alignment: compact ? Alignment.center : Alignment.centerRight,
        child: SizedBox(
          width: compact ? double.infinity : actionWidth,
          height: actionHeight,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: EdgeInsets.zero,
              elevation: 0,
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

    Widget buildSecondaryButton(
        {required VoidCallback? onPressed, required String label}) {
      return Align(
        alignment: compact ? Alignment.center : Alignment.centerLeft,
        child: SizedBox(
          width: compact ? double.infinity : actionWidth,
          height: actionHeight,
          child: OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              side:
                  BorderSide(color: theme.colorScheme.onSurface.withOpacity(0.5)),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
          buildPrimaryButton(
            onPressed: onNextOrSubmit,
            label: currentIndex == totalQuestions - 1 ? "SUBMIT" : "NEXT",
          ),
          const SizedBox(height: 12),
          buildSecondaryButton(
            onPressed: currentIndex > 0 ? onPrevious : null,
            label: "PREVIOUS",
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildSecondaryButton(
          onPressed: currentIndex > 0 ? onPrevious : null,
          label: "PREVIOUS",
        ),
        buildPrimaryButton(
          onPressed: onNextOrSubmit,
          label: currentIndex == totalQuestions - 1 ? "SUBMIT" : "NEXT",
        ),
      ],
    );
  }
}
