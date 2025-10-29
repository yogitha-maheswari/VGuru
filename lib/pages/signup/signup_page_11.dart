import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vguru/pages/provider/user_provider.dart';

class SignUp11 extends StatefulWidget {
  const SignUp11({super.key});

  @override
  State<SignUp11> createState() => _SignUp11State();
}

class _SignUp11State extends State<SignUp11> {
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    // Default time = current time when user opens the page
    _selectedTime = TimeOfDay.now();
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? "AM" : "PM";
    return "$hour:$minute $period";
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
            Navigator.pushReplacementNamed(context, '/signup10');
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              "10/10",
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Reminder Image
                  Image.asset(
                    "assets/images/reminder.png",
                    height: 180,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 32),

                  /// Title (moved outside ConstrainedBox for full width)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "Stay on track, set a daily study reminder",
                      textAlign: TextAlign.center,
                      maxLines: constraints.maxWidth > 400 ? 1 : 2,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  /// Rest of the content in ConstrainedBox
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 320),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "You can always change the time later",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 24),

                        /// Time Picker Button
                        SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () => _pickTime(context),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: theme.colorScheme.onSurface.withOpacity(0.5),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              _formatTime(_selectedTime),
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),

                        /// Continue Button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              final provider =
                                  Provider.of<UserProvider>(context, listen: false);

                              final period = _selectedTime.period == DayPeriod.am
                                  ? "AM"
                                  : "PM";

                              provider.setReminderTime(
                                  _selectedTime.hourOfPeriod,
                                  _selectedTime.minute,
                                  period);

                              Navigator.pushReplacementNamed(
                                context,
                                '/home',
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "YES, TURN ON",
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                '/home',
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: theme.colorScheme.onSurface.withOpacity(0.5),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "SET LATER",
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
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
