import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';
import 'package:nexa/core/widgets/adaptive_dropdown.dart';
import 'package:nexa/core/widgets/circular_icon_button.dart';

class MyDetailsScreen extends StatefulWidget {
  const MyDetailsScreen({super.key});

  @override
  State<MyDetailsScreen> createState() => _MyDetailsScreenState();
}

class _MyDetailsScreenState extends State<MyDetailsScreen> {
  final _nameController = TextEditingController(text: 'John Doe');
  final _emailController = TextEditingController(text: 'example@email.com');
  final _dobController = TextEditingController(text: '12/07/1990');
  final _phoneController = TextEditingController(text: '803 123 4567');
  String _selectedGender = 'Male';

  Future<void> _pickDateOfBirth() async {
    final now = DateTime.now();
    final existingDate = _parseDateOfBirth(_dobController.text);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: existingDate ?? DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1900),
      lastDate: now,
      helpText: 'Select date of birth',
    );

    if (pickedDate != null) {
      _dobController.text = _formatDateOfBirth(pickedDate);
    }
  }

  DateTime? _parseDateOfBirth(String value) {
    final parts = value.split('/');
    if (parts.length != 3) return null;

    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);
    if (day == null || month == null || year == null) return null;

    final date = DateTime(year, month, day);
    if (date.year != year || date.month != month || date.day != day) {
      return null;
    }
    final today = DateTime.now();
    if (date.isAfter(DateTime(today.year, today.month, today.day))) return null;
    return date;
  }

  String _formatDateOfBirth(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _phoneController.dispose();
    super.dispose();
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
          'My Details',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel('Full Name'),
            _buildTextField(_nameController),

            _buildLabel('Email Address'),
            _buildTextField(
              _emailController,
              keyboardType: TextInputType.emailAddress,
            ),

            _buildLabel('Date of Birth'),
            _buildTextField(
              _dobController,
              keyboardType: TextInputType.number,
              inputFormatters: [DateOfBirthInputFormatter()],
              suffixIcon: IconButton(
                tooltip: 'Choose date of birth',
                onPressed: _pickDateOfBirth,
                icon: const Icon(
                  Icons.calendar_today_outlined,
                  color: AppColors.gray400,
                  size: 20,
                ),
              ),
            ),

            _buildLabel('Gender'),
            AdaptiveDropdown<String>(
              value: _selectedGender,
              itemLabel: (gender) => gender,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.gray900,
              ),
              decoration: _inputDecoration(),
              style: AppTextStyles.body2Regular,
              items: const ['Male', 'Female', 'Other'],
              isExpanded: true,
              onChanged: (val) => setState(() => _selectedGender = val!),
            ),

            _buildLabel('Phone Number'),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.gray200, width: 1.2),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      children: [
                        const Text(
                          '🇳🇬',
                          style: TextStyle(fontSize: 18),
                        ), // Nigeria flag
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.gray500,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '+234',
                          style: AppTextStyles.body2Regular.copyWith(
                            color: AppColors.gray900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 24, color: AppColors.gray200),
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      style: AppTextStyles.body2Regular.copyWith(
                        color: AppColors.gray900,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () => context.pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gray900,
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
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        text,
        style: AppTextStyles.body2Regular.copyWith(color: AppColors.gray900),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller, {
    Widget? suffixIcon,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: AppTextStyles.body2Regular.copyWith(color: AppColors.gray900),
      decoration: _inputDecoration(suffixIcon: suffixIcon),
    );
  }

  InputDecoration _inputDecoration({Widget? suffixIcon}) {
    return InputDecoration(
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
    );
  }
}

class DateOfBirthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final limitedDigits = digits.length > 8 ? digits.substring(0, 8) : digits;
    final output = StringBuffer();
    for (var i = 0; i < limitedDigits.length; i++) {
      if (i == 2 || i == 4) output.write('/');
      output.write(limitedDigits[i]);
    }

    final formatted = output.toString();
    final oldCursor = newValue.selection.extentOffset.clamp(
      0,
      newValue.text.length,
    );
    final digitsBeforeCursor = newValue.text
        .substring(0, oldCursor)
        .replaceAll(RegExp(r'\D'), '')
        .length
        .clamp(0, limitedDigits.length);
    var cursor = digitsBeforeCursor;
    if (digitsBeforeCursor > 2) cursor++;
    if (digitsBeforeCursor > 4) cursor++;

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: cursor),
    );
  }
}
