import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/drink_model.dart';
import '../../../providers/drink_provider.dart';
import '../../user/screens/drink_detail_screen.dart';
import 'drink_form_screen.dart';

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
        title: const Text('Xác nhận xóa đồ uống'),
        content: Text(
          'Bạn có chắc chắn muốn xóa "${drink.name}" khỏi hệ thống?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () async {
              Navigator.of(ctx).pop();
              await context.read<DrinkProvider>().deleteDrink(drink.id);
            },
            child: const Text('Xóa', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final drinkProvider = context.watch<DrinkProvider>();
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
      appBar: AppBar(title: const Text('Quản Lý Đồ Uống & Công Thức')),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Thêm Đồ Uống',
          style: TextStyle(color: Colors.white),
        ),
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
                    hintText: 'Tìm kiếm theo tên hoặc mô tả...',
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
                        label: Text('Tất cả (${allDrinks.length})'),
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
                          label: Text('${c.name} ($count)'),
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
                            const Text(
                              'Không tìm thấy công thức đồ uống nào.',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 15,
                              ),
                            ),
                            if (_selectedCategory != 'all')
                              TextButton(
                                onPressed: () =>
                                    setState(() => _selectedCategory = 'all'),
                                child: const Text('Xem tất cả danh mục'),
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
                          final catName = drinkProvider.getCategoryName(
                            drink.categoryId,
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
                                drink.name,
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
                                    '📁 $catName • ⏱️ ${drink.cookingTimeMinutes}p • 📊 ${drink.difficulty}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '🧪 ${drink.ingredients.length} nguyên liệu • 📝 ${drink.steps.length} bước',
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
                                    tooltip: 'Sửa công thức',
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
                                    tooltip: 'Xóa',
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
