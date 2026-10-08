import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexa/core/router/app_router.dart';
import 'package:nexa/core/theme/app_theme.dart';

class NexaApp extends ConsumerWidget {
  const NexaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the router provider so it updates automatically
    final goRouter = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Nexa',
      debugShowCheckedModeBanner: false,

      // Inject your crisp light theme
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,

      // Hook up GoRouter
      routerConfig: goRouter,
    );
  }
}
