import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/language_toggle_button.dart';
import '../../../data/models/drink_model.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/drink_provider.dart';
import 'drink_detail_screen.dart';
import 'taste_recommendation_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final drinkProvider = context.watch<DrinkProvider>();
    final drinks = drinkProvider.filteredDrinks;
    final categories = drinkProvider.categories;
    final selectedCat = drinkProvider.selectedCategoryId;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.homeTitle),
        actions: const [LanguageToggleButton()],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            children: [
              // Search box
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: TextField(
                  onChanged: (val) => drinkProvider.setSearchQuery(val),
                  decoration: InputDecoration(
                    hintText: l10n.searchRecipesHint,
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),

              // Categories horizontal bar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.auto_awesome,
                      color: Colors.orange,
                    ),
                    title: Text(
                      l10n.suggestionBannerTitle,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(l10n.suggestionBannerSubtitle),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const TasteRecommendationScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),

              SizedBox(
                height: 44,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(l10n.allCategories),
                        selected: selectedCat == 'all',
                        selectedColor: AppColors.primary,
                        labelStyle: TextStyle(
                          color: selectedCat == 'all'
                              ? Colors.white
                              : AppColors.textPrimary,
                          fontWeight: selectedCat == 'all'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        onSelected: (_) =>
                            drinkProvider.setCategoryFilter('all'),
                      ),
                    ),
                    ...categories.map((c) {
                      final isSelected = selectedCat == c.id;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(_categoryName(l10n, c.id, c.name)),
                          selected: isSelected,
                          selectedColor: AppColors.primary,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : AppColors.textPrimary,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                          onSelected: (_) =>
                              drinkProvider.setCategoryFilter(c.id),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Drinks list
              Expanded(
                child: drinks.isEmpty
                    ? Center(child: Text(l10n.noMatchingRecipes))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        itemCount: drinks.length,
                        itemBuilder: (context, index) {
                          final drink = drinks[index];
                          final catName = drinkProvider.getCategoryName(
                            context,
                            drink.categoryId,
                          );

                          return Card(
                            margin: const EdgeInsets.only(bottom: 18),
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        DrinkDetailScreen(drink: drink),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Ảnh đồ uống rõ nét tỷ lệ 16:10
                                  Stack(
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 16 / 10,
                                        child: Image.network(
                                          drink.imageUrl,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                          errorBuilder: (_, _, _) => Container(
                                            color: AppColors.primaryLight,
                                            child: const Icon(
                                              Icons.local_cafe,
                                              size: 50,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 12,
                                        left: 12,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withValues(
                                              alpha: 0.65,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Text(
                                            catName,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: DecoratedBox(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: IconButton(
                                            tooltip:
                                                drinkProvider.isDrinkSaved(
                                                  drink.id,
                                                )
                                                ? 'Bỏ lưu đồ uống'
                                                : 'Lưu đồ uống',
                                            onPressed: () => drinkProvider
                                                .toggleDrinkSaved(drink.id),
                                            icon: Icon(
                                              drinkProvider.isDrinkSaved(
                                                    drink.id,
                                                  )
                                                  ? Icons.bookmark
                                                  : Icons.bookmark_border,
                                              color:
                                                  drinkProvider.isDrinkSaved(
                                                    drink.id,
                                                  )
                                                  ? AppColors.accent
                                                  : AppColors.textPrimary,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 58,
                                        right: 12,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: AppColors.accent,
                                                size: 14,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                '${drink.rating}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(14),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          drink.getName(context),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          drink.getDescription(context),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.timer_outlined,
                                              size: 16,
                                              color: AppColors.textSecondary,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              l10n.minutes(
                                                drink.cookingTimeMinutes,
                                              ),
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: AppColors.textSecondary,
                                              ),
                                            ),
                                            const SizedBox(width: 14),
                                            const Icon(
                                              Icons.bar_chart_outlined,
                                              size: 16,
                                              color: AppColors.textSecondary,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              drink.getDifficulty(context),
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: AppColors.textSecondary,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              l10n.viewRecipeArrow,
                                              style: TextStyle(
                                                color: AppColors.primary,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _categoryName(AppLocalizations l10n, String id, String fallback) {
  switch (id) {
    case 'cat_coffee':
      return l10n.coffeeCategory;
    case 'cat_milk_tea':
      return l10n.milkTeaCategory;
    case 'cat_juice':
      return l10n.juiceCategory;
    case 'cat_soda':
      return l10n.sodaCategory;
    default:
      return fallback;
  }
}

String _difficultyName(AppLocalizations l10n, String value) {
  switch (value) {
    case 'Dễ':
      return l10n.easy;
    case 'Khó':
      return l10n.hard;
    case 'Trung bình':
      return l10n.medium;
    default:
      return value;
  }
}

class DrinkCard extends StatelessWidget {
  final DrinkModel drink;
  final String categoryName;
  final bool isSaved;
  final VoidCallback? onSaveToggle;
  final VoidCallback? onTap;

  const DrinkCard({
    super.key,
    required this.drink,
    required this.categoryName,
    this.isSaved = false,
    this.onSaveToggle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 10,
                  child: Image.network(
                    drink.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.primaryLight,
                      child: const Icon(
                        Icons.local_cafe,
                        size: 50,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _localizedCategoryName(
                        l10n,
                        drink.categoryId,
                        categoryName,
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      tooltip: isSaved ? l10n.unsaveDrink : l10n.saveDrink,
                      onPressed: onSaveToggle,
                      icon: Icon(
                        isSaved ? Icons.bookmark : Icons.bookmark_border,
                        color: isSaved
                            ? AppColors.accent
                            : AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 58,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppColors.accent,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${drink.rating}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    drink.getName(context),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    drink.getDescription(context),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        l10n.minutes(drink.cookingTimeMinutes),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Icon(
                        Icons.bar_chart_outlined,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _difficultyName(l10n, drink.difficulty),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        l10n.viewRecipe,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _localizedCategoryName(
    AppLocalizations l10n,
    String categoryId,
    String fallback,
  ) {
    switch (categoryId) {
      case 'cat_coffee':
        return l10n.coffeeCategory;
      case 'cat_milk_tea':
        return l10n.milkTeaCategory;
      case 'cat_juice':
        return l10n.juiceCategory;
      case 'cat_soda':
        return l10n.sodaCategory;
      default:
        return fallback;
    }
  }
}
