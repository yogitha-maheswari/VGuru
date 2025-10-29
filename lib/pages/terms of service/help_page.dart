import 'package:flutter/material.dart';
import 'package:vguru/pages/settings/sections/section_header.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final List<bool> _faqExpanded = [false, false, false, false];

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
        title: Text('Help & Support'),
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
                  // --- Contact Details ---
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SectionHeader(title: 'Contact Us'),
                        const SizedBox(height: 24),
                        Text('Email', style: theme.textTheme.labelMedium),
                        const SizedBox(height: 8),
                        _contactBox(
                          label: "Email",
                          context,
                          value: "support@vguru.com",
                          icon: Icons.email,
                        ),
                        const SizedBox(height: 24),
                        Text('Toll-Free Number', style: theme.textTheme.labelMedium),
                        const SizedBox(height: 8),
                        _contactBox(
                          context,
                          label: "Toll-Free",
                          value: "1800-123-456",
                          icon: Icons.phone,
                        ),
                        const SizedBox(height: 24),
                        Text('Response Time', style: theme.textTheme.labelMedium),
                        const SizedBox(height: 8),
                        _contactBox(
                          context,
                          label: "Response Time",
                          value: "Within 24–48 hours",
                          icon: Icons.access_time,
                        ),

                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // --- FAQs ---
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SectionHeader(title: 'FAQs'),
                        const SizedBox(height: 24),
                        _buildFaqItem(
                          index: 0,
                          question: "How do I reset my password?",
                          answers: [
                            "Go to the login screen and tap 'Forgot Password'.",
                            "Follow the instructions sent to your email.",
                          ],
                          theme: theme,
                        ),
                        
                        _buildFaqItem(
                          index: 1,
                          question: "Where can I find my quiz history?",
                          answers: [
                            "Navigate to the 'Profile' tab.",
                            "Select 'Quiz History' to view past attempts.",
                          ],
                          theme: theme,
                        ),
                        
                        _buildFaqItem(
                          index: 2,
                          question: "Can I use the app offline?",
                          answers: [
                            "Some features like saved quizzes are available offline.",
                            "Live updates and sync require internet access.",
                          ],
                          theme: theme,
                        ),
                        
                        _buildFaqItem(
                          index: 3,
                          question: "How do I report a bug?",
                          answers: [
                            "Use the 'Feedback' option in the settings menu.",
                            "Include screenshots and a brief description.",
                          ],
                          theme: theme,
                        ),
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

  /// Contact box widget with icon, label and value
  Widget _contactBox(BuildContext context,
      {required String label, required String value, required IconData icon}) {
    final theme = Theme.of(context);
    final Color boxBorder = theme.dividerColor.withOpacity(0.38);

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {},
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withOpacity(0.03),
          border: Border.all(color: boxBorder, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: theme.colorScheme.onSurface.withOpacity(0.6)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.85),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// FAQ item with expandable answers and border color change
  Widget _buildFaqItem({
    required int index,
    required String question,
    required List<String> answers,
    required ThemeData theme,
  }) {
    final bool expanded = _faqExpanded[index];
    final Color borderColor =
        expanded ? theme.colorScheme.primary : theme.dividerColor.withOpacity(0.38);

    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            setState(() {
              _faqExpanded[index] = !expanded;
            });
          },
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface.withOpacity(0.03),
              border: Border.all(color: borderColor, width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      question,
                      style: theme.textTheme.labelMedium,
                    ),
                  ),
                ),
                Icon(
                  expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),

        if (expanded)
          Container(
            
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: answers
                  .map(
                    (ans) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        "• $ans",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.85),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        const SizedBox(height: 16),
      ],
    );
  }
}
