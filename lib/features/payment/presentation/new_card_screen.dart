import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';
import 'package:nexa/core/widgets/circular_icon_button.dart';
import 'package:nexa/features/payment/presentation/providers/payment_provider.dart';

class NewCardScreen extends ConsumerStatefulWidget {
  const NewCardScreen({super.key});

  @override
  ConsumerState<NewCardScreen> createState() => _NewCardScreenState();
}

class _NewCardScreenState extends ConsumerState<NewCardScreen> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvcController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvcController.dispose();
    super.dispose();
  }

  bool get _isFormValid =>
      _cardNumberController.text.length >= 16 &&
      _expiryController.text.isNotEmpty &&
      _cvcController.text.isNotEmpty;

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF22C55E), width: 3),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Color(0xFF22C55E),
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Congratulations!',
                style: AppTextStyles.header2SemiBold.copyWith(
                  color: AppColors.gray900,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Your new card has been added.',
                style: AppTextStyles.body2Regular.copyWith(
                  color: AppColors.gray500,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gray900,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: Text('Thanks', style: AppTextStyles.body2SemiBold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveCard() {
    if (!_isFormValid) return;

    final newCard = PaymentCardModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      brand: 'VISA', // simplified assumption
      last4: _cardNumberController.text.substring(
        _cardNumberController.text.length - 4,
      ),
    );

    ref.read(paymentListProvider.notifier).addCard(newCard);
    _showSuccessDialog();
  }

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
            size: 22,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'New Card',
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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(color: AppColors.gray100, thickness: 1, height: 1),
                    const SizedBox(height: 16),
                    Text(
                      'Add Debit or Credit Card',
                      style: AppTextStyles.body2SemiBold.copyWith(
                        color: AppColors.gray900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Text(
                      'Card number',
                      style: AppTextStyles.body2Regular.copyWith(
                        color: AppColors.gray900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _CustomTextField(
                      controller: _cardNumberController,
                      hintText: 'Enter your card number',
                      keyboardType: TextInputType.number,
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 16),

                    // Expiry & CVC Row
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Expiry Date',
                                style: AppTextStyles.body2Regular.copyWith(
                                  color: AppColors.gray900,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _CustomTextField(
                                controller: _expiryController,
                                hintText: 'MM/YY',
                                keyboardType: TextInputType.datetime,
                                onChanged: (_) => setState(() {}),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Security Code',
                                style: AppTextStyles.body2Regular.copyWith(
                                  color: AppColors.gray900,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _CustomTextField(
                                controller: _cvcController,
                                hintText: 'CVC',
                                keyboardType: TextInputType.number,
                                suffixIcon: const Icon(
                                  Icons.help_outline_rounded,
                                  color: AppColors.gray400,
                                  size: 20,
                                ),
                                onChanged: (_) => setState(() {}),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isFormValid ? _saveCard : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gray900,
                    disabledBackgroundColor: AppColors.gray200,
                    foregroundColor: AppColors.white,
                    disabledForegroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text('Add Card', style: AppTextStyles.body1SemiBold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  const _CustomTextField({
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      style: AppTextStyles.body2Regular.copyWith(color: AppColors.gray900),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.body2Regular.copyWith(
          color: AppColors.gray400,
        ),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.gray200, width: 1.2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.gray200, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.gray900, width: 1.2),
        ),
      ),
    );
  }
}
