import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vguru/pages/provider/user_provider.dart';

class StatsBar extends StatelessWidget {
  const StatsBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userProvider = Provider.of<UserProvider>(context);

    final isDesktop = MediaQuery.of(context).size.width > 600;
    final double iconSize = isDesktop ? 16 : 12;
    final double fontSize = isDesktop ? 14 : 10;
    final double paddingH = isDesktop ? 8 : 4;
    final double paddingV = isDesktop ? 6 : 4;
    final double spacing = isDesktop ? 8 : 4;

    Widget _buildStatBox(IconData icon, String value, Color color) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: paddingV),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(icon, size: iconSize, color: color),
            SizedBox(width: spacing / 2),
            Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
                color: color,
              ),
            ),
          ],
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildStatBox(FontAwesomeIcons.trophy,
            userProvider.trophies.toString(), const Color.fromARGB(255, 226, 179, 10)),
        SizedBox(width: spacing),
        _buildStatBox(FontAwesomeIcons.coins,
            userProvider.coins.toString(), Colors.amber.shade700),
        SizedBox(width: spacing),
        _buildStatBox(FontAwesomeIcons.fire,
            userProvider.streak.toString(), const Color.fromARGB(255, 232, 100, 18)),
      ],
    );
  }
}
