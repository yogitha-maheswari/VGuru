import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double imageH = (constraints.maxHeight * 0.38).clamp(140.0, 220.0);

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spacer(flex: constraints.maxHeight > 600 ? 2 : 1),
            SizedBox(
              height: imageH,
              child: Image.asset(
                'assets/images/track.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              "Track Progress",
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Stay motivated by tracking your achievements, from mastering topics to daily challenges.",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ),
            Spacer(flex: 4),
          ],
        );
      },
    );
  }
}
