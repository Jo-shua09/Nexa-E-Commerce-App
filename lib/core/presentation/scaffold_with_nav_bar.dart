import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa/core/theme/app_colors.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.gray100, width: 1)),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          backgroundColor: AppColors.white,
          indicatorColor: Colors.transparent,
          elevation: 0,
          onDestinationSelected: (index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, color: AppColors.gray500),
              selectedIcon: Icon(Icons.home_filled, color: AppColors.gray900),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.search_rounded, color: AppColors.gray500),
              selectedIcon: Icon(
                Icons.search_rounded,
                color: AppColors.gray900,
              ),
              label: 'Explore',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.favorite_outline_rounded,
                color: AppColors.gray500,
              ),
              selectedIcon: Icon(
                Icons.favorite_rounded,
                color: AppColors.gray900,
              ),
              label: 'Saved',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person_outline_rounded,
                color: AppColors.gray500,
              ),
              selectedIcon: Icon(
                Icons.person_rounded,
                color: AppColors.gray900,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
