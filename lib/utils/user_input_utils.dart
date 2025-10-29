import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vguru/pages/provider/user_provider.dart';
import 'package:vguru/theme%20and%20sound/theme.dart';

/// -------------------- DOB Picker --------------------
Future<void> pickDob(BuildContext context) async {
  final userProv = Provider.of<UserProvider>(context, listen: false);
  final theme = Theme.of(context);

  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: userProv.dob ?? DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    builder: (context, child) => Theme(
      data: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: theme.colorScheme.primary,
          onPrimary: Colors.white,
        ),
      ),
      child: child!,
    ),
  );

  if (pickedDate != null) {
    userProv.setDobAndAge(pickedDate);
  }
}

/// -------------------- Reminder Time Picker --------------------
Future<bool> pickReminderTime(BuildContext context) async {
  final userProv = Provider.of<UserProvider>(context, listen: false);
  final initialTime = userProv.reminderHour != null
      ? TimeOfDay(
          hour: (userProv.reminderHour! % 12) +
              (userProv.reminderPeriod == 'PM' ? 12 : 0),
          minute: userProv.reminderMinute ?? 0,
        )
      : const TimeOfDay(hour: 20, minute: 0);

  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: initialTime,
  );

  if (picked != null) {
    final hour = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
    final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
    userProv.setReminderTime(hour, picked.minute, period);
    return true; // Time set
  }

  return false; // Cancel pressed
}

/// -------------------- Learning Goal Selector --------------------
class LearningGoalSelector extends StatelessWidget {
  const LearningGoalSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userProv = Provider.of<UserProvider>(context);
    final selected = userProv.learningGoal;

    final List<Map<String, dynamic>> goals = [
      {"title": "Casual", "minutes": 5},
      {"title": "Regular", "minutes": 10},
      {"title": "Serious", "minutes": 20},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: goals.map((goal) {
        final isSelected = goal["title"] == selected;
        return GestureDetector(
          onTap: () {
            userProv.setLearningGoal(goal["title"], goal["minutes"]);
          },
          child: Container(
            height: 48,
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected
                    ? AppThemes.lightAccent2
                    : theme.colorScheme.onSurface.withOpacity(0.2),
                width: isSelected ? 2 : 1,
              ),
              color: isSelected
                  ? AppThemes.lightAccent2.withOpacity(0.15)
                  : theme.colorScheme.surfaceVariant.withOpacity(0.1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  goal["title"],
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                Text(
                  "${goal["minutes"]} mins",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

/// -------------------- Grade & Board Selector --------------------
class GradeBoardSelector extends StatelessWidget {
  const GradeBoardSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context);
    Theme.of(context);

    final List<String> grades = [
      "LKG", "UKG", "1st", "2nd", "3rd", "4th", "5th",
      "6th", "7th", "8th", "9th", "10th"
    ];

    final List<String> boards = [
      "CBSE", "ICSE", "State Board", "Matriculation", "IB", "Other"
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Class / Grade Dropdown
        SizedBox(
          height: 48,
          child: DropdownButtonFormField<String>(
            value: userProv.classGrade?.isNotEmpty == true
                ? userProv.classGrade
                : null,
            items: grades
                .map((grade) => DropdownMenuItem(
                      value: grade,
                      child: Text(grade),
                    ))
                .toList(),
            onChanged: (val) {
              if (val != null && userProv.board != null) {
                userProv.setClassAndBoard(val, userProv.board!);
              } else if (val != null) {
                userProv.setClassAndBoard(val, "");
              }
            },
            decoration: InputDecoration(
              labelText: "Class / Grade",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Board Dropdown
        SizedBox(
          height: 48,
          child: DropdownButtonFormField<String>(
            value: userProv.board?.isNotEmpty == true ? userProv.board : null,
            items: boards
                .map((b) => DropdownMenuItem(
                      value: b,
                      child: Text(b),
                    ))
                .toList(),
            onChanged: (val) {
              if (val != null && userProv.classGrade != null) {
                userProv.setClassAndBoard(userProv.classGrade!, val);
              } else if (val != null) {
                userProv.setClassAndBoard("", val);
              }
            },
            decoration: InputDecoration(
              labelText: "Board",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
        ),
      ],
    );
  }
}
