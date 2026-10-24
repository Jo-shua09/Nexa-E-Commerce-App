import 'package:flutter/material.dart';
import 'package:nexa/core/theme/app_colors.dart';

class CircularIconButton extends StatelessWidget {
  const CircularIconButton({
    super.key,
    required this.icon,
    required this.hasBadge,
    required this.onTap,
  });

  final IconData icon;
  final bool hasBadge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 44,
      child: Stack(
        children: [
          Positioned.fill(
            child: Material(
              color: AppColors.white,
              shape: const CircleBorder(),
              child: IconButton(
                onPressed: onTap,
                icon: Icon(icon, color: AppColors.gray900),
              ),
            ),
          ),
          if (hasBadge)
            Positioned(
              top: 7,
              right: 7,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
