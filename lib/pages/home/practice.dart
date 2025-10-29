import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vguru/widgets/test_card.dart';
import 'package:vguru/pages/provider/user_provider.dart';
import 'package:vguru/widgets/unlock_test_dialog.dart';

class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  final List<String> availableSubjects = ['Mathematics', 'Physics', 'Chemistry', 'Biology'];

  List<Map<String, dynamic>> tests = [
    {'name': 'Test 1', 'marks': 100, 'time': 60, 'cost': 50, 'unlocked': false, 'subject': null},
    {'name': 'Test 2', 'marks': 150, 'time': 90, 'cost': 75, 'unlocked': false, 'subject': null},
    {'name': 'Test 3', 'marks': 200, 'time': 120, 'cost': 100, 'unlocked': false, 'subject': null},
  ];

  @override
  void initState() {
    super.initState();
    _loadUnlockedTests();
  }

  Future<void> _loadUnlockedTests() async {
    final prefs = await SharedPreferences.getInstance();
    final unlocked = prefs.getStringList('unlockedTests');
    if (unlocked != null) {
      setState(() {
        for (var test in tests) {
          if (unlocked.contains(test['name'])) test['unlocked'] = true;
        }
      });
    }
  }

  Future<void> _saveUnlockedTests() async {
    final prefs = await SharedPreferences.getInstance();
    final unlocked = tests.where((t) => t['unlocked']).map((t) => t['name'] as String).toList();
    await prefs.setStringList('unlockedTests', unlocked);
  }

  /// ✅ New Unlock Dialog using external widget
  void showUnlockDialog(BuildContext context, int index) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final test = tests[index];

    showUnlockTestDialog(
      context: context,
      testName: test['name'],
      cost: test['cost'],
      userCoins: userProvider.coins,
      onConfirmUnlock: () async {
        if (userProvider.coins >= test['cost']) {
          userProvider.spendCoins(test['cost']);
          setState(() => test['unlocked'] = true);
          await _saveUnlockedTests();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Not enough coins")),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = theme.scaffoldBackgroundColor;
    final userProvider = Provider.of<UserProvider>(context);
    final classGrade = userProvider.classGrade ?? "10";
    final isDesktop = MediaQuery.of(context).size.width > 800;

    int unlockedCount = tests.where((t) => t['unlocked']).length;

    return Container(
      color: bgColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🏷️ Section Title
              Text(
                classGrade.toLowerCase() == "lkg" || classGrade.toLowerCase() == "ukg"
                    ? "Practice Activities"
                    : "Practice Tests",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: isDesktop ? 22 : 18,
                ),
              ),
              const SizedBox(height: 16),

              /// 📊 Graph Placeholder
              Container(
                height: 220,
                decoration: BoxDecoration(
                  color: theme.colorScheme.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.colorScheme.onSurface.withOpacity(0.06)),
                ),
                child: Center(
                  child: Text(
                    'Graph placeholder',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.5)),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              /// 🎯 Progress Box + Coin Count
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: theme.colorScheme.onSurface.withOpacity(0.08)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Practice Progress', style: theme.textTheme.labelMedium),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: unlockedCount / tests.length,
                        minHeight: 12,
                        backgroundColor: theme.colorScheme.primary.withOpacity(0.12),
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '$unlockedCount of ${tests.length} Tests Unlocked',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              /// 🧩 Tests Grid
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = constraints.maxWidth > 1000
                        ? 3
                        : constraints.maxWidth > 700
                            ? 2
                            : 1;

                    double cardWidth =
                        (constraints.maxWidth - (16 * (crossAxisCount - 1))) / crossAxisCount;
                    double cardHeight = 300;
                    double aspectRatio = cardWidth / cardHeight;

                    return GridView.builder(
                      itemCount: tests.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: aspectRatio,
                      ),
                      itemBuilder: (context, index) {
                        final test = tests[index];
                        return TestCard(
                          testName: test['name'],
                          marks: test['marks'],
                          time: test['time'],
                          cost: test['cost'],
                          unlocked: test['unlocked'],
                          onUnlock: () => showUnlockDialog(context, index),
                          onStart: () {
                            // TODO: Navigate to test page
                          },
                          subjects: availableSubjects,
                          selectedSubject: test['subject'],
                          onSubjectChanged: (val) {
                            setState(() => tests[index]['subject'] = val);
                          },
                          rank: index + 1,
                          streak: 0,
                          questions: 0,
                          coins: userProvider.coins,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
