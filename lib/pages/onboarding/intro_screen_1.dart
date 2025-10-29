import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double imageH =
            (constraints.maxHeight * 0.38).clamp(140.0, 220.0);

        // Use Spacer to push content up, works well on both desktop and mobile
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spacer(flex: constraints.maxHeight > 600 ? 2 : 1),
            SizedBox(
              height: imageH,
              child: Image.asset(
                'assets/images/learning.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              "Simplify Learning",
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Access comprehensive academic support for all grades, anytime, anywhere.",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ),
            Spacer(flex: 4), // Pushes content up, reduces gap at bottom
          ],
        );
      },
    );
  }
}
