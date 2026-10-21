import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';
import 'package:nexa/features/orders/presentation/providers/completed_orders_provider.dart';

class CompletedOrdersList extends ConsumerWidget {
  const CompletedOrdersList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedOrders = ref.watch(completedOrdersProvider);

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      physics: const BouncingScrollPhysics(),
      itemCount: completedOrders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final order = completedOrders[index];
        final hasImage = order.product.images.isNotEmpty;

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.gray200, width: 1.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Container(
                width: 80,
                height: 90,
                decoration: BoxDecoration(
                  color: AppColors.gray100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: hasImage
                      ? Image.network(
                          order.product.images.first,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.image_not_supported_outlined,
                            color: AppColors.gray400,
                          ),
                        )
                      : const Icon(
                          Icons.image_not_supported_outlined,
                          color: AppColors.gray400,
                        ),
                ),
              ),
              const SizedBox(width: 8),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            order.product.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.body2SemiBold.copyWith(
                              color: AppColors.gray900,
                            ),
                          ),
                        ),
                        // Green Completed Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFDCFCE7,
                            ), // Light green background
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Completed',
                            style: AppTextStyles.body3SemiBold.copyWith(
                              color: const Color(0xFF166534),
                              fontSize: 10,
                            ), // Dark green text
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Size ${order.size}',
                      style: AppTextStyles.body3Regular.copyWith(
                        color: AppColors.gray500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$ ${order.product.price.toStringAsFixed(0)}',
                          style: AppTextStyles.body2SemiBold.copyWith(
                            color: AppColors.gray900,
                          ),
                        ),

                        // Review Action or Score Badge
                        if (order.reviewScore == null)
                          SizedBox(
                            height: 32,
                            child: ElevatedButton(
                              onPressed: () {
                                _LeaveReviewSheet.show(context, ref, order.id);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.gray900,
                                foregroundColor: AppColors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                'Leave Review',
                                style: AppTextStyles.body3SemiBold.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          )
                        else
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.gray100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  color: Color(0xFFFFB800),
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${order.reviewScore}/5',
                                  style: AppTextStyles.body3SemiBold.copyWith(
                                    color: AppColors.gray900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Bottom Sheet Modal for Reviews
class _LeaveReviewSheet extends StatefulWidget {
  final WidgetRef ref;
  final String orderId;

  const _LeaveReviewSheet({required this.ref, required this.orderId});

  static Future<void> show(
    BuildContext context,
    WidgetRef ref,
    String orderId,
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: _LeaveReviewSheet(ref: ref, orderId: orderId),
      ),
    );
  }

  @override
  State<_LeaveReviewSheet> createState() => _LeaveReviewSheetState();
}

class _LeaveReviewSheetState extends State<_LeaveReviewSheet> {
  int _selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                'Leave a Review',
                style: AppTextStyles.header3SemiBold.copyWith(
                  color: AppColors.gray900,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.close_rounded,
                  color: AppColors.gray900,
                  size: 22,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'How was your order?',
            style: AppTextStyles.body2SemiBold.copyWith(
              color: AppColors.gray900,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Please give your rating and also your review.',
            style: AppTextStyles.body2Regular.copyWith(
              color: AppColors.gray500,
            ),
          ),
          const SizedBox(height: 16),

          // Star Selector
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () => setState(() => _selectedRating = index + 1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    Icons.star_rounded,
                    size: 40,
                    color: index < _selectedRating
                        ? const Color(0xFFFFB800)
                        : AppColors.gray200,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),

          // Review Text Area
          TextField(
            maxLines: 4,
            style: AppTextStyles.body2Regular.copyWith(
              color: AppColors.gray900,
            ),
            decoration: InputDecoration(
              hintText: 'Write your review...',
              hintStyle: AppTextStyles.body2Regular.copyWith(
                color: AppColors.gray400,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.gray200,
                  width: 1.2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.gray200,
                  width: 1.2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.gray900,
                  width: 1.2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Submit Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _selectedRating > 0
                  ? () {
                      widget.ref
                          .read(completedOrdersProvider.notifier)
                          .submitReview(
                            widget.orderId,
                            _selectedRating.toDouble(),
                          );
                      Navigator.pop(context);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gray900,
                disabledBackgroundColor: AppColors.gray200,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: Text('Submit', style: AppTextStyles.body2SemiBold),
            ),
          ),
        ],
      ),
    );
  }
}
