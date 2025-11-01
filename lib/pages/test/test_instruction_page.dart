import 'package:flutter/material.dart';
import 'package:vguru/pages/test/test_question_page.dart';

class TestInstructionPage extends StatefulWidget {
  final String testName;
  final String subjectDisplay;
  final int time;
  final int marks;
  final int questions;

  const TestInstructionPage({
    super.key,
    required this.testName,
    required this.subjectDisplay,
    required this.time,
    required this.marks,
    required this.questions,
  });

  @override
  State<TestInstructionPage> createState() => _TestInstructionPageState();
}

class _TestInstructionPageState extends State<TestInstructionPage> {
  bool _isAgreed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 800;
    final horizontalPadding = isWide ? 48.0 : 20.0;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Test Instructions"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 920),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---------------- HEADER ----------------
                Center(
                  child: Column(
                    children: [
                      Text(
                        "${widget.testName} - ${widget.subjectDisplay}",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Read the instructions carefully before starting your test.",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 36),

                // ---------------- INSTRUCTION CARD ----------------
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(isWide ? 32 : 24),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.background,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: theme.colorScheme.primary.withOpacity(0.06),
                    ),
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
                      _buildInstructionItem(
                        "1. You will have ${widget.time} minutes to complete this test.",
                      ),
                      _buildInstructionItem(
                        "2. The test consists of ${widget.questions} questions carrying a total of ${widget.marks} marks.",
                      ),
                      _buildInstructionItem(
                        "3. There is no negative marking for wrong answers.",
                      ),
                      _buildInstructionItem(
                        "4. You can navigate between questions using Next/Previous buttons.",
                      ),
                      _buildInstructionItem(
                        "5. You can mark questions for review and revisit them later.",
                      ),
                      _buildInstructionItem(
                        "6. Do not refresh or leave the page during the test.",
                      ),
                      _buildInstructionItem(
                        "7. Malpractice is monitored. Switching between apps or screens may result in automatic termination.",
                      ),

                      const SizedBox(height: 28),

                      // ---------------- AGREEMENT BOX ----------------
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: theme.colorScheme.outline.withOpacity(0.2),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: _isAgreed,
                              onChanged: (val) =>
                                  setState(() => _isAgreed = val ?? false),
                              activeColor: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: Text(
                                    "I have read and understood all the instructions carefully.",
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurface,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                    const double actionHeight = 48;
                    const double actionWidth = 320;

                    Widget buildPrimaryButton({
                      required VoidCallback? onPressed,
                      required String label,
                    }) {
                      return Align(
                        alignment:
                            compact ? Alignment.center : Alignment.centerRight,
                        child: SizedBox(
                          width: compact ? double.infinity : actionWidth,
                          height: actionHeight,
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
                        alignment:
                            compact ? Alignment.center : Alignment.centerLeft,
                        child: SizedBox(
                          width: compact ? double.infinity : actionWidth,
                          height: actionHeight,
                          child: OutlinedButton(
                            onPressed: onPressed,
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color:
                                    theme.colorScheme.onSurface.withOpacity(0.5),
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
                          buildPrimaryButton(
                            onPressed: _isAgreed
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TestQuestionPage(
                                              testName: widget.testName,
                                              subjectDisplay: widget.subjectDisplay,
                                              time: widget.time,
                                              questions: widget.questions,
                                              marks: widget.marks,
                                            ),
                                      ),
                                    );
                                  }
                                : null,
                            label: "START TEST",
                          ),
                          const SizedBox(height: 12),
                          buildSecondaryButton(
                            onPressed: () => Navigator.pop(context),
                            label: "GO TO HOME",
                          ),
                        ],
                      );
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildSecondaryButton(
                          onPressed: () => Navigator.pop(context),
                          label: "GO TO HOME",
                        ),
                        buildPrimaryButton(
                          onPressed: _isAgreed
                              ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TestQuestionPage(
                                            testName: widget.testName,
                                              subjectDisplay: widget.subjectDisplay,
                                              time: widget.time,
                                              questions: widget.questions,
                                              marks: widget.marks,
                                          ),
                                    ),
                                  );
                                }
                              : null,
                          label: "START TEST",
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 60),

                // ---------------- FOOTER ----------------
                Center(
                  child: Text(
                    "“Stay calm and give your best effort.”",
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

  Widget _buildInstructionItem(String text) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.8),
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
