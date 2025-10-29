import 'package:flutter/material.dart';
import 'package:vguru/theme%20and%20sound/theme.dart';

class SubjectCard extends StatelessWidget {
  final String subject;
  final String imagePath;
  final String route;

  const SubjectCard({
    super.key,
    required this.subject,
    required this.imagePath,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final Color cardColor = isDark
        ? AppThemes.darkSecondaryBackground
        : AppThemes.lightSecondaryBackground;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 6,
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              subject,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 24),
            
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, route),
                style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.zero,
                elevation: 0,
                ),
                child: Text(
                "START LEARNING",
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
              ),
            ),

            const SizedBox(height: 16),

          ],
        ),
      ),
    );
  }
}
