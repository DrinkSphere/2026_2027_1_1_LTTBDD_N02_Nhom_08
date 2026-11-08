import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
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

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Công Thức Đồ Uống')),
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
                  decoration: const InputDecoration(
                    hintText: 'Tìm kiếm công thức...',
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
                    title: const Text(
                      'Chưa biết uống gì?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text('Câu hỏi gợi ý đồ uống cho bạn'),
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
                        label: const Text('Tất cả'),
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
                          label: Text(c.name),
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
                    ? const Center(
                        child: Text('Không có công thức nào phù hợp.'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        itemCount: drinks.length,
                        itemBuilder: (context, index) {
                          final drink = drinks[index];
                          final catName = drinkProvider.getCategoryName(
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
                                          errorBuilder: (_, __, ___) =>
                                              Container(
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
                                        top: 12,
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
                                          drink.name,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          drink.description,
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
                                              '${drink.cookingTimeMinutes} phút',
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
                                              drink.difficulty,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: AppColors.textSecondary,
                                              ),
                                            ),
                                            const Spacer(),
                                            const Text(
                                              'Xem công thức →',
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
