import 'package:flutter/material.dart';
import 'package:vguru/pages/settings/sections/section_header.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Terms of Service'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- Terms Container ---
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SectionHeader(title: 'Terms of Service'),
                        const SizedBox(height: 24),

                        // Intro Text
                        Text(
                          "Welcome to our Terms of Service.",
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 20),

                        _sectionBox(
                          context,
                          title: "1. Use of Service",
                          points: [
                            "This app provides academic support, quizzes, and practice resources.",
                            "You agree to use the service responsibly.",
                          ],
                        ),
                        const SizedBox(height: 16),

                        _sectionBox(
                          context,
                          title: "2. Accounts",
                          points: [
                            "You must provide accurate information during registration.",
                            "You are responsible for maintaining the confidentiality of your login details.",
                          ],
                        ),
                        const SizedBox(height: 16),

                        _sectionBox(
                          context,
                          title: "3. Content",
                          points: [
                            "All learning materials are for personal use only.",
                            "Do not distribute or copy without permission.",
                          ],
                        ),
                        const SizedBox(height: 16),

                        _sectionBox(
                          context,
                          title: "4. Privacy",
                          points: [
                            "We respect your privacy. See our Privacy Policy for more details.",
                          ],
                        ),
                        const SizedBox(height: 16),

                        _sectionBox(
                          context,
                          title: "5. Limitations",
                          points: [
                            "We are not liable for interruptions or data losses caused by misuse.",
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Closing text
                        Text(
                          "By using this app, you agree to follow these terms.",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.onSurface.withOpacity(0.85),
                          ),
                        ),

                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section box with border, title and bullet points
  Widget _sectionBox(BuildContext context,
      {required String title, required List<String> points}) {
    final theme = Theme.of(context);
    final Color boxBorder = theme.dividerColor.withOpacity(0.38);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.03),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: boxBorder, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          ...points.map((p) => Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("• "),
                    Expanded(
                      child: Text(
                        p,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          height: 1.4,
                          color: theme.colorScheme.onSurface.withOpacity(0.85),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
        ],
      ),
    );
  }
}
