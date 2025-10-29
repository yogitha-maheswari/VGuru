import 'package:flutter/material.dart';
import 'package:vguru/pages/settings/sections/section_header.dart';

class ParentInfoSection extends StatelessWidget {
  final TextEditingController parentNameController;
  final TextEditingController parentEmailController;
  final TextEditingController parentPhoneController;
  final Color? borderColor;

  const ParentInfoSection({
    Key? key,
    required this.parentNameController,
    required this.parentEmailController,
    required this.parentPhoneController,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color boxBorder = borderColor ?? theme.dividerColor.withOpacity(0.38);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(title: 'Parent Information'),
          
          const SizedBox(height: 24),

          // --- Parent Name ---
          Text('Parent Name', style: theme.textTheme.labelMedium),
          const SizedBox(height: 8),
          TextFormField(
            controller: parentNameController,
            decoration: InputDecoration(
              hintText: 'Parent full name',
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: boxBorder)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5)),
            ),
          ),

          const SizedBox(height: 24),

          // --- Parent Email ---
          Text('Parent Email', style: theme.textTheme.labelMedium),
          const SizedBox(height: 8),
          TextFormField(
            controller: parentEmailController,
            enabled: false,
            decoration: InputDecoration(
              hintText: 'Parent email',
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: boxBorder)),
              suffixIcon: Icon(Icons.lock, color: theme.colorScheme.onSurface.withOpacity(0.5)),
            ),
          ),

          const SizedBox(height: 24),

          // --- Parent Phone ---
          Text('Parent Phone', style: theme.textTheme.labelMedium),
          const SizedBox(height: 8),
          TextFormField(
            controller: parentPhoneController,
            enabled: false,
            decoration: InputDecoration(
              hintText: 'Parent phone',
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: boxBorder)),
              suffixIcon: Icon(Icons.lock, color: theme.colorScheme.onSurface.withOpacity(0.5)),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
