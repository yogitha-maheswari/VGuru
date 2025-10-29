import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vguru/pages/provider/user_provider.dart';

class SignUp7 extends StatefulWidget {
  const SignUp7({super.key});

  @override
  State<SignUp7> createState() => _SignUp7State();
}

class _SignUp7State extends State<SignUp7> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  DateTime? _selectedDob;

  Future<void> _pickDob(BuildContext context) async {
    final theme = Theme.of(context);
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), 
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary: theme.colorScheme.primary,
              onPrimary: Colors.white,
              onSurface: theme.colorScheme.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDob = pickedDate;
        _dobController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";

        // Calculate age
        final now = DateTime.now();
        int age = now.year - pickedDate.year;
        if (now.month < pickedDate.month ||
            (now.month == pickedDate.month && now.day < pickedDate.day)) {
          age--;
        }
        _ageController.text = age.toString();
      });
    }
  }

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
            Navigator.pushNamed(context, '/signup6');
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              "6/10",
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
                        "What's your date of birth?",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),

                      /// DOB Picker
                      TextFormField(
                        controller: _dobController,
                        readOnly: true,
                        style: theme.textTheme.bodyMedium,
                        decoration: InputDecoration(
                          hintText: "Select DOB",
                          suffixIcon: const Icon(Icons.calendar_today),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onTap: () => _pickDob(context),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "DOB is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      /// Age (calculated, readonly)
                      TextFormField(
                        controller: _ageController,
                        readOnly: true,
                        style: theme.textTheme.bodyMedium,
                        decoration: InputDecoration(
                          hintText: "Age",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      /// Continue Button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                _selectedDob != null) {
                              Provider.of<UserProvider>(context, listen: false)
                                  .setDobAndAge(_selectedDob!);

                              Navigator.pushReplacementNamed(
                                context,
                                '/signup8',
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
