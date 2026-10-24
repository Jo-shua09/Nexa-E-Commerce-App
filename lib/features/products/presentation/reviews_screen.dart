import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';
import 'package:nexa/core/widgets/circular_icon_button.dart';

class ReviewItem {
  final String author;
  final String relativeTime;
  final int rating;
  final String content;

  const ReviewItem({
    required this.author,
    required this.relativeTime,
    required this.rating,
    required this.content,
  });
}

class ReviewsScreen extends StatelessWidget {
  final String productId;

  const ReviewsScreen({super.key, required this.productId});

  static const List<ReviewItem> dummyReviews = [
    ReviewItem(
      author: 'Wade Warren',
      relativeTime: '6 days ago',
      rating: 5,
      content:
          'The item is very good, my son likes it very much and plays every day.',
    ),
    ReviewItem(
      author: 'Guy Hawkins',
      relativeTime: '1 week ago',
      rating: 4,
      content:
          'The seller is very fast in sending packet, I just bought it and the item arrived in just 1 day!',
    ),
    ReviewItem(
      author: 'Robert Fox',
      relativeTime: '2 weeks ago',
      rating: 4,
      content:
          'I just bought it and the stuff is really good! I highly recommend it!',
    ),
  ];

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
            size: 24,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Reviews',
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
          Divider(color: AppColors.gray100, thickness: 1, height: 1),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '4.0',
                    style: AppTextStyles.header1SemiBold.copyWith(
                      color: AppColors.gray900,
                      fontSize: 48,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star_rounded,
                            size: 24,
                            color: index < 4
                                ? const Color(0xFFFFB800)
                                : AppColors.gray200,
                          );
                        }),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '1034 Ratings',
                          style: AppTextStyles.body3Regular.copyWith(
                            color: AppColors.gray400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _RatingBarRow(starCount: 5, fillRatio: 0.85),
                  SizedBox(height: 6),
                  _RatingBarRow(starCount: 4, fillRatio: 0.60),
                  SizedBox(height: 6),
                  _RatingBarRow(starCount: 3, fillRatio: 0.35),
                  SizedBox(height: 6),
                  _RatingBarRow(starCount: 2, fillRatio: 0.20),
                  SizedBox(height: 6),
                  _RatingBarRow(starCount: 1, fillRatio: 0.08),
                ],
              ),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Divider(color: AppColors.gray100, thickness: 1, height: 1),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '45 Reviews',
                style: AppTextStyles.body1SemiBold.copyWith(
                  color: AppColors.gray900,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Most Relevant',
                    style: AppTextStyles.body2Regular.copyWith(
                      color: AppColors.gray500,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.gray500,
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          ...dummyReviews.map((review) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Star rating row
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      Icons.star_rounded,
                      size: 16,
                      color: index < review.rating
                          ? const Color(0xFFFFB800)
                          : AppColors.gray200,
                    );
                  }),
                ),
                const SizedBox(height: 10),
                Text(
                  review.content,
                  style: AppTextStyles.body2Regular.copyWith(
                    color: AppColors.gray600,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      review.author,
                      style: AppTextStyles.body2SemiBold.copyWith(
                        color: AppColors.gray900,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 3,
                      height: 3,
                      decoration: const BoxDecoration(
                        color: AppColors.gray400,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      review.relativeTime,
                      style: AppTextStyles.body3Regular.copyWith(
                        color: AppColors.gray400,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
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
      ),
    );
  }
}

class _RatingBarRow extends StatelessWidget {
  final int starCount;
  final double fillRatio;

  const _RatingBarRow({required this.starCount, required this.fillRatio});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: List.generate(5, (index) {
            return Icon(
              Icons.star_rounded,
              size: 24,
              color: index < starCount
                  ? const Color(0xFFFFB800)
                  : AppColors.gray200,
            );
          }),
        ),
        const SizedBox(width: 8),

        Expanded(
          child: Container(
            height: 5,
            decoration: BoxDecoration(
              color: AppColors.gray100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fillRatio,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.gray900,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
