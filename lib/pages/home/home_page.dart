import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vguru/pages/provider/user_provider.dart';
import 'package:vguru/widgets/stats_bar.dart';

// Import the content widgets for each tab
import 'learn.dart';
import 'practice.dart';
import 'report.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // default is Learn page

  // Pages to display in the body
  final List<Widget> _pages = const [
    Learn(),
    Practice(),
    Report(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userProvider = Provider.of<UserProvider>(context);

    final String name = userProvider.firstName ?? "Name";
    final String classGrade = userProvider.classGrade ?? "Class";

    final bool isDesktop = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,

      // --- AppBar ---
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(isDesktop ? 100 : 80),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16).copyWith(
              top: isDesktop ? 24 : 0,
              bottom: 8,
            ),
            color: theme.colorScheme.surface,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Greeting Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hi, $name 👋",
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: isDesktop ? 20 : 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "$classGrade Student",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                          fontSize: isDesktop ? 18 : 14,
                        ),
                      ),
                    ],
                  ),
                ),

                // StatsBar between greeting and profile
                
                const StatsBar(),

                const SizedBox(width: 8),

                // Profile Column
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.account_circle,
                        size: isDesktop ? 44 : 34,
                        color: theme.colorScheme.primary,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/profile");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      // --- Body: show the selected page ---
      body: _pages[_selectedIndex],

      // --- Bottom Navigation ---
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: theme.colorScheme.surface,
        color: theme.colorScheme.background,
        buttonBackgroundColor: theme.colorScheme.primary,
        height: 60,
        index: _selectedIndex,
        items: const [
          FaIcon(FontAwesomeIcons.graduationCap, color: Colors.white, size: 22),
          FaIcon(FontAwesomeIcons.bolt, color: Colors.white, size: 22),
          FaIcon(FontAwesomeIcons.chartLine, color: Colors.white, size: 22),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
