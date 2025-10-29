import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vguru/pages/provider/user_provider.dart';
import 'package:vguru/pages/settings/sections/section_header.dart';
import 'package:vguru/utils/user_input_utils.dart';
import 'package:vguru/widgets/confirmation_dialog.dart';

class AccountSection extends StatelessWidget {
  final Color? borderColor;

  const AccountSection({
    Key? key,
    this.borderColor,
  }) : super(key: key);

  Future<void> _handleDeleteAccount(BuildContext context) async {
    final confirmed = await showDeleteAccountDialog(context);
    if (confirmed) {
      // ------------------ Clear User ------------------
      final userProv = Provider.of<UserProvider>(context, listen: false);
      userProv.clearUser();

      // TODO: Add DB delete logic here
      // await DatabaseService.deleteUser(userProv.email);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account Deleted Successfully')),
      );

      // Redirect to onboarding
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/onboarding',
        (route) => false,
      );
    }
  }

  void _navigateToResetPassword(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Navigator.pushNamed(context, '/reset_password');
    });
  }

  Widget _buildBox({
    required BuildContext context,
    required String title,
    required VoidCallback onTap,
    IconData? icon,
    Color? iconColor,
    bool isSelectable = true,
  }) {
    final theme = Theme.of(context);
    final Color boxBorder = borderColor ?? theme.dividerColor.withOpacity(0.38);

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: isSelectable ? onTap : null,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: boxBorder),
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
              Icon(
                icon,
                color: iconColor ?? theme.colorScheme.onSurface.withOpacity(0.6),
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
          const SectionHeader(title: 'Account Settings'),
          const SizedBox(height: 24),

          // --- Change Password ---
          Text('Change Password', style: theme.textTheme.labelMedium),
          const SizedBox(height: 8),
          _buildBox(
            context: context,
            title: 'Reset',
            onTap: () => _navigateToResetPassword(context),
            icon: Icons.chevron_right,
          ),

          const SizedBox(height: 24),

          // --- Learning Goal ---
          Text('Learning Goal', style: theme.textTheme.labelMedium),
          const SizedBox(height: 8),
          const LearningGoalSelector(),
          const SizedBox(height: 16),

          // --- Delete Account ---
          Text('Delete Account', style: theme.textTheme.labelMedium),
          const SizedBox(height: 8),
          _buildBox(
            context: context,
            title: 'Delete',
            onTap: () => _handleDeleteAccount(context),
            icon: Icons.delete_forever,
            iconColor: theme.colorScheme.secondary,
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
