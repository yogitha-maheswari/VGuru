import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vguru/pages/provider/user_provider.dart';
import 'package:vguru/widgets/stats_bar.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bool isDesktop = MediaQuery.of(context).size.width > 600;
    final double avatarSize = isDesktop ? 120 : 90;
    final double spacing = isDesktop ? 20 : 14;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
        title: const Text('Profile'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: Icon(
                Icons.settings,
                size: isDesktop ? 34 : 28,
                color: theme.colorScheme.primary,
              ),
              onPressed: () => Navigator.pushNamed(context, '/settings'),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  final String fullName =
                      '${userProvider.firstName ?? 'User'} ${userProvider.lastName ?? ''}'.trim();
                  final String bio =
                      userProvider.bio?.isNotEmpty == true ? userProvider.bio! : "Learning and growing every day!";

                  ImageProvider<Object> avatarImage;
                  if (userProvider.profileImageBytes != null) {
                    avatarImage = MemoryImage(userProvider.profileImageBytes!);
                  } else if (userProvider.profileImagePath != null && userProvider.profileImagePath!.isNotEmpty) {
                    avatarImage = FileImage(File(userProvider.profileImagePath!));
                  } else {
                    avatarImage = const AssetImage('assets/images/profile.png');
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ---------------- Avatar ----------------
                      CircleAvatar(
                        radius: avatarSize / 2,
                        backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                        backgroundImage: avatarImage,
                      ),
                      SizedBox(height: spacing),

                      // ---------------- Full Name ----------------
                      Text(
                        fullName.isNotEmpty ? fullName : "Guest User",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // ---------------- Bio ----------------
                      Text(
                        bio,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(height: spacing * 1.5),

                      // ---------------- Stats Bar ----------------
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 320),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: theme.colorScheme.primary.withOpacity(0.15),
                            ),
                          ),
                          child: Center(
                            child: Transform.scale(
                              scale: 1.75,
                              child: const StatsBar(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: spacing * 1.5),

                      // ---------------- Share My Progress ----------------
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 320),
                        child: SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.share_outlined, size: 18),
                            label: Text(
                              "SHARE MY PROGRESS",
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: theme.colorScheme.onSurface.withOpacity(0.5),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {
                              // TODO: implement share functionality
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: spacing * 1.5),

                      // ---------------- Edit Profile Button ----------------
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 320),
                        child: SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pushNamed(context, '/settings'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child: Text(
                              "EDIT PROFILE",
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: spacing),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
