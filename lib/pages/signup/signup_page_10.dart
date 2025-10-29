import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vguru/pages/provider/user_provider.dart';
import 'package:vguru/theme%20and%20sound/theme.dart';

class SignUp10 extends StatefulWidget {
  const SignUp10({super.key});

  @override
  State<SignUp10> createState() => _SignUp10State();
}

class _SignUp10State extends State<SignUp10> {
  String? _selectedGoal;

  final List<Map<String, dynamic>> _options = [
    {"title": "Casual", "minutes": 5},
    {"title": "Regular", "minutes": 10},
    {"title": "Serious", "minutes": 20},
  ];

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
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/signup9');
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              "9/10",
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "How much time do you want to spend learning?",
                    textAlign: TextAlign.center,
                    maxLines: constraints.maxWidth > 400 ? 1 : 2,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 320),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "You can always change this goal later",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 24),

                        /// Options inside boxes
                        Column(
                          children: _options.map((option) {
                            final isSelected = _selectedGoal == option["title"];

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedGoal = option["title"];
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppThemes.lightAccent2
                                        : theme.colorScheme.onSurface
                                            .withOpacity(0.2),
                                    width: isSelected ? 2 : 1,
                                  ),
                                  color: isSelected
                                      ? AppThemes.lightAccent2.withOpacity(0.15)
                                      : theme.colorScheme.surfaceVariant
                                          .withOpacity(0.2),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      option["title"],
                                      style: theme.textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                    Text(
                                      "${option["minutes"]} minutes",
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color: theme.colorScheme.onSurface
                                            .withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 32),

                        /// Continue Button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _selectedGoal == null
                                ? null
                                : () {
                                    final selected = _options.firstWhere(
                                        (o) => o["title"] == _selectedGoal);

                                    context.read<UserProvider>().setLearningGoal(
                                          selected["title"],
                                          selected["minutes"],
                                        );

                                    Navigator.pushReplacementNamed(
                                      context,
                                      '/signup11',
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppThemes.lightAccent1,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "CONTINUE",
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
