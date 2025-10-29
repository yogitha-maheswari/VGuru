import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vguru/pages/onboarding/onboarding.dart';
import 'package:vguru/theme%20and%20sound/theme_manager.dart';

class SplashScreenWrapper extends StatefulWidget {
  const SplashScreenWrapper({super.key});

  @override
  State<SplashScreenWrapper> createState() => _SplashScreenWrapperState();
}

class _SplashScreenWrapperState extends State<SplashScreenWrapper> {
  @override
  void initState() {
    super.initState();
    _navigateNext();
  }

  void _navigateNext() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const OnBoarding()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDark = themeManager.themeMode == ThemeMode.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              isDark
                  ? 'assets/images/logo_dark.png'
                  : 'assets/images/logo_light.png',
              width: 200,
              height: 200,
            ),
            Text(
              "VGuru",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
