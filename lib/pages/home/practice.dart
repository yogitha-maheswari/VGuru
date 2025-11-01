import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vguru/pages/test/test_intro_page.dart';
import 'package:vguru/widgets/test_card.dart';
import 'package:vguru/pages/provider/user_provider.dart';
import 'package:vguru/widgets/unlock_test_dialog.dart';

class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> with SingleTickerProviderStateMixin {
  final List<String> availableSubjects = [
    'English',
    'Mathematics',
    'Physics',
    'Chemistry',
    'Biology',
    'History',
    'Geography',
    'Civics',
    'Economics',
  ];

  /// 🧠 Default tests with dynamic data
  List<Map<String, dynamic>> tests = [
    {
      'name': 'Test 1',
      'marks': 100,
      'time': 60,
      'cost': 0,
      'unlocked': true,
      'subject': null,
      'rank': 1,
      'streak': 10,
      'questions': 10,
      'coins': 100,
    },
    {
      'name': 'Test 2',
      'marks': 150,
      'time': 90,
      'cost': 75,
      'unlocked': false,
      'subject': null,
      'rank': 2,
      'streak': 10,
      'questions': 15,
      'coins': 200,
    },
    {
      'name': 'Test 3',
      'marks': 200,
      'time': 120,
      'cost': 100,
      'unlocked': false,
      'subject': null,
      'rank': 3,
      'streak': 15,
      'questions': 20,
      'coins': 300,
    },
    {
      'name': 'Test 4',
      'marks': 250,
      'time': 150,
      'cost': 125,
      'unlocked': false,
      'subject': null,
      'rank': 4,
      'streak': 15,
      'questions': 25,
      'coins': 400,
    },
    {
      'name': 'Test 5',
      'marks': 300,
      'time': 180,
      'cost': 150,
      'unlocked': false,
      'subject': null,
      'rank': 5,
      'streak': 20,
      'questions': 30,
      'coins': 500,
    },
    {
      'name': 'Test 6',
      'marks': 300,
      'time': 180,
      'cost': 150,
      'unlocked': false,
      'subject': null,
      'rank': 10,
      'streak': 20,
      'questions': 50,
      'coins': 600,
    },
  ];

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _loadSavedTests();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// 📦 Load test data (unlock status + subject + stats)
  Future<void> _loadSavedTests() async {
    final prefs = await SharedPreferences.getInstance();
    final unlocked = prefs.getStringList('unlockedTests');
    final subjects = prefs.getStringList('testSubjects');
    final ranks = prefs.getStringList('testRanks');
    final streaks = prefs.getStringList('testStreaks');
    final questions = prefs.getStringList('testQuestions');
    final coins = prefs.getStringList('testCoins');

    // Reset all to defaults
    for (var test in tests) {
      test['unlocked'] = test['name'] == 'Test 1';
    }

    if (unlocked != null) {
      for (var test in tests) {
        if (unlocked.contains(test['name'])) test['unlocked'] = true;
      }
    }

    if (subjects != null && subjects.length == tests.length) {
      for (int i = 0; i < subjects.length; i++) {
        tests[i]['subject'] = subjects[i] == "null" ? null : subjects[i];
      }
    }

    if (ranks != null && ranks.length == tests.length) {
      for (int i = 0; i < ranks.length; i++) {
        tests[i]['rank'] = int.tryParse(ranks[i]) ?? tests[i]['rank'];
      }
    }
    if (streaks != null && streaks.length == tests.length) {
      for (int i = 0; i < streaks.length; i++) {
        tests[i]['streak'] = int.tryParse(streaks[i]) ?? tests[i]['streak'];
      }
    }
    if (questions != null && questions.length == tests.length) {
      for (int i = 0; i < questions.length; i++) {
        tests[i]['questions'] = int.tryParse(questions[i]) ?? tests[i]['questions'];
      }
    }
    if (coins != null && coins.length == tests.length) {
      for (int i = 0; i < coins.length; i++) {
        tests[i]['coins'] = int.tryParse(coins[i]) ?? tests[i]['coins'];
      }
    }

    setState(() {});
  }

  /// 💾 Save all test data
  Future<void> _saveTests() async {
    final prefs = await SharedPreferences.getInstance();
    final unlocked =
        tests.where((t) => t['unlocked']).map((t) => t['name'] as String).toList();
    final subjects = tests.map((t) => t['subject']?.toString() ?? "null").toList();
    final ranks = tests.map((t) => t['rank'].toString()).toList();
    final streaks = tests.map((t) => t['streak'].toString()).toList();
    final questions = tests.map((t) => t['questions'].toString()).toList();
    final coins = tests.map((t) => t['coins'].toString()).toList();

    await prefs.setStringList('unlockedTests', unlocked);
    await prefs.setStringList('testSubjects', subjects);
    await prefs.setStringList('testRanks', ranks);
    await prefs.setStringList('testStreaks', streaks);
    await prefs.setStringList('testQuestions', questions);
    await prefs.setStringList('testCoins', coins);
  }

  /// 🧹 Reset all unlocks (dev helper)
  Future<void> _resetAllUnlocks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('unlockedTests');
    await prefs.remove('testSubjects');

    setState(() {
      for (var test in tests) {
        test['unlocked'] = test['name'] == 'Test 1'; // Keep only Test 1 unlocked
        test['subject'] = null;
      }
    });
  }

  /// 🪙 Unlock test dialog
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
          await _saveTests();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${test['name']} unlocked successfully!"),
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Not enough coins"),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userProvider = Provider.of<UserProvider>(context);
    final classGrade = userProvider.classGrade ?? "10";
    final isDesktop = MediaQuery.of(context).size.width > 800;

    int unlockedCount = tests.where((t) => t['unlocked']).length;
    double progressValue = unlockedCount / tests.length;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        classGrade.toLowerCase() == "lkg" || classGrade.toLowerCase() == "ukg"
                            ? "Practice Activities"
                            : "Practice Tests",
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: isDesktop ? 22 : 18,
                        ),
                      ),
                      TextButton(
                        onPressed: _resetAllUnlocks,
                        child: Text("Reset", style: theme.textTheme.bodySmall),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  /// 📊 Graph Placeholder
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: theme.colorScheme.outlineVariant.withOpacity(0.1),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Progress Graph Coming Soon',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// 🎯 Progress Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.colorScheme.outlineVariant.withOpacity(0.1),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Practice Progress',
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 12),

                        LayoutBuilder(
                          builder: (context, constraints) {
                            double fullWidth = constraints.maxWidth;
                            double progressWidth =
                                fullWidth * progressValue.clamp(0.0, 1.0);

                            return Container(
                              height: 10,
                              width: fullWidth,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.easeInOut,
                                    width: progressWidth,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          theme.colorScheme.primary,
                                          theme.colorScheme.secondary,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$unlockedCount of ${tests.length} Tests Unlocked',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  /// 🧩 Test Cards Grid
                  LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount =
                          isDesktop ? (constraints.maxWidth > 1000 ? 3 : 2) : 1;
                      double cardWidth =
                          (constraints.maxWidth - (16 * (crossAxisCount - 1))) /
                              crossAxisCount;
                      double cardHeight = 300;
                      double aspectRatio = cardWidth / cardHeight;

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: tests.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: aspectRatio,
                        ),
                        itemBuilder: (context, index) {
                          final test = tests[index];

                          return AnimatedScale(
                            duration: const Duration(milliseconds: 300),
                            scale: test['unlocked'] ? 1.0 : 0.98,
                            child: TestCard(
                              testName: test['name'],
                              marks: test['marks'],
                              time: test['time'],
                              cost: test['cost'],
                              unlocked: test['unlocked'],
                              onUnlock: () => showUnlockDialog(context, index),
                              onStart: () {
                                if (test['subject'] == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Please select a subject first!"),
                                    ),
                                  );
                                  return;
                                }

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TestIntroPage(
                                      testName: test['name'],
                                      selectedSubject: test['subject'],
                                      marks: test['marks'],
                                      time: test['time'],
                                      questions: test['questions'],
                                      rank: test['rank'],
                                      streak: test['streak'],
                                      coins: test['coins'],
                                    ),
                                  ),
                                );
                              },
                              subjects: availableSubjects,
                              selectedSubject: test['subject'],
                              onSubjectChanged: (val) async {
                                setState(() => tests[index]['subject'] = val);
                                await _saveTests();
                              },
                              rank: test['rank'],
                              streak: test['streak'],
                              questions: test['questions'],
                              coins: test['coins'],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
