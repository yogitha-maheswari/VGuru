import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vguru/theme and sound/theme.dart';

class TestCard extends StatelessWidget {
  final String testName;
  final int marks;
  final int time;
  final int questions;
  final int coins;
  final int rank;
  final int streak;
  final int cost;
  final bool unlocked;
  final VoidCallback onUnlock;
  final VoidCallback onStart;

  // dropdown
  final List<String> subjects;
  final String? selectedSubject;
  final ValueChanged<String?> onSubjectChanged;

  const TestCard({
    super.key,
    required this.testName,
    required this.marks,
    required this.time,
    required this.questions,
    required this.coins,
    required this.rank,
    required this.streak,
    required this.cost,
    required this.unlocked,
    required this.onUnlock,
    required this.onStart,
    required this.subjects,
    required this.selectedSubject,
    required this.onSubjectChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = isDark
        ? AppThemes.darkSecondaryBackground
        : AppThemes.lightSecondaryBackground;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Title ---
            Text(
              testName,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 24),

            // --- Test Info ---
            Wrap(
              spacing: 16,
              runSpacing: 6,
              children: [
                _iconInfo(Icons.access_time, "$time mins", theme),
                _iconInfo(FontAwesomeIcons.star, "$marks Marks", theme),
                _iconInfo(Icons.help_outline, "$questions Qs", theme),
              ],
            ),

            const SizedBox(height: 12),

            // --- Subject Dropdown ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: theme.colorScheme.onSurface.withOpacity(0.1)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedSubject,
                  hint: Text(
                    "Select Subject",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  isExpanded: true,
                  items: subjects
                      .map((s) => DropdownMenuItem(
                            value: s,
                            child: Text(s, style: theme.textTheme.bodyMedium),
                          ))
                      .toList(),
                  onChanged: onSubjectChanged,
                ),
              ),
            ),

            const SizedBox(height: 14),

            // --- Stats Row + Button in one line ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Stats
                Flexible(
                  fit: FlexFit.loose,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildStatBox(FontAwesomeIcons.trophy, "$rank",
                          const Color.fromARGB(255, 226, 179, 10), context),
                      const SizedBox(width: 6),
                      _buildStatBox(FontAwesomeIcons.coins, "$coins",
                          Colors.amber.shade700, context),
                      const SizedBox(width: 6),
                      _buildStatBox(FontAwesomeIcons.fire, "$streak",
                          const Color.fromARGB(255, 232, 100, 18), context),
                    ],
                  ),
                ),

                // Action Button
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxWidth: 130, minHeight: 40),
                  child: unlocked
                      ? _buildOutlinedButton(context, "START", onStart)
                      : _buildFilledButton(context, "UNLOCK", onUnlock),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---- BUTTON STYLES ----

  Widget _buildOutlinedButton(
      BuildContext context, String label, VoidCallback onPressed) {
    final theme = Theme.of(context);
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: theme.colorScheme.onSurface.withOpacity(0.4)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      child: Text(
        label,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildFilledButton(
      BuildContext context, String label, VoidCallback onPressed) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        elevation: 0,
      ),
      child: Text(
        label,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ---- SMALL ELEMENT HELPERS ----

  Widget _iconInfo(IconData icon, String text, ThemeData theme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: theme.colorScheme.secondary),
        const SizedBox(width: 5),
        Text(
          text,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildStatBox(
      IconData icon, String value, Color color, BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 12),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
