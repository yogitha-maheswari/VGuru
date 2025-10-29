import 'package:flutter/material.dart';
import 'package:vguru/pages/terms%20of%20service/terms_page.dart';

class SignUp1 extends StatelessWidget {
  const SignUp1({super.key});

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
            Navigator.pushNamed(context, '/welcome');
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double imageH =
              (constraints.maxHeight * 0.30).clamp(140.0, 200.0);

          return Center(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Top Image
                  SizedBox(
                    height: imageH,
                    child: Image.asset(
                      'assets/images/register.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Title
                  Text(
                    "Create Account",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Join us today and get started!",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Sign up with email button
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 320),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/signup2');
                        },
                        child: Text(
                          "SIGN UP WITH EMAIL",
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Divider with text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: theme.colorScheme.onSurface.withOpacity(0.3),
                          indent: 24,
                          endIndent: 12,
                        ),
                      ),
                      Text(
                        "Or sign up with",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color:
                              theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: theme.colorScheme.onSurface.withOpacity(0.3),
                          indent: 12,
                          endIndent: 24,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Social signup buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialButton(context, 'assets/images/google.png'),
                      const SizedBox(width: 24),
                      _socialButton(context, 'assets/images/facebook.png'),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Terms of service text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                          fontSize: 12,
                        ),
                        children: [
                          const TextSpan(
                            text: "By signing in you agree to our ",
                          ),
                          WidgetSpan(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const TermsPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Terms of Service",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const TextSpan(text: "."),
                        ],
                      ),
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

  // Widget for social buttons (Google, Facebook)
  Widget _socialButton(BuildContext context, String assetPath) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () {
        // signup action
      },
      child: Container(
        height: 52,
        width: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: theme.colorScheme.onSurface.withOpacity(0.3),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(assetPath, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
