import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/language_toggle_button.dart';
import '../../../data/models/drink_model.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/drink_provider.dart';
import '../../user/screens/drink_detail_screen.dart';
import 'drink_form_screen.dart';

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

class ManageDrinksScreen extends StatefulWidget {
  final String? initialCategoryId;

  const ManageDrinksScreen({super.key, this.initialCategoryId});

  @override
  State<ManageDrinksScreen> createState() => _ManageDrinksScreenState();
}

class _ManageDrinksScreenState extends State<ManageDrinksScreen> {
  final _searchCtrl = TextEditingController();
  late String _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategoryId ?? 'all';
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _confirmDelete(BuildContext context, DrinkModel drink) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.confirmDelete),
        content: Text(
          AppLocalizations.of(context)!.deleteDrinkConfirmation(
            drink.getName(context),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () async {
              Navigator.of(ctx).pop();
              await context.read<DrinkProvider>().deleteDrink(drink.id);
            },
            child: Text(
              AppLocalizations.of(context)!.delete,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final drinkProvider = context.watch<DrinkProvider>();
    final l10n = AppLocalizations.of(context)!;
    final allDrinks = drinkProvider.drinks;
    final categories = drinkProvider.categories;

    // Lọc độc lập không bị ảnh hưởng bởi bộ lọc ở màn hình Người dùng
    final query = _searchCtrl.text.trim().toLowerCase();
    final drinks = allDrinks.where((d) {
      final matchesCategory =
          _selectedCategory == 'all' || d.categoryId == _selectedCategory;
      final matchesSearch =
          query.isEmpty ||
          d.name.toLowerCase().contains(query) ||
          d.description.toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.manageDrinksTitle),
        actions: const [LanguageToggleButton()],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(l10n.addDrink, style: TextStyle(color: Colors.white)),
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const DrinkFormScreen()));
        },
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              // Ô tìm kiếm
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: l10n.searchByNameDescription,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchCtrl.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchCtrl.clear();
                              setState(() {});
                            },
                          )
                        : null,
                  ),
                ),
              ),

              // Bộ lọc danh mục ngay trong giao diện Admin
              SizedBox(
                height: 44,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(l10n.allDrinksCount(allDrinks.length)),
                        selected: _selectedCategory == 'all',
                        selectedColor: AppColors.primary,
                        labelStyle: TextStyle(
                          color: _selectedCategory == 'all'
                              ? Colors.white
                              : AppColors.textPrimary,
                          fontWeight: _selectedCategory == 'all'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        onSelected: (_) =>
                            setState(() => _selectedCategory = 'all'),
                      ),
                    ),
                    ...categories.map((c) {
                      final isSelected = _selectedCategory == c.id;
                      final count = allDrinks
                          .where((d) => d.categoryId == c.id)
                          .length;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text('${c.getName(context)} ($count)'),
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
                              setState(() => _selectedCategory = c.id),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // Danh sách đồ uống
              Expanded(
                child: drinks.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.local_cafe_outlined,
                              size: 56,
                              color: AppColors.textLight,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              l10n.noDrinkRecipes,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 15,
                              ),
                            ),
                            if (_selectedCategory != 'all')
                              TextButton(
                                onPressed: () =>
                                    setState(() => _selectedCategory = 'all'),
                                child: Text(l10n.viewAllCategories),
                              ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        itemCount: drinks.length,
                        itemBuilder: (context, index) {
                          final drink = drinks[index];
                          final catName = _localizedCategoryName(
                            l10n,
                            drink.categoryId,
                            drinkProvider.getCategoryName(context, drink.categoryId),
                          );

                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              onTap: () {
                                // Cho phép Admin bấm vào xem chi tiết công thức
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        DrinkDetailScreen(drink: drink),
                                  ),
                                );
                              },
                              contentPadding: const EdgeInsets.all(12),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  drink.imageUrl,
                                  width: 65,
                                  height: 65,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 65,
                                    height: 65,
                                    color: AppColors.primaryLight,
                                    child: const Icon(
                                      Icons.local_cafe,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                drink.getName(context),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Text(
                                    '📁 $catName • ⏱️ ${drink.cookingTimeMinutes} ${l10n.minuteUnit} • 📊 ${drink.getDifficulty(context)}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '🧪 ${l10n.ingredientStepCount(drink.ingredients.length, drink.getSteps(context).length)}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryDark,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit_outlined,
                                      color: AppColors.info,
                                    ),
                                    tooltip: l10n.editLabel,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => DrinkFormScreen(
                                            initialDrink: drink,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: AppColors.error,
                                    ),
                                    tooltip: l10n.delete,
                                    onPressed: () =>
                                        _confirmDelete(context, drink),
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
