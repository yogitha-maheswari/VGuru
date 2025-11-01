import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vguru/pages/test/test_instruction_page.dart';

class TestIntroPage extends StatelessWidget {
  final String testName;
  final String? selectedSubject;
  final int marks;
  final int time;
  final int questions;
  final int coins;
  final int rank;
  final int streak;

  const TestIntroPage({
    super.key,
    required this.testName,
    required this.marks,
    required this.time,
    required this.questions,
    required this.coins,
    required this.rank,
    required this.streak,
    required this.selectedSubject,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 800;
    final horizontalPadding = isWide ? 48.0 : 20.0;
    final subjectDisplay = selectedSubject ?? "No Subject Selected";

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back_rounded, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Test Overview"),
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double imageHeight =
                (constraints.maxHeight * 0.35).clamp(140.0, 220.0);

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 920),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ---------------- HEADER ----------------
                      SizedBox(
                        height: imageHeight,
                        child: Image.asset(
                          'assets/images/practice.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "Level Up Your Learning!",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          "Prepare yourself before starting the test. Check details and get ready!",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color:
                                theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),

                      // ---------------- STATS BAR ----------------
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [
                              theme.colorScheme.primary.withOpacity(0.15),
                              theme.colorScheme.secondary.withOpacity(0.15),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          border: Border.all(
                            color: theme.colorScheme.primary.withOpacity(0.05),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.shadow.withOpacity(0.08),
                              blurRadius: 6,
                              offset: const Offset(2, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStatColumn(
                              FontAwesomeIcons.trophy,
                              "$rank",
                              "Trophy",
                              const Color(0xFFE2B30A),
                              context,
                            ),
                            _buildStatColumn(
                              FontAwesomeIcons.coins,
                              "$coins",
                              "Coins",
                              Colors.amber.shade700,
                              context,
                            ),
                            _buildStatColumn(
                              FontAwesomeIcons.fire,
                              "$streak",
                              "Streak",
                              const Color(0xFFE86412),
                              context,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // ---------------- INFO CARD ----------------
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
                              blurRadius: 5,
                              offset: const Offset(2, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow(context, "Subject", subjectDisplay),
                            _buildInfoRow(context, "Test Name",
                                "$subjectDisplay - $testName"),
                            _buildInfoRow(
                                context, "Total Questions", "$questions"),
                            _buildInfoRow(context, "Duration", "$time minutes"),
                            _buildInfoRow(context, "Maximum Marks", "$marks"),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      // ---------------- BUTTONS OUTSIDE THE BOX ----------------
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
                              alignment: compact
                                  ? Alignment.center
                                  : Alignment.centerRight,
                              child: SizedBox(
                                width:
                                    compact ? double.infinity : buttonWidth,
                                height: buttonHeight,
                                child: ElevatedButton(
                                  onPressed: onPressed,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        theme.colorScheme.primary,
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
                              alignment: compact
                                  ? Alignment.center
                                  : Alignment.centerLeft,
                              child: SizedBox(
                                width:
                                    compact ? double.infinity : buttonWidth,
                                height: buttonHeight,
                                child: OutlinedButton(
                                  onPressed: onPressed,
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: theme.colorScheme.onSurface
                                          .withOpacity(0.5),
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
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TestInstructionPage(
                                          testName: testName,
                                          subjectDisplay: subjectDisplay,
                                          time: time,
                                          marks: marks,
                                          questions: questions,
                                        ),
                                      ),
                                    );
                                  },
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
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              buildSecondaryButton(
                                onPressed: () => Navigator.pop(context),
                                label: "GO TO HOME",
                              ),
                              buildPrimaryButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TestInstructionPage(
                                        testName: testName,
                                        subjectDisplay: subjectDisplay,
                                        time: time,
                                        marks: marks,
                                        questions: questions,
                                      ),
                                    ),
                                  );
                                },
                                label: "START TEST",
                              ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 60),

                      // ---------------- FOOTER ----------------
                      Text(
                        "“Every test is a step closer to mastery.”",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                          color:
                              theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ---------- REUSABLE WIDGETS ----------
  Widget _buildInfoRow(BuildContext context, String title, String value) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(
    IconData icon,
    String value,
    String label,
    Color color,
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 26),
        const SizedBox(height: 6),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
