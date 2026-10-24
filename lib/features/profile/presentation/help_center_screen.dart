import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';
import 'package:nexa/core/widgets/circular_icon_button.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.gray900,
            size: 22,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Help Center',
          style: AppTextStyles.header2SemiBold.copyWith(
            color: AppColors.gray900,
          ),
        ),
        centerTitle: true,
        actions: [
          CircularIconButton(
            icon: Icons.notifications_none_rounded,
            hasBadge: true,
            onTap: () {
              context.push('/notifications');
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        physics: const BouncingScrollPhysics(),
        children: [
          _ContactMethodTile(
            icon: Icons.headset_mic_outlined,
            title: 'Customer Service',
            onTap: () => context.push('/account/help-center/chat'),
          ),
          _ContactMethodTile(
            icon: Icons.chat_outlined,
            title: 'Whatsapp',
            onTap: () {},
          ),
          _ContactMethodTile(
            icon: Icons.language_rounded,
            title: 'Website',
            onTap: () {},
          ),
          _ContactMethodTile(
            icon: Icons.facebook_rounded,
            title: 'Facebook',
            onTap: () {},
          ),
          _ContactMethodTile(
            icon: Icons.alternate_email_rounded,
            title: 'Twitter',
            onTap: () {},
          ),
          _ContactMethodTile(
            icon: Icons.camera_alt_outlined,
            title: 'Instagram',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _ContactMethodTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ContactMethodTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.gray200, width: 1.2),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.gray900, size: 20),
            const SizedBox(width: 14),
            Text(
              title,
              style: AppTextStyles.body2SemiBold.copyWith(
                color: AppColors.gray900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
