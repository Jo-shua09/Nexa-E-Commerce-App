import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';
import 'package:nexa/core/widgets/circular_icon_button.dart';
import 'package:nexa/features/cart/presentation/providers/cart_provider.dart';
import 'package:nexa/features/cart/presentation/widgets/empty_cart_widget.dart';
import 'package:nexa/features/cart/presentation/widgets/stepper_button_widget.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final subtotal = ref.watch(cartSubtotalProvider);
    final total = ref.watch(cartTotalProvider);

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
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
        ),
        title: Text(
          'My Cart',
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
      body: cartItems.isEmpty
          ? const EmptyCartWidget()
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      ...cartItems.asMap().entries.map((entry) {
                        final index = entry.key;
                        final item = entry.value;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.gray100,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 68,
                                height: 68,
                                decoration: BoxDecoration(
                                  color: AppColors.gray100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: item.product.images.isNotEmpty
                                      ? Image.network(
                                          item.product.images.first,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, _, _) => const Icon(
                                            Icons.image_not_supported_outlined,
                                            color: AppColors.gray400,
                                            size: 24,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.image_not_supported_outlined,
                                          color: AppColors.gray400,
                                          size: 24,
                                        ),
                                ),
                              ),
                              const SizedBox(width: 10),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item.product.title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles.body3SemiBold
                                                .copyWith(
                                                  color: AppColors.gray900,
                                                ),
                                          ),
                                        ),
                                        IconButton(
                                          tooltip:
                                              'Remove ${item.product.title}',
                                          onPressed: () {
                                            ref
                                                .read(cartProvider.notifier)
                                                .removeItem(index);
                                          },
                                          visualDensity: VisualDensity.compact,
                                          padding: EdgeInsets.zero,
                                          constraints:
                                              const BoxConstraints.tightFor(
                                                width: 28,
                                                height: 28,
                                              ),
                                          icon: const Icon(
                                            Icons.delete_outline_rounded,
                                            color: AppColors.error,
                                            size: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Size ${item.size}',
                                      style: AppTextStyles.body3Regular
                                          .copyWith(color: AppColors.gray400),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '\$ ${item.product.price.toStringAsFixed(0)}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles.body2SemiBold
                                                .copyWith(
                                                  color: AppColors.gray900,
                                                ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        StepperButtonWidget(
                                          quantity: item.quantity,
                                          onDecrement: () => ref
                                              .read(cartProvider.notifier)
                                              .decrementQuantity(index),
                                          onIncrement: () => ref
                                              .read(cartProvider.notifier)
                                              .incrementQuantity(index),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),

                      const SizedBox(height: 8),

                      // Order Summary
                      _SummaryRow(
                        label: 'Sub-total',
                        value: '\$ ${subtotal.toStringAsFixed(0)}',
                        isLabel: false,
                      ),
                      const SizedBox(height: 12),
                      _SummaryRow(
                        label: 'VAT (%)',
                        value:
                            '\$ ${(subtotal * vatPercentage).toStringAsFixed(2)}',
                        isLabel: false,
                      ),
                      const SizedBox(height: 12),
                      _SummaryRow(
                        label: 'Shipping fee',
                        value: '\$ ${shippingFee.toStringAsFixed(0)}',
                        isLabel: false,
                      ),
                      const SizedBox(height: 16),
                      const Divider(
                        color: AppColors.gray100,
                        thickness: 1,
                        height: 1,
                      ),
                      const SizedBox(height: 16),
                      _SummaryRow(
                        label: 'Total',
                        value: '\$ ${total.toStringAsFixed(0)}',
                        isTotal: true,
                        isLabel: true,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),

                // Go to Checkout Button
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () => context.push('/cart/checkout'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gray900,
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Go To Checkout',
                            style: AppTextStyles.body2SemiBold.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: AppColors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
    this.isLabel = false,
  });

  final String label;
  final String value;
  final bool isTotal;
  final bool isLabel;

  final isBold = true;

  @override
  Widget build(BuildContext context) {
    final textStyle = isTotal
        ? AppTextStyles.body1SemiBold.copyWith(color: AppColors.gray900)
        : AppTextStyles.body3SemiBold.copyWith(color: AppColors.gray500);

    final textStyleLabel = isLabel
        ? AppTextStyles.body3SemiBold.copyWith(color: AppColors.gray900)
        : AppTextStyles.body3SemiBold.copyWith(color: AppColors.gray900);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: textStyle),
        Text(value, style: isBold ? textStyleLabel : textStyle),
      ],
    );
  }
}
