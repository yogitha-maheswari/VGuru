import 'package:flutter/material.dart';

class VideoPage extends StatelessWidget {
  final String subjectName;
  final String topicTitle;
  final VoidCallback? onGoToSummary;
  final VoidCallback? onGoToQuiz;

  const VideoPage({
    Key? key,
    required this.subjectName,
    required this.topicTitle,
    this.onGoToSummary,
    this.onGoToQuiz,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final bool isWide = width >= 800;
    final horizontalPadding = isWide ? 48.0 : 20.0;
    final videoHeight = isWide ? 420.0 : 240.0;
    const double actionHeight = 48;

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
                // ---------- HEADER ----------
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        subjectName,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "$topicTitle - Video Lesson",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ---------- VIDEO PLACEHOLDER ----------
                Container(
                  height: videoHeight,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.background,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: theme.colorScheme.primary.withOpacity(0.06),
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.play_circle_fill_rounded,
                      size: 96,
                      color: Colors.white70,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // ---------- BUTTONS ----------
                LayoutBuilder(
                  builder: (ctx, constraints) {
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
                          buildPrimaryButton(onPressed: onGoToSummary, label: "GO TO NOTES"),
                          const SizedBox(height: 12),
                          buildSecondaryButton(onPressed: onGoToQuiz, label: "GO TO QUIZ"),
                        ],
                      );
                    }

                    return Row(
                      children: [
                        Expanded(
                          child: buildPrimaryButton(onPressed: onGoToSummary, label: "GO TO NOTES"),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: buildSecondaryButton(onPressed: onGoToQuiz, label: "GO TO QUIZ"),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
