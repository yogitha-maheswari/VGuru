import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vguru/pages/provider/user_provider.dart';
import 'package:vguru/pages/terms%20of%20service/help_page.dart';
import 'package:vguru/pages/terms%20of%20service/privacy_page.dart';
import 'package:vguru/pages/terms%20of%20service/terms_page.dart';
import 'package:vguru/theme%20and%20sound/theme_manager.dart';
import 'package:vguru/utils/file_picker_utils.dart';
import 'package:vguru/utils/user_input_utils.dart';

// Section imports
import 'sections/user_info_section.dart';
import 'sections/parent_info_section.dart';
import 'sections/notifications_section.dart';
import 'sections/app_settings_section.dart';
import 'sections/contact_us_section.dart';
import 'sections/share_section.dart';
import 'sections/account_section.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _bioController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _parentNameController;
  late TextEditingController _parentEmailController;
  late TextEditingController _parentPhoneController;

  String? _genderValue;
  bool _dailyReminder = false;
  TimeOfDay? _reminderTime;
  dynamic _profileImage; // File or Uint8List

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false);

    _firstNameController = TextEditingController(text: user.firstName ?? '');
    _lastNameController = TextEditingController(text: user.lastName ?? '');
    _bioController = TextEditingController(text: user.bio ?? '');
    _emailController = TextEditingController(text: user.email ?? '');
    _phoneController = TextEditingController(text: user.phoneNumber ?? '');
    _parentNameController = TextEditingController(text: user.parentName ?? '');
    _parentEmailController =
        TextEditingController(text: user.parentEmail ?? '');
    _parentPhoneController =
        TextEditingController(text: user.parentPhone ?? '');
    _genderValue = user.gender;
    _dailyReminder = user.dailyReminder;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      user.refreshReminderStatus();
    });

    if (user.reminderHour != null &&
        user.reminderMinute != null &&
        user.reminderPeriod != null) {
      int hour24 =
          user.reminderHour! % 12 + (user.reminderPeriod == 'PM' ? 12 : 0);
      _reminderTime = TimeOfDay(hour: hour24, minute: user.reminderMinute!);
    }

    if (user.profileImagePath != null &&
        File(user.profileImagePath!).existsSync()) {
      _profileImage = File(user.profileImagePath!);
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _bioController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _parentNameController.dispose();
    _parentEmailController.dispose();
    _parentPhoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picked = await FilePickerUtil.pickImage();
    if (picked != null) {
      setState(() {
        _profileImage = picked;
      });

      final userProv = Provider.of<UserProvider>(context, listen: false);
      if (picked is File) {
        userProv.setProfileImagePath(picked.path);
      } else if (picked is Uint8List) {
        userProv.setProfileImageBytes(picked);
      }
    }
  }

  Future<void> _deleteProfileImage() async {
    if (_profileImage != null) {
      setState(() {
        _profileImage = null;
      });

      final userProv = Provider.of<UserProvider>(context, listen: false);
      userProv.clearProfileImage();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile image removed')),
      );
    }
  }

  Future<bool> _pickReminderTime(BuildContext ctx) async {
    final picked = await showTimePicker(
      context: ctx,
      initialTime: _reminderTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _reminderTime = picked;
        _dailyReminder = true;
      });

      final userProv = Provider.of<UserProvider>(context, listen: false);
      userProv.setReminderTime(
        _reminderTime!.hourOfPeriod,
        _reminderTime!.minute,
        _reminderTime!.period.name.toUpperCase(),
      );

      return true; // time picked
    } else {
      // Cancelled, turn off reminder
      setState(() => _dailyReminder = false);
      final userProv = Provider.of<UserProvider>(context, listen: false);
      userProv.setDailyReminder(false);
      return false; // cancelled
    }
  }

  void _saveAll() {
    if (!_formKey.currentState!.validate()) return;

    final userProv = Provider.of<UserProvider>(context, listen: false);
    userProv.setName(
        _firstNameController.text.trim(), _lastNameController.text.trim());
    userProv.setBio(_bioController.text.trim());
    if (_genderValue != null) userProv.setGender(_genderValue!);
    userProv.setDailyReminder(_dailyReminder);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings Saved Successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeManager = Provider.of<ThemeManager>(context);
    final userProv = Provider.of<UserProvider>(context);
    final borderColor = theme.colorScheme.onSurface.withOpacity(0.22);

    ImageProvider? imageProvider;
    if (_profileImage != null) {
      if (_profileImage is File) {
        imageProvider = FileImage(_profileImage);
      } else if (_profileImage is Uint8List) {
        imageProvider = MemoryImage(_profileImage);
      }
    } else if (userProv.profileImagePath != null &&
        userProv.profileImagePath!.isNotEmpty &&
        File(userProv.profileImagePath!).existsSync()) {
      imageProvider = FileImage(File(userProv.profileImagePath!));
    } else {
      imageProvider = const AssetImage('assets/images/profile.png');
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, '/profile'),
        ),
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    UserInfoSection(
                      firstNameController: _firstNameController,
                      lastNameController: _lastNameController,
                      bioController: _bioController,
                      emailController: _emailController,
                      phoneController: _phoneController,
                      genderValue: _genderValue,
                      onGenderChanged: (v) => setState(() => _genderValue = v),
                      imageProvider: imageProvider,
                      pickImage: _pickImage,
                      deleteImage: _deleteProfileImage,
                      dobText: userProv.dob != null
                          ? '${userProv.dob!.day}/${userProv.dob!.month}/${userProv.dob!.year}'
                          : null,
                      onDobTap: () async {
                        await pickDob(context);
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 24),

                    ParentInfoSection(
                      parentNameController: _parentNameController,
                      parentEmailController: _parentEmailController,
                      parentPhoneController: _parentPhoneController,
                    ),
                    const SizedBox(height: 24),

                    AppSettingsSection(
                      themeMode: themeManager.themeMode,
                      onToggleDarkMode: (v) => themeManager.toggleTheme(v),
                      borderColor: borderColor,
                    ),
                    const SizedBox(height: 24),

                    AccountSection(borderColor: borderColor),

                    const SizedBox(height: 24),

                    NotificationsSection(
                      dailyReminder: _dailyReminder,
                      onDailyReminderChanged: (v) =>
                          setState(() => _dailyReminder = v),
                      reminderTime: _reminderTime,
                      pickReminderTime: _pickReminderTime,
                      borderColor: borderColor,
                      saveDailyReminder: (v) {
                        final userProv =
                            Provider.of<UserProvider>(context, listen: false);
                        userProv.setDailyReminder(v);
                      },
                    ),

                    const SizedBox(height: 24),

                    const ShareSection(),

                    const SizedBox(height: 24),

                    ContactUsSection(
                      onHelp: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HelpPage())),
                      onTerms: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TermsPage())),
                      onPrivacy: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PrivacyPage())),
                    ),
                    
                    const SizedBox(height: 24),

                    // Action buttons
                    LayoutBuilder(builder: (ctx, constraints) {
                      final bool compact = constraints.maxWidth < 520;
                      final double actionHeight = 48;

                      Widget buildPrimaryButton({required VoidCallback? onPressed, required String label}) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: 320,
                            height: actionHeight,
                            child: ElevatedButton(
                              onPressed: onPressed,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.zero,
                              ),
                              child: Text(
                                label,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      }

                      Widget buildSecondaryButton({required VoidCallback? onPressed, required String label}) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            width: 320,
                            height: actionHeight,
                            child: OutlinedButton(
                              onPressed: onPressed,
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.zero,
                              ),
                              child: Text(
                                label,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                        );
                      }

                      if (compact) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            buildPrimaryButton(onPressed: _saveAll, label: "SAVE"),
                            const SizedBox(height: 12),
                            buildSecondaryButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, '/onboarding');
                              },
                              label: "LOG OUT",
                            ),
                          ],
                        );
                      }

                      return Row(
                        children: [
                          Expanded(child: buildPrimaryButton(onPressed: _saveAll, label: "SAVE")),
                          const SizedBox(width: 16),
                          Expanded(
                            child: buildSecondaryButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, '/onboarding');
                              },
                              label: "LOG OUT",
                            ),
                          ),
                        ],
                      );
                    }),
                    

                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Version 1.0',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '© 2025 VGuru',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
