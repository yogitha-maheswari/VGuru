import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

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
            Navigator.pushReplacementNamed(context, '/settings');
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
                      'assets/images/reset.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  
                  const SizedBox(height: 32),

                  // Heading
                  Text(
                    "Reset Password",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),
                  
                  Text(
                    "Please enter your email address to reset your password.",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Email Input Field
                  Form(
                    key: _formKey,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: theme.textTheme.bodyMedium,
                        decoration: const InputDecoration(
                          hintText: "E-mail",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email";
                          }
                          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                          if (!emailRegex.hasMatch(value)) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Reset Password Button
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
                          if (_formKey.currentState!.validate()) {
                            // TODO: Reset password API
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Reset link sent to your email"),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "SEND RESET LINK",
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Back to Login Button
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/settings');
                    },
                    child: Text(
                      "Back to Settings",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Support text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                        children: [
                          const TextSpan(
                            text:
                                "If you're still having trouble, reach out to ",
                          ),
                          WidgetSpan(
                            child: InkWell(
                              onTap: () {
                                // TODO: Add support navigation later
                              },
                              child: Text(
                                "support",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.primary,
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
}
