import 'package:flutter/material.dart';

// Reusable field container
class FieldContainer extends StatelessWidget {
  final Widget child;
  final Color borderColor;

  const FieldContainer({Key? key, required this.child, required this.borderColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        // color: Theme.of(context).colorScheme.surface,
        color: Theme.of(context).inputDecorationTheme.fillColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor.withOpacity(0.6), width: 1.0),
      ),
      child: Align(alignment: Alignment.centerLeft, child: child),
    );
  }
}

// Section header with slightly larger font
class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: theme.textTheme.titleMedium!.copyWith(
          fontSize: theme.textTheme.titleMedium!.fontSize! + 2,
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface.withOpacity(0.8),
        ),
      ),
    );
  }
}
