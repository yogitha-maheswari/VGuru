import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vguru/pages/provider/user_provider.dart';

class SignUp8 extends StatefulWidget {
  const SignUp8({super.key});

  @override
  State<SignUp8> createState() => _SignUp8State();
}

class _SignUp8State extends State<SignUp8> {
  final _formKey = GlobalKey<FormState>();

  final List<String> _classes = [
    "LKG",
    "UKG",
    "1st",
    "2nd",
    "3rd",
    "4th",
    "5th",
    "6th",
    "7th",
    "8th",
    "9th",
    "10th"
  ];

  final List<String> _boards = [
    "CBSE",
    "ICSE",
    "State Board",
    "Matriculation",
    "IB",
    "Other"
  ];

  String? _selectedClass;
  String? _selectedBoard;

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
            Navigator.pushNamed(context, '/signup7');
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              "7/10",
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
              child: Form(
                key: _formKey,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 320),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Tell us about your education",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),

                      /// Class/Grade Dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedClass,
                        items: _classes
                            .map((grade) => DropdownMenuItem(
                                  value: grade,
                                  child: Text(grade),
                                ))
                            .toList(),
                        decoration: InputDecoration(
                          hintText: "Select Class/Grade",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedClass = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Class/Grade is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      /// Board Dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedBoard,
                        items: _boards
                            .map((board) => DropdownMenuItem(
                                  value: board,
                                  child: Text(board),
                                ))
                            .toList(),
                        decoration: InputDecoration(
                          hintText: "Select Board",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedBoard = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Board is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),

                      /// Continue Button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Provider.of<UserProvider>(context, listen: false)
                                  .setClassAndBoard(
                                      _selectedClass!, _selectedBoard!);

                              // Navigate next (maybe home/profile)
                              Navigator.pushReplacementNamed(
                                context,
                                '/signup9',
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
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
              ),
            ),
          );
        },
      ),
    );
  }
}
