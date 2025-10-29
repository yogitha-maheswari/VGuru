import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vguru/pages/settings/sections/section_header.dart';

class ShareSection extends StatefulWidget {
  final Color? borderColor;

  const ShareSection({Key? key, this.borderColor}) : super(key: key);

  @override
  State<ShareSection> createState() => _ShareSectionState();
}

class _ShareSectionState extends State<ShareSection> {
  int? _selectedIndex;

  void _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildBox({
    required BuildContext context,
    required String title,
    required VoidCallback onTap,
    IconData? icon,
    Color? iconColor,
    int? index,
  }) {
    final theme = Theme.of(context);
    final isSelected = _selectedIndex == index;
    final Color boxBorder = isSelected
        ? theme.colorScheme.primary
        : widget.borderColor ?? theme.dividerColor.withOpacity(0.38);

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        setState(() => _selectedIndex = index);
        onTap();
      },
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: boxBorder, width: 1.5),
          color: theme.colorScheme.surface.withOpacity(0.03),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyLarge,
              ),
            ),
            if (icon != null)
              FaIcon(
                icon,
                color: iconColor ?? theme.colorScheme.onSurface.withOpacity(0.6),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

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
          const SectionHeader(title: 'Share & Follow Us'),
          
          const SizedBox(height: 24),

          _buildBox(
            context: context,
            title: 'Rate Us on the Play Store',
            onTap: () => _launch(
              'https://play.google.com/store/apps/details?id=free.programming.programming&pcampaignid=web_share',
            ),
            icon: FontAwesomeIcons.googlePlay,
            iconColor: theme.colorScheme.onSurface,
            index: 0,
          ),
          const SizedBox(height: 24),

          _buildBox(
            context: context,
            title: 'Follow Us on X',
            onTap: () => _launch('https://x.com/geeksforgeeks'),
            icon: FontAwesomeIcons.xTwitter,
            iconColor: theme.colorScheme.onSurface,
            index: 1,
          ),
          const SizedBox(height: 24),

          _buildBox(
            context: context,
            title: 'Like Us on Facebook',
            onTap: () => _launch('https://www.facebook.com/geeksforgeeks.org'),
            icon: FontAwesomeIcons.facebook,
            iconColor: theme.colorScheme.onSurface,
            index: 2,
          ),
          const SizedBox(height: 24),

          _buildBox(
            context: context,
            title: 'Follow Us on Instagram',
            onTap: () => _launch('https://www.instagram.com/geeks_for_geeks/?__pwa=1'),
            icon: FontAwesomeIcons.instagram,
            iconColor: theme.colorScheme.onSurface,
            index: 3,
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
