import 'package:flutter/material.dart';

class NotificationItem {
  final String id;
  final String title;
  final String description;
  final String group;
  final IconData icon;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.description,
    required this.group,
    required this.icon,
  });
}
