import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';
import 'package:nexa/core/widgets/circular_icon_button.dart';

class TrackOrderScreen extends StatelessWidget {
  final String orderId;

  const TrackOrderScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.gray900,
            size: 22,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Track Order',
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
      body: Stack(
        children: [
          // 1. Map Background Placeholder
          Positioned.fill(
            child: Container(
              color: const Color(0xFFE5E5E5),
              child: Stack(
                children: [
                  Positioned(
                    top: 200,
                    left: 100,
                    child: Icon(
                      Icons.local_shipping,
                      size: 40,
                      color: AppColors.gray900,
                    ),
                  ),
                  Positioned(
                    top: 350,
                    left: 60,
                    child: Icon(Icons.home, size: 30, color: AppColors.gray700),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              top: false,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.sizeOf(context).height * 0.8,
                ),
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Drag Handle
                        Center(
                          child: Container(
                            width: 44,
                            height: 4,
                            decoration: BoxDecoration(
                              color: AppColors.gray200,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order Status',
                              style: AppTextStyles.body1SemiBold.copyWith(
                                color: AppColors.gray900,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => context.pop(),
                              child: const Icon(
                                Icons.close_rounded,
                                color: AppColors.gray900,
                                size: 22,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        const _TimelineTile(
                          title: 'Packing',
                          subtitle:
                              '2336 Jack Warren Rd, Delta Junction, Alaska 9...',
                          isCompleted: true,
                        ),
                        const _TimelineTile(
                          title: 'Picked',
                          subtitle:
                              '2417 Tongass Ave #111, Ketchikan, Alaska 99901...',
                          isCompleted: true,
                        ),
                        const _TimelineTile(
                          title: 'In Transit',
                          subtitle: '16 Rr 2, Ketchikan, Alaska 99901, USA',
                          isActive: true,
                        ),
                        const _TimelineTile(
                          title: 'Delivered',
                          subtitle: '925 S Chugach St #APT 10, Alaska 99645',
                          isPending: true,
                          isLast: true,
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Divider(
                            color: AppColors.gray100,
                            thickness: 1,
                            height: 1,
                          ),
                        ),

                        // Delivery Guy Profile
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 24,
                              backgroundImage: NetworkImage(
                                'https://i.pravatar.cc/150?u=a042581f4e29026704d',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Jacob Jones',
                                    style: AppTextStyles.body1SemiBold.copyWith(
                                      color: AppColors.gray900,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Delivery Guy',
                                    style: AppTextStyles.body3Regular.copyWith(
                                      color: AppColors.gray500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 44,
                              height: 44,
                              decoration: const BoxDecoration(
                                color: AppColors.gray100,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.phone_outlined,
                                color: AppColors.gray900,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isActive;
  final bool isPending;
  final bool isLast;

  const _TimelineTile({
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
    this.isActive = false,
    this.isPending = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted || isActive
                    ? AppColors.gray900
                    : Colors.transparent,
                border: isActive
                    ? Border.all(color: AppColors.gray900, width: 4)
                    : Border.all(
                        color: isPending
                            ? AppColors.gray300
                            : AppColors.gray900,
                        width: 2,
                      ),
              ),
            ),
            if (!isLast)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                width: 1.5,
                height: 36,
                color: AppColors.gray300,
              ),
          ],
        ),
        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.body2SemiBold.copyWith(
                  color: isPending ? AppColors.gray500 : AppColors.gray900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: AppTextStyles.body3Regular.copyWith(
                  color: AppColors.gray400,
                ),
              ),
              if (!isLast) const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
