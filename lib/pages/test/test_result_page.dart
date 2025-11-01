// lib/pages/test/test_result_page.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TestResultPage extends StatefulWidget {
  final List<Map<String, dynamic>> questions;
  final List<int?> selectedAnswers;
  final Duration? timeLeft;
  final int screenSwitches;

  const TestResultPage({
    super.key,
    required this.questions,
    required this.selectedAnswers,
    this.timeLeft,
    required this.screenSwitches,
  });

  @override
  State<TestResultPage> createState() => _TestResultPageState();
}

class _TestResultPageState extends State<TestResultPage> {
  late final bool _testValid;

  @override
  void initState() {
    super.initState();
    _testValid = widget.screenSwitches < 3;
  }

  String _timeTaken() {
    if (widget.timeLeft == null) return '-';
    final left = widget.timeLeft!;
    final mm = left.inMinutes.toString().padLeft(2, '0');
    final ss = left.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$mm:$ss left';
  }

  int? _correctIndex(Map<String, dynamic> q) {
    if (q.containsKey('correctIndex')) return q['correctIndex'] as int?;
    if (q.containsKey('correctAnswer')) return q['correctAnswer'] as int?;
    return null;
  }

  Map<String, dynamic> _computeResults() {
    final total = widget.questions.length;
    int correct = 0;
    final incorrect = <int>[];
    final skipped = <int>[];
    final correctList = <int>[];
    final topicMistakes = <String, int>{};

    for (int i = 0; i < total; i++) {
      final q = widget.questions[i];
      final selected = widget.selectedAnswers.length > i ? widget.selectedAnswers[i] : null;
      final correctIdx = _correctIndex(q);
      final topic = q['topic']?.toString() ?? 'General';

      if (selected == null) {
        skipped.add(i + 1);
        topicMistakes[topic] = (topicMistakes[topic] ?? 0) + 1;
      } else if (selected == correctIdx) {
        correct++;
        correctList.add(i + 1);
      } else {
        incorrect.add(i + 1);
        topicMistakes[topic] = (topicMistakes[topic] ?? 0) + 1;
      }
    }

    final percentage = total == 0 ? 0.0 : (correct / total) * 100.0;

    final improvementAreas = topicMistakes.entries
        .map((e) => {
              'topic': e.key,
              'suggestion': _topicSuggestion(e.key),
            })
        .toList();

    return {
      'total': total,
      'correct': correct,
      'incorrect': incorrect,
      'skipped': skipped,
      'correctList': correctList,
      'percentage': percentage,
      'improvementAreas': improvementAreas,
    };
  }

  String _topicSuggestion(String topic) {
    const map = {
      'Nouns': 'Revise naming words and plural forms.',
      'Pronouns': 'Practice subject/object pronouns and usage.',
      'Verbs': 'Work on tenses and verb forms.',
      'Adjectives': 'Review descriptive words and comparatives.',
      'Prepositions': 'Revise usage in phrases and clauses.',
    };
    return map[topic] ?? 'Review this topic for better understanding.';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final results = _computeResults();

    final total = results['total'];
    final correct = results['correct'];
    final percentage = results['percentage'] as double;
    final correctList = results['correctList'] as List<int>;
    final incorrectList = results['incorrect'] as List<int>;
    final skippedList = results['skipped'] as List<int>;
    final improvementAreas = results['improvementAreas'] as List<Map<String, String>>;

    final width = MediaQuery.of(context).size.width;
    final compact = width < 700;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Test Result"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 920),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: compact ? 20 : 48, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // HEADER
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Your Test Summary",
                        style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Here’s how you performed in this test.",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // SCORE CARDS
                Row(
                  children: [
                    Expanded(child: _statCard(theme, "Score", "$correct / $total", theme.colorScheme.primary)),
                    const SizedBox(width: 12),
                    Expanded(child: _statCard(theme, "Percentage", "${percentage.toStringAsFixed(1)}%", theme.colorScheme.secondary)),
                    const SizedBox(width: 12),
                    Expanded(child: _statCard(theme, "Time", _timeTaken(), theme.colorScheme.tertiary)),
                  ],
                ),
                const SizedBox(height: 24),

                // QUESTION CHART
                _sectionCard(
                  theme,
                  title: "Question Overview",
                  child: Column(
                    children: [
                      SizedBox(height: 200, child: _buildBarChart(theme)),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _legend(theme.colorScheme.primary, "Correct", theme),
                          const SizedBox(width: 14),
                          _legend(Colors.red, "Incorrect", theme),
                          const SizedBox(width: 14),
                          _legend(Colors.orange, "Skipped", theme),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // PERFORMANCE BREAKDOWN
                _sectionCard(
                  theme,
                  title: "Performance Breakdown",
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _miniInfo(theme, "Correct", correctList.isEmpty ? "—" : correctList.join(", "), Colors.green),
                      _miniInfo(theme, "Incorrect", incorrectList.isEmpty ? "—" : incorrectList.join(", "), Colors.red),
                      _miniInfo(theme, "Skipped", skippedList.isEmpty ? "—" : skippedList.join(", "), Colors.orange),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // AREAS TO IMPROVE
                _sectionCard(
                  theme,
                  title: "Areas to Improve",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center, // Center content horizontally
                    children: [
                      const SizedBox(height: 8),
                      if (improvementAreas.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "No weak areas detected — great work!",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        )
                      else
                        Center(
                          child: Wrap(
                            alignment: WrapAlignment.center, // Center tiles horizontally
                            spacing: 14, // Space between tiles (horizontal)
                            runSpacing: 14, // Space between rows (vertical)
                            children: improvementAreas.map((a) {
                              return _improvementTile(a['topic']!, a['suggestion']!, theme);
                            }).toList(),
                          ),
                        ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),


                const SizedBox(height: 20),

                // TEST STATUS
                _sectionCard(
                  theme,
                  title: "Test Status",
                  child: Row(
                    children: [
                      Icon(
                        _testValid ? Icons.verified : Icons.warning_amber_rounded,
                        color: _testValid ? Colors.green : Colors.red,
                        size: 28,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _testValid ? "Valid attempt" : "Invalid — exceeded screen switch limit",
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: _testValid ? Colors.green : Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: _testValid ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.screenSwitches.toString(),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // ---------------- ACTION BUTTONS ----------------
                LayoutBuilder(
                  builder: (ctx, constraints) {
                    final bool compact = constraints.maxWidth < 700;
                    const double buttonWidth = 320;
                    const double buttonHeight = 48;

                    Widget buildPrimaryButton({
                      required VoidCallback? onPressed,
                      required String label,
                    }) {
                      return Align(
                        alignment: compact ? Alignment.center : Alignment.centerRight,
                        child: SizedBox(
                          width: compact ? double.infinity : buttonWidth,
                          height: buttonHeight,
                          child: ElevatedButton(
                            onPressed: onPressed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
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

                    Widget buildSecondaryButton({
                      required VoidCallback? onPressed,
                      required String label,
                    }) {
                      return Align(
                        alignment: compact ? Alignment.center : Alignment.centerLeft,
                        child: SizedBox(
                          width: compact ? double.infinity : buttonWidth,
                          height: buttonHeight,
                          child: OutlinedButton(
                            onPressed: onPressed,
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: theme.colorScheme.onSurface.withOpacity(0.5)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                            onPressed: () {
                              Navigator.of(context).popUntil((r) => r.isFirst);
                            },
                            label: "BACK TO PRACTICE",
                          ),
                          const SizedBox(height: 12),
                          buildSecondaryButton(
                            onPressed: () => Navigator.pop(context),
                            label: "REVIEW QUESTIONS",
                          ),
                        ],
                      );
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildSecondaryButton(
                          onPressed: () => Navigator.pop(context),
                          label: "REVIEW QUESTIONS",
                        ),
                        buildPrimaryButton(
                          onPressed: () {
                            Navigator.of(context).popUntil((r) => r.isFirst);
                          },
                          label: "BACK TO PRACTICE",
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 60),

                // FOOTER
                Center(
                  child: Text(
                    "“Every result is a new beginning to improve.”",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- COMPONENTS ----------------

  Widget _sectionCard(ThemeData theme, {required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.primary.withOpacity(0.06)),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _statCard(ThemeData theme, String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniInfo(ThemeData theme, String title, String value, Color color) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface)),
          const SizedBox(height: 6),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _improvementTile(String topic, String suggestion, ThemeData theme) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.secondary.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            topic,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            suggestion,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _legend(Color color, String label, ThemeData theme) {
    return Row(
      children: [
        Container(width: 12, height: 12, color: color, margin: const EdgeInsets.only(right: 6)),
        Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface)),
      ],
    );
  }

  Widget _buildBarChart(ThemeData theme) {
    final n = widget.questions.length;
    final bars = List.generate(n, (i) {
      final selected = widget.selectedAnswers.length > i ? widget.selectedAnswers[i] : null;
      final correct = _correctIndex(widget.questions[i]);
      Color color;
      double value;
      if (selected == null) {
        color = Colors.orange;
        value = 0.4;
      } else if (selected == correct) {
        color = theme.colorScheme.primary;
        value = 1.0;
      } else {
        color = Colors.red;
        value = 0.7;
      }
      return {'x': i, 'toY': value, 'color': color};
    });

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 1.2,
        minY: 0,
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (double value, TitleMeta meta) {
                final idx = value.toInt();
                if (idx >= 0 && idx < n) {
                  return SideTitleWidget(
                    meta: meta,
                    child: Text('Q${idx + 1}', style: theme.textTheme.bodySmall),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        barGroups: bars
            .map((b) => BarChartGroupData(
                  x: b['x'] as int,
                  barRods: [
                    BarChartRodData(
                      toY: b['toY'] as double,
                      width: 16,
                      color: b['color'] as Color,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ],
                ))
            .toList(),
        borderData: FlBorderData(show: false),
      ),
    );
  }
}
