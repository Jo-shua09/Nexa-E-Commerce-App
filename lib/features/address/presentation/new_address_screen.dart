import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';
import 'package:nexa/core/widgets/circular_icon_button.dart';
import 'package:nexa/features/address/presentation/providers/address_provider.dart';

class NewAddressScreen extends ConsumerStatefulWidget {
  const NewAddressScreen({super.key});

  @override
  ConsumerState<NewAddressScreen> createState() => _NewAddressScreenState();
}

class _NewAddressScreenState extends ConsumerState<NewAddressScreen> {
  String? _selectedNickname;
  final TextEditingController _addressController = TextEditingController();
  bool _isDefault = false;

  final List<String> _nicknames = ['Home', 'Office', 'Apartment', 'Other'];

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  bool get _isFormValid =>
      _selectedNickname != null && _addressController.text.trim().isNotEmpty;

  void _showSuccessDialog() {
    final screenContext = context;

    showDialog(
      context: screenContext,
      barrierDismissible: false,
      builder: (dialogContext) => Dialog(
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
                'Your new address has been added.',
                style: AppTextStyles.body2Regular.copyWith(
                  color: AppColors.gray500,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(dialogContext, rootNavigator: true).pop();
                    if (screenContext.mounted) {
                      screenContext.pop();
                    }
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
                    'Thanks',
                    style: AppTextStyles.body2SemiBold.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveAddress() {
    if (!_isFormValid) return;

    final newAddress = DeliveryAddress(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nickname: _selectedNickname!,
      fullAddress: _addressController.text.trim(),
      isDefault: _isDefault,
    );

    ref.read(addressListProvider.notifier).addAddress(newAddress);
    _showSuccessDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray100,
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
          'New Address',
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
          Positioned.fill(
            child: Container(
              color: const Color(0xFFE5E5E5),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 120),
                  child: Icon(
                    Icons.location_on,
                    size: 64,
                    color: AppColors.gray900,
                  ),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: SingleChildScrollView(
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
                          'Address',
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
                    const SizedBox(height: 16),

                    Text(
                      'Address Nickname',
                      style: AppTextStyles.body2Regular.copyWith(
                        color: AppColors.gray900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedNickname,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.gray900,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Choose one',
                        hintStyle: AppTextStyles.body2Regular.copyWith(
                          color: AppColors.gray400,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
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
                      items: _nicknames.map((name) {
                        return DropdownMenuItem(
                          value: name,
                          child: Text(name, style: AppTextStyles.body2Regular),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => _selectedNickname = value);
                      },
                    ),
                    const SizedBox(height: 12),

                    Text(
                      'Full Address',
                      style: AppTextStyles.body2Regular.copyWith(
                        color: AppColors.gray900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _addressController,
                      onChanged: (_) => setState(() {}),
                      style: AppTextStyles.body2Regular.copyWith(
                        color: AppColors.gray900,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter your full address...',
                        hintStyle: AppTextStyles.body2Regular.copyWith(
                          color: AppColors.gray400,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
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
                    const SizedBox(height: 8),

                    // Set as Default Checkbox
                    GestureDetector(
                      onTap: () => setState(() => _isDefault = !_isDefault),
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: _isDefault
                                  ? AppColors.gray900
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: _isDefault
                                    ? AppColors.gray900
                                    : AppColors.gray300,
                                width: 1.5,
                              ),
                            ),
                            child: _isDefault
                                ? const Icon(
                                    Icons.check,
                                    size: 14,
                                    color: AppColors.white,
                                  )
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Make this as a default address',
                            style: AppTextStyles.body2Regular.copyWith(
                              color: AppColors.gray500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Add Button
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _isFormValid ? _saveAddress : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.gray900,
                          disabledBackgroundColor: AppColors.gray200,
                          foregroundColor: AppColors.white,
                          disabledForegroundColor: AppColors.gray400,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        child: Text('Add', style: AppTextStyles.body1SemiBold),
                      ),
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
