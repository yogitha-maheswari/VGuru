import 'package:flutter/material.dart';
import 'package:vguru/pages/settings/sections/section_header.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

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
        title: Text('Privacy Policy'),
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
                  // --- Privacy Container ---
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SectionHeader(title: 'Privacy Policy'),
                        const SizedBox(height: 24),

                        // Intro Text
                        Text(
                          "Your privacy matters to us.",
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 20),

                        _sectionBox(
                          context,
                          title: "1. Data Collection",
                          points: [
                            "We collect minimal personal data required to provide our services.",
                            "This includes your name, email, and usage activity.",
                          ],
                        ),
                        const SizedBox(height: 16),

                        _sectionBox(
                          context,
                          title: "2. Data Usage",
                          points: [
                            "Your data is used to personalize your experience and improve app features.",
                            "We do not sell or share your data with third parties.",
                          ],
                        ),
                        const SizedBox(height: 16),

                        _sectionBox(
                          context,
                          title: "3. Cookies & Tracking",
                          points: [
                            "We use cookies to understand usage patterns and enhance performance.",
                            "You can manage cookie preferences in your device settings.",
                          ],
                        ),
                        const SizedBox(height: 16),

                        _sectionBox(
                          context,
                          title: "4. Security",
                          points: [
                            "We implement industry-standard security measures to protect your data.",
                            "However, no method of transmission is 100% secure.",
                          ],
                        ),
                        const SizedBox(height: 16),

                        _sectionBox(
                          context,
                          title: "5. Your Rights",
                          points: [
                            "You can request access, correction, or deletion of your personal data.",
                            "Contact support for any privacy-related concerns.",
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Closing text
                        Text(
                          "By using this app, you consent to our privacy practices.",
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
              )),
        ],
      ),
    );
  }
}
