import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/widgets/circular_icon_button.dart';
import 'package:nexa/features/notifications/domain/models/notification_items.dart';
import 'package:nexa/features/notifications/presentation/providers/notification_provider.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationsProvider);

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
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 18,
            fontWeight: FontWeight.w700,
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
      body: notifications.isEmpty
          ? const _EmptyNotificationsView()
          : _PopulatedNotificationsList(notifications: notifications),
    );
  }
}

// -------------------------------------------------------------
// Populated State with Date Groups
// -------------------------------------------------------------
class _PopulatedNotificationsList extends StatelessWidget {
  final List<NotificationItem> notifications;

  const _PopulatedNotificationsList({required this.notifications});

  @override
  Widget build(BuildContext context) {
    // Preserve order while grouping items by section label
    final Map<String, List<NotificationItem>> grouped = {};
    for (final item in notifications) {
      grouped.putIfAbsent(item.group, () => []).add(item);
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      itemCount: grouped.length,
      itemBuilder: (context, index) {
        final groupKey = grouped.keys.elementAt(index);
        final items = grouped[groupKey]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header
            Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 12),
              child: Text(
                groupKey,
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.gray900,
                ),
              ),
            ),

            // Group Items
            ...items.asMap().entries.map((entry) {
              final itemIndex = entry.key;
              final item = entry.value;
              final isLastInGroup = itemIndex == items.length - 1;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(item.icon, size: 24, color: AppColors.gray900),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.gray900,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.description,
                                style: const TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.gray400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isLastInGroup)
                    const Padding(
                      padding: EdgeInsets.only(top: 6, bottom: 6),
                      child: Divider(
                        color: AppColors.gray100,
                        thickness: 1,
                        height: 1,
                      ),
                    ),
                ],
              );
            }),
          ],
        );
      },
    );
  }
}

// -------------------------------------------------------------
// Empty State Matching Design
// -------------------------------------------------------------
class _EmptyNotificationsView extends StatelessWidget {
  const _EmptyNotificationsView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Outlined Bell Illustration
            Icon(
              Icons.notifications_none_rounded,
              size: 80,
              color: AppColors.gray300,
            ),
            const SizedBox(height: 28),

            // Primary Message
            const Text(
              "You haven’t gotten any\nnotifications yet!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 1.25,
                color: AppColors.gray900,
              ),
            ),
            const SizedBox(height: 12),

            // Secondary Message
            const Text(
              "We’ll alert you when something\ncool happens.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.35,
                color: AppColors.gray400,
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
