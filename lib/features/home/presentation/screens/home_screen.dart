import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';
import 'package:nexa/features/products/presentation/widgets/product_grid_section.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int selectedIndex = 0;
  final List<String> categories = [
    "All",
    "Tops",
    "Outerwear",
    "Bottoms",
    "Footwear",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          "Discover",
          style: AppTextStyles.header2SemiBold.copyWith(
            color: AppColors.gray900,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            tooltip: 'Notifications',
            icon: const Icon(Icons.notifications_none_rounded, size: 24),
          ),
        ],
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: AppColors.gray400,
                        size: 20,
                      ),
                      hintText: "Search for clothes...",
                      hintMaxLines: 1,
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: AppColors.gray400,
                      ),
                      suffixIcon: Icon(
                        Icons.mic_none_rounded,
                        color: AppColors.gray400,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                SizedBox(
                  height: 48,
                  width: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.gray900,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.tune_rounded, color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 35,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedIndex == index;
                  return Padding(
                    padding: EdgeInsets.only(right: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected
                                ? AppColors.white
                                : AppColors.gray200,
                            width: 1.2,
                          ),
                          color: isSelected
                              ? AppColors.gray900
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          categories[index],
                          style: AppTextStyles.body3SemiBold.copyWith(
                            color: isSelected
                                ? AppColors.white
                                : AppColors.gray900,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: const ProductGridSection(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
