import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';
import 'package:nexa/core/widgets/circular_icon_button.dart';
import 'package:nexa/features/cart/presentation/providers/cart_provider.dart';
import 'package:nexa/features/cart/presentation/widgets/empty_cart_widget.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  String _selectedPaymentMethod = 'Card';
  final TextEditingController _promoController = TextEditingController();

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            size: 24,
          ),
          onPressed: () => context.pop(),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery Address',
                            style: AppTextStyles.body2SemiBold.copyWith(
                              color: AppColors.gray900,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Change',
                              style: AppTextStyles.body2Regular.copyWith(
                                color: AppColors.gray900,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            color: AppColors.gray500,
                            size: 22,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Home',
                                  style: AppTextStyles.body2SemiBold.copyWith(
                                    color: AppColors.gray900,
                                  ),
                                ),
                                const SizedBox(height: 1),
                                Text(
                                  '925 S Chugach St #APT 10, Alaska 99645',
                                  style: AppTextStyles.body3Regular.copyWith(
                                    color: AppColors.gray400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Divider(
                          color: AppColors.gray100,
                          thickness: 1,
                          height: 1,
                        ),
                      ),

                      // 2. Payment Method
                      Text(
                        'Payment Method',
                        style: AppTextStyles.body2SemiBold.copyWith(
                          color: AppColors.gray900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _PaymentOptionPill(
                            title: 'Card',
                            icon: Icons.credit_card_rounded,
                            isSelected: _selectedPaymentMethod == 'Card',
                            onTap: () =>
                                setState(() => _selectedPaymentMethod = 'Card'),
                          ),
                          const SizedBox(width: 10),
                          _PaymentOptionPill(
                            title: 'Cash',
                            icon: Icons.payments_outlined,
                            isSelected: _selectedPaymentMethod == 'Cash',
                            onTap: () =>
                                setState(() => _selectedPaymentMethod = 'Cash'),
                          ),
                          const SizedBox(width: 10),
                          _PaymentOptionPill(
                            title: 'Pay',
                            isApplePay: true,
                            isSelected: _selectedPaymentMethod == 'Apple Pay',
                            onTap: () => setState(
                              () => _selectedPaymentMethod = 'Apple Pay',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Selected Card Preview Card
                      if (_selectedPaymentMethod == 'Card') ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.gray200,
                              width: 1.2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'VISA',
                                style: AppTextStyles.body2SemiBold.copyWith(
                                  color: AppColors.gray900,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '**** **** **** 2512',
                                  style: AppTextStyles.body2SemiBold.copyWith(
                                    color: AppColors.gray900,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Icon(
                                  Icons.edit_outlined,
                                  color: AppColors.gray600,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Divider(
                            color: AppColors.gray100,
                            thickness: 1,
                            height: 1,
                          ),
                        ),
                      ],

                      // 3. Order Summary
                      Text(
                        'Order Summary',
                        style: AppTextStyles.body2SemiBold.copyWith(
                          color: AppColors.gray900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _SummaryRow(
                        label: 'Sub-total',
                        value: '\$ ${subtotal.toStringAsFixed(0)}',
                      ),
                      const SizedBox(height: 8),
                      _SummaryRow(
                        label: 'VAT (%)',
                        value:
                            '\$ ${(subtotal * vatPercentage).toStringAsFixed(2)}',
                      ),
                      const SizedBox(height: 8),
                      _SummaryRow(
                        label: 'Shipping fee',
                        value: '\$ ${shippingFee.toStringAsFixed(0)}',
                      ),
                      const SizedBox(height: 16),
                      const Divider(
                        color: AppColors.gray100,
                        thickness: 1,
                        height: 1,
                      ),
                      const SizedBox(height: 12),
                      _SummaryRow(
                        label: 'Total',
                        value: '\$ ${total.toStringAsFixed(0)}',
                        isTotal: true,
                      ),
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.gray200,
                                  width: 1.2,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.local_offer_outlined,
                                    color: AppColors.gray400,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      controller: _promoController,
                                      style: AppTextStyles.body2Regular
                                          .copyWith(color: AppColors.gray900),
                                      decoration: InputDecoration(
                                        hintText: 'Enter promo code',
                                        hintStyle: AppTextStyles.body2Regular
                                            .copyWith(color: AppColors.gray400),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        isDense: false,
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.gray900,
                                foregroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                              ),
                              child: Text(
                                'Add',
                                style: AppTextStyles.body2SemiBold.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          ref.read(cartProvider.notifier).clearCart();
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              title: Text(
                                'Order Placed!',
                                style: AppTextStyles.header3SemiBold,
                              ),
                              content: Text(
                                'Your order has been successfully placed. Thank you for shopping with Nexa.',
                                style: AppTextStyles.body2Regular,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    context.go('/home');
                                  },
                                  child: Text(
                                    'Back to Home',
                                    style: AppTextStyles.body2SemiBold.copyWith(
                                      color: AppColors.gray900,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.gray900,
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Place Order',
                          style: AppTextStyles.body2SemiBold.copyWith(
                            color: AppColors.white,
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

class _PaymentOptionPill extends StatelessWidget {
  final String title;
  final IconData? icon;
  final bool isApplePay;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentOptionPill({
    required this.title,
    this.icon,
    this.isApplePay = false,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 38,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.gray900 : AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? AppColors.gray900 : AppColors.gray200,
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isApplePay)
                Icon(
                  Icons.apple,
                  size: 20,
                  color: isSelected ? AppColors.white : AppColors.gray900,
                )
              else if (icon != null)
                Icon(
                  icon,
                  size: 18,
                  color: isSelected ? AppColors.white : AppColors.gray900,
                ),
              const SizedBox(width: 6),
              Text(
                title,
                style: AppTextStyles.body2Medium.copyWith(
                  color: isSelected ? AppColors.white : AppColors.gray900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? AppTextStyles.body1SemiBold.copyWith(color: AppColors.gray900)
              : AppTextStyles.body3Regular.copyWith(color: AppColors.gray500),
        ),
        Text(
          value,
          style: isTotal
              ? AppTextStyles.header3SemiBold.copyWith(color: AppColors.gray900)
              : AppTextStyles.body2SemiBold.copyWith(color: AppColors.gray900),
        ),
      ],
    );
  }
}
