import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:nexa/features/notifications/domain/models/notification_items.dart';

final dummyNotifications = [
  const NotificationItem(
    id: '1',
    title: '30% Special Discount!',
    description: 'Special promotion only valid today.',
    group: 'Today',
    icon: Icons.local_offer_outlined,
  ),
  const NotificationItem(
    id: '2',
    title: 'Top Up E-wallet Successfully!',
    description: 'You have top up your e-wallet.',
    group: 'Yesterday',
    icon: Icons.account_balance_wallet_outlined,
  ),
  const NotificationItem(
    id: '3',
    title: 'New Service Available!',
    description: 'Now you can track order in real-time.',
    group: 'Yesterday',
    icon: Icons.location_on_outlined,
  ),
  const NotificationItem(
    id: '4',
    title: 'Credit Card Connected!',
    description: 'Credit card has been linked.',
    group: 'June 7, 2023',
    icon: Icons.credit_card_outlined,
  ),
  const NotificationItem(
    id: '5',
    title: 'Account Setup Successfully!',
    description: 'Your account has been created.',
    group: 'June 7, 2023',
    icon: Icons.account_circle_outlined,
  ),
];

// Holds the notifications list (set to [] to test the empty state)
final notificationsProvider = StateProvider<List<NotificationItem>>(
  (ref) => dummyNotifications,
);
