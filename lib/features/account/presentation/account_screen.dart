import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';
import 'package:nexa/core/widgets/circular_icon_button.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

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
          'Account',
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
        physics: const BouncingScrollPhysics(),
        children: [
          _AccountMenuItem(
            icon: Icons.shopping_basket_outlined,
            title: 'My Orders',
            onTap: () => context.push('/account/orders'),
          ),
          _AccountMenuItem(
            icon: Icons.manage_accounts_outlined,
            title: 'My Details',
            onTap: () => context.push('/account/details'),
          ),
          _AccountMenuItem(
            icon: Icons.home_work_outlined,
            title: 'Address Book',
            onTap: () => context.push('/cart/checkout/address'),
          ),
          _AccountMenuItem(
            icon: Icons.payment_outlined,
            title: 'Payment Methods',
            onTap: () => context.push('/cart/checkout/payment'),
          ),
          _AccountMenuItem(
            icon: Icons.notifications_none_rounded,
            title: 'Notifications',
            onTap: () => context.push('/account/notification-settings'),
          ),
          _AccountMenuItem(
            icon: Icons.help_outline_rounded,
            title: 'FAQs',
            onTap: () => context.push('/account/faqs'),
          ),
          _AccountMenuItem(
            icon: Icons.headset_mic_outlined,
            title: 'Help Center',
            onTap: () => context.push('/account/help-center'),
          ),
          _AccountMenuItem(
            icon: Icons.logout_rounded,
            title: 'Logout',
            isLogout: true,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  backgroundColor: AppColors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.error,
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.priority_high_rounded,
                            color: AppColors.error,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 20),

                        Text(
                          'Logout?',
                          style: AppTextStyles.header2SemiBold.copyWith(
                            color: AppColors.gray900,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Are you sure you want to logout?',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.body2Regular.copyWith(
                            color: AppColors.gray500,
                          ),
                        ),
                        const SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              context.go('/sign-in');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.error,
                              foregroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Yes, Logout',
                              style: AppTextStyles.body2SemiBold.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.gray900,
                              side: const BorderSide(
                                color: AppColors.gray200,
                                width: 1.2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Text(
                              'No, Cancel',
                              style: AppTextStyles.body2SemiBold.copyWith(
                                color: AppColors.gray900,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AccountMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isLogout;

  const _AccountMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isLogout ? AppColors.error : AppColors.gray900;

    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          leading: Icon(icon, color: color, size: 22),
          title: Text(
            title,
            style: AppTextStyles.body2SemiBold.copyWith(color: color),
          ),
          trailing: isLogout
              ? null
              : const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.gray400,
                  size: 24,
                ),
          onTap: onTap,
        ),
        const Divider(color: AppColors.gray100, thickness: 1, height: 1),
      ],
    );
  }
}
