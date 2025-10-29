import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vguru/pages/settings/sections/section_header.dart';
import 'package:vguru/theme%20and%20sound/sound_manager.dart';

class AppSettingsSection extends StatelessWidget {
  final ThemeMode themeMode;
  final ValueChanged<bool> onToggleDarkMode;
  final Color? borderColor;

  const AppSettingsSection({
    Key? key,
    required this.themeMode,
    required this.onToggleDarkMode,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color boxBorder = borderColor ?? theme.colorScheme.onSurface.withOpacity(0.12);
    final Color sectionBg = theme.colorScheme.primary.withOpacity(0.06);

    return Container(
      decoration: BoxDecoration(
        color: sectionBg,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(title: 'App Settings'),
          const SizedBox(height: 24),

          // --- Dark Mode ---
          Text('Appearance', style: theme.textTheme.labelMedium),
          const SizedBox(height: 8),
          TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'Dark Mode',
              suffixIcon: Transform.scale(
                scale: 0.95,
                child: Switch(
                  value: themeMode == ThemeMode.dark,
                  onChanged: onToggleDarkMode,
                  activeColor: theme.colorScheme.primary,
                ),
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: boxBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
          ),

          const SizedBox(height: 24),

          // --- Sound Effects ---
          Text('Sound Effects', style: theme.textTheme.labelMedium),
          const SizedBox(height: 8),
          Consumer<SoundManager>(
            builder: (context, soundManager, _) {
              return TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Sound Effects',
                  suffixIcon: Transform.scale(
                    scale: 0.95,
                    child: Switch(
                      value: soundManager.soundEnabled,
                      onChanged: (val) => soundManager.toggleSound(val),
                      activeColor: theme.colorScheme.primary,
                    ),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: boxBorder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
