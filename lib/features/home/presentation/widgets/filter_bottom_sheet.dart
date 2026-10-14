import 'package:flutter/material.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const FilterBottomSheet(),
    );
  }

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String _selectedSort = 'Relevance';
  RangeValues _priceRange = const RangeValues(0, 190);
  String _selectedSize = 'L';

  final List<String> _sortOptions = [
    'Relevance',
    'Price: Low - High',
    'Price: High - Low',
  ];

  final List<String> _sizeOptions = ['S', 'M', 'L', 'XL', 'XXL'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag Handle Pill
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

          // Header Row: Title & Close Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filters',
                style: AppTextStyles.header3SemiBold.copyWith(
                  color: AppColors.gray900,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.close_rounded,
                  color: AppColors.gray900,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 1. Sort By
          Text(
            'Sort By',
            style: AppTextStyles.body1SemiBold.copyWith(
              color: AppColors.gray900,
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _sortOptions.map((option) {
                final isSelected = _selectedSort == option;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedSort = option),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.gray900 : AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.gray900
                              : AppColors.gray200,
                        ),
                      ),
                      child: Text(
                        option,
                        style: AppTextStyles.body2Medium.copyWith(
                          color: isSelected
                              ? AppColors.white
                              : AppColors.gray700,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),

          // 2. Price Range Slider
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price',
                style: AppTextStyles.body1SemiBold.copyWith(
                  color: AppColors.gray900,
                ),
              ),
              Text(
                '\$${_priceRange.start.round()} - \$${_priceRange.end.round()}',
                style: AppTextStyles.body2Regular.copyWith(
                  color: AppColors.gray500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppColors.gray900,
              inactiveTrackColor: AppColors.gray200,
              thumbColor: AppColors.white,
              overlayColor: AppColors.gray900.withValues(alpha: 0.1),
              trackHeight: 2.0,
              rangeThumbShape: const _CustomRangeThumbShape(),
            ),
            child: RangeSlider(
              values: _priceRange,
              min: 0,
              max: 500,
              onChanged: (values) {
                setState(() => _priceRange = values);
              },
            ),
          ),
          const SizedBox(height: 16),

          // 3. Size Dropdown Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Size',
                style: AppTextStyles.body1SemiBold.copyWith(
                  color: AppColors.gray900,
                ),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedSize,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.gray500,
                    size: 20,
                  ),
                  style: AppTextStyles.body1Medium.copyWith(
                    color: AppColors.gray900,
                  ),
                  items: _sizeOptions.map((size) {
                    return DropdownMenuItem(value: size, child: Text(size));
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedSize = val);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),

          // 4. Apply Filters Action Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
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
                'Apply Filters',
                style: AppTextStyles.body1SemiBold.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Minimal circular slider thumb with border
class _CustomRangeThumbShape extends RangeSliderThumbShape {
  const _CustomRangeThumbShape();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(18, 18);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool? isOnTop,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final canvas = context.canvas;
    final fillPaint = Paint()..color = AppColors.white;
    final borderPaint = Paint()
      ..color = AppColors.gray900
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, 9, fillPaint);
    canvas.drawCircle(center, 9, borderPaint);
  }
}
