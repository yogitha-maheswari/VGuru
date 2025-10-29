import 'package:flutter/material.dart';
import 'package:vguru/pages/settings/sections/section_header.dart';

class ContactUsSection extends StatefulWidget {
  final Color? borderColor;
  final VoidCallback? onHelp;
  final VoidCallback? onTerms;
  final VoidCallback? onPrivacy;

  const ContactUsSection({
    Key? key,
    this.borderColor,
    this.onHelp,
    this.onTerms,
    this.onPrivacy,
  }) : super(key: key);

  @override
  State<ContactUsSection> createState() => _ContactUsSectionState();
}

class _ContactUsSectionState extends State<ContactUsSection> {
  int? _selectedIndex; // tracks which box is selected

  Widget _buildItem(String label, VoidCallback? onTap, int index) {
    final theme = Theme.of(context);
    final isSelected = _selectedIndex == index;
    final Color boxBorder = isSelected
        ? theme.colorScheme.primary
        : widget.borderColor ?? theme.dividerColor.withOpacity(0.38);
    final Color boxColor = theme.colorScheme.surface.withOpacity(0.03);

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        setState(() => _selectedIndex = index); // persist selected index
        onTap?.call();
      },
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          border: Border.all(color: boxBorder, width: 1.5),
          borderRadius: BorderRadius.circular(8),
          color: boxColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: theme.textTheme.bodyLarge),
            Icon(Icons.chevron_right, color: theme.colorScheme.onSurface.withOpacity(0.6)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
          const SectionHeader(title: 'Contact Us'),
          const SizedBox(height: 24),
          _buildItem('Help and Support', widget.onHelp, 0),
          const SizedBox(height: 24),
          _buildItem('Terms and Conditions', widget.onTerms, 1),
          const SizedBox(height: 24),
          _buildItem('Privacy Policy', widget.onPrivacy, 2),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
