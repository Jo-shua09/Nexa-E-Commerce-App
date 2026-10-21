import 'package:flutter/material.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';
import 'package:nexa/core/widgets/CustomRangeThumbShape.dart';
import 'package:nexa/core/widgets/full_width_range_slider_track_shape.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
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
  RangeValues _priceRange = const RangeValues(0, 120);
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
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
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
          Divider(color: AppColors.gray700, thickness: .1, height: 24),
          Text(
            'Sort By',
            style: AppTextStyles.body2SemiBold.copyWith(
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
                        horizontal: 12,
                        vertical: 8,
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
          const SizedBox(height: 8),
          Divider(color: AppColors.gray700, thickness: .1, height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price',
                style: AppTextStyles.body2SemiBold.copyWith(
                  color: AppColors.gray900,
                ),
              ),
              Text(
                '\$${_priceRange.start.round()} - \$${_priceRange.end.round()}',
                style: AppTextStyles.body3Regular.copyWith(
                  color: AppColors.gray500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppColors.gray900,
              inactiveTrackColor: AppColors.gray200,
              thumbColor: AppColors.white,
              overlayColor: AppColors.gray900.withValues(alpha: 0.1),
              trackHeight: 2.0,
              padding: EdgeInsets.zero,
              rangeTrackShape: const FullWidthRangeSliderTrackShape(),
              rangeThumbShape: const CustomRangeThumbShape(),
            ),
            child: RangeSlider(
              values: _priceRange,
              min: 0,
              max: 1000,
              onChanged: (values) {
                setState(() => _priceRange = values);
              },
            ),
          ),
          const SizedBox(height: 8),
          Divider(color: AppColors.gray700, thickness: .1, height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Size',
                style: AppTextStyles.body2SemiBold.copyWith(
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
                  style: AppTextStyles.body3Regular.copyWith(
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
          SizedBox(
            width: double.infinity,
            height: 54,
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
                style: AppTextStyles.body2SemiBold.copyWith(
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
