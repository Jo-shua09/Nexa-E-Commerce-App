import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';
import 'package:nexa/core/widgets/circular_icon_button.dart';
import 'package:nexa/features/search/presentation/providers/search_providers.dart';
import 'package:nexa/features/search/presentation/widgets/empty_search_widget.dart';
import 'package:nexa/features/search/presentation/widgets/recent_search_widget.dart';
import 'package:nexa/features/search/presentation/widgets/search_result_widget.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _searchController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: ref.read(searchQueryProvider),
    );
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onQueryChanged(String value) {
    ref.read(searchQueryProvider.notifier).state = value;
  }

  void _selectSearchTerm(String term) {
    _searchController.text = term;
    ref.read(searchQueryProvider.notifier).state = term;
    ref.read(recentSearchesProvider.notifier).addSearch(term);
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(searchQueryProvider);
    final searchResults = ref.watch(searchResultsProvider);
    final recentSearches = ref.watch(recentSearchesProvider);

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
          'Search',
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
      body: Column(
        children: [
          // Search Input Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.gray200, width: 1.2),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  const Icon(
                    Icons.search_rounded,
                    color: AppColors.gray400,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      focusNode: _focusNode,
                      onChanged: _onQueryChanged,
                      onSubmitted: (value) {
                        ref
                            .read(recentSearchesProvider.notifier)
                            .addSearch(value);
                      },
                      style: AppTextStyles.body1Regular.copyWith(
                        color: AppColors.gray900,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search for clothes...',
                        hintStyle: AppTextStyles.body1Regular.copyWith(
                          color: AppColors.gray400,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  if (query.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        _searchController.clear();
                        _onQueryChanged('');
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          Icons.close_rounded,
                          color: AppColors.gray500,
                          size: 20,
                        ),
                      ),
                    ),
                  const Icon(
                    Icons.mic_none_rounded,
                    color: AppColors.gray500,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                // State 1: Query is empty -> Recent Searches
                if (query.trim().isEmpty) {
                  return RecentSearchWidget(
                    recentSearches: recentSearches,
                    onSelect: _selectSearchTerm,
                    onRemove: (term) {
                      ref
                          .read(recentSearchesProvider.notifier)
                          .removeSearch(term);
                    },
                    onClearAll: () {
                      ref.read(recentSearchesProvider.notifier).clearAll();
                    },
                  );
                }
                // State 3: Query is non-empty, but no matching results
                if (searchResults.isEmpty) {
                  return const EmptySearchWidget();
                }
                // State 2: Query has matching items -> Results List
                return SearchResultWidget(
                  results: searchResults,
                  onSelectProduct: (product) {
                    ref
                        .read(recentSearchesProvider.notifier)
                        .addSearch(product.title);
                    context.push('/home/product/${product.id}');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
