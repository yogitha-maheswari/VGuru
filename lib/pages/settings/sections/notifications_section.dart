import 'package:flutter/material.dart';
import 'package:vguru/pages/settings/sections/section_header.dart';

class NotificationsSection extends StatelessWidget {
  final bool dailyReminder;
  final ValueChanged<bool> onDailyReminderChanged;
  final TimeOfDay? reminderTime;
  final Future<bool> Function(BuildContext) pickReminderTime;
  final void Function(bool) saveDailyReminder;
  final Color? borderColor;

  const NotificationsSection({
    Key? key,
    required this.dailyReminder,
    required this.onDailyReminderChanged,
    required this.reminderTime,
    required this.pickReminderTime,
    required this.saveDailyReminder,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color boxBorder = borderColor ?? theme.colorScheme.onSurface.withOpacity(0.12);
    final Color sectionBg = theme.colorScheme.primary.withOpacity(0.06);

    return Container(
      decoration: BoxDecoration(
        color: sectionBg,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(title: 'Notifications'),
          const SizedBox(height: 24),

          // --- Daily Reminder ---
          Text('Daily Reminder', style: theme.textTheme.labelMedium),
          const SizedBox(height: 8),
          TextFormField(
            readOnly: true,
            onTap: () async {
              if (!dailyReminder) {
                final set = await pickReminderTime(context);
                if (set) {
                  onDailyReminderChanged(true);
                  saveDailyReminder(true);
                }
              } else {
                onDailyReminderChanged(false);
                saveDailyReminder(false);
              }
            },
            decoration: InputDecoration(
              hintText: 'Daily Reminder',
              suffixIcon: Transform.scale(
                scale: 0.95,
                child: Switch(
                  value: dailyReminder,
                  onChanged: (v) async {
                    if (!v) {
                      onDailyReminderChanged(false);
                      saveDailyReminder(false);
                    } else {
                      final set = await pickReminderTime(context);
                      if (set) {
                        onDailyReminderChanged(true);
                        saveDailyReminder(true);
                      }
                    }
                  },
                  activeColor: theme.colorScheme.primary,
                ),
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: boxBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
          ),

          const SizedBox(height: 24),

          // --- Reminder Time ---
          Text('Reminder Time', style: theme.textTheme.labelMedium),
          const SizedBox(height: 8),
          TextFormField(
            readOnly: true,
            onTap: () async {
              if (dailyReminder) {
                await pickReminderTime(context);
              }
            },
            decoration: InputDecoration(
              hintText: 'Set time',
              suffixIcon: const Icon(Icons.access_time),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: boxBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
            controller: TextEditingController(
              text: reminderTime != null ? reminderTime!.format(context) : '',
            ),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: dailyReminder
                  ? theme.colorScheme.onSurface
                  : theme.colorScheme.onSurface.withOpacity(0.5),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}