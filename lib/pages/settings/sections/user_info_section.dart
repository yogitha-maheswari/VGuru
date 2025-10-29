import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vguru/pages/provider/user_provider.dart';
import 'package:vguru/pages/settings/sections/section_header.dart';
import 'package:vguru/utils/user_input_utils.dart';

class UserInfoSection extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController bioController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final String? genderValue;
  final ValueChanged<String?> onGenderChanged;
  final ImageProvider? imageProvider;
  final Future<void> Function() pickImage;
  final Future<void> Function()? deleteImage;
  final String? dobText;
  final VoidCallback? onDobTap;

  const UserInfoSection({
    Key? key,
    required this.firstNameController,
    required this.lastNameController,
    required this.bioController,
    required this.emailController,
    required this.phoneController,
    required this.genderValue,
    required this.onGenderChanged,
    required this.imageProvider,
    required this.pickImage,
    this.deleteImage,
    this.dobText,
    this.onDobTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(title: 'User Information'),

          const SizedBox(height: 24),

          // --- Profile Header ---
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width > 600 ? 60 : 45,
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                    backgroundImage: imageProvider,
                  ),

                  // Edit button
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: pickImage,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.onSurface.withOpacity(0.08),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.edit, color: Colors.white, size: 18),
                      ),
                    ),
                  ),

                  // Delete button
                  if (deleteImage != null)
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Consumer<UserProvider>(
                        builder: (_, userProv, __) {
                          if (!userProv.hasCustomProfileImage) return const SizedBox();
                          return GestureDetector(
                            onTap: deleteImage,
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.secondary,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.colorScheme.onSurface.withOpacity(0.08),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.delete_forever, color: Colors.white, size: 20),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),

          const SizedBox(height: 16),

          // --- First & Last Name ---
          Text('First Name & Last Name', style: theme.textTheme.labelMedium),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: firstNameController,
                  decoration: const InputDecoration(hintText: 'First name'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Enter first name' : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: lastNameController,
                  decoration: const InputDecoration(hintText: 'Last name'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // --- About / Bio ---
          Text('About You', style: theme.textTheme.labelMedium),
          const SizedBox(height: 8),
          TextFormField(
            controller: bioController,
            maxLines: 3,
            maxLength: 90,
            decoration: const InputDecoration(
              hintText: 'Say something about you for the world to see',
            ),
          ),

          const SizedBox(height: 24),

          // --- Email ---
          Text('Email', style: theme.textTheme.labelMedium),
          const SizedBox(height: 8),
          TextFormField(
            controller: emailController,
            enabled: false,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.lock,
                  color: theme.colorScheme.onSurface.withOpacity(0.5)),
            ),
          ),

          const SizedBox(height: 24),

          // --- Phone ---
          Text('Phone', style: theme.textTheme.labelMedium),
          const SizedBox(height: 8),
          TextFormField(
            controller: phoneController,
            enabled: false,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.lock,
                  color: theme.colorScheme.onSurface.withOpacity(0.5)),
            ),
          ),

          const SizedBox(height: 24),

          // --- Gender ---
          Text('Gender', style: theme.textTheme.labelMedium),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: genderValue,
            items: const [
              DropdownMenuItem(value: 'Male', child: Text('Male')),
              DropdownMenuItem(value: 'Female', child: Text('Female')),
              DropdownMenuItem(value: 'Other', child: Text('Other')),
            ],
            onChanged: onGenderChanged,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),

          const SizedBox(height: 24),

          // --- DOB Selector (matches other TextFields) ---
          Text('Date of Birth', style: theme.textTheme.labelMedium),
          const SizedBox(height: 8),
          TextFormField(
            controller: TextEditingController(text: dobText ?? ''),
            readOnly: true,
            onTap: onDobTap,
            decoration: InputDecoration(
              hintText: 'Select date',
              suffixIcon: const Icon(Icons.calendar_today_outlined, size: 20),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: dobText != null
                  ? theme.colorScheme.onSurface
                  : theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),

          const SizedBox(height: 24),

          // --- Class & Board ---
          Text('Class/Grade & Board', style: theme.textTheme.labelMedium),
          const SizedBox(height: 16),
          const GradeBoardSelector(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
