import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/drink_model.dart';
import '../../../providers/drink_provider.dart';
import 'drink_form_screen.dart';

class ManageDrinksScreen extends StatefulWidget {
  const ManageDrinksScreen({super.key});

  @override
  State<ManageDrinksScreen> createState() => _ManageDrinksScreenState();
}

class _ManageDrinksScreenState extends State<ManageDrinksScreen> {
  final _searchCtrl = TextEditingController();

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
        content: Text('Bạn có chắc chắn muốn xóa "${drink.name}" khỏi hệ thống?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Hủy')),
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
    final drinks = drinkProvider.filteredDrinks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản Lý Đồ Uống & Công Thức'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Thêm Đồ Uống', style: TextStyle(color: Colors.white)),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const DrinkFormScreen()),
          );
        },
      ),
      body: Column(
        children: [
          // Search box
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (val) => drinkProvider.setSearchQuery(val),
              decoration: InputDecoration(
                hintText: 'Tìm kiếm theo tên hoặc mô tả...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchCtrl.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchCtrl.clear();
                          drinkProvider.setSearchQuery('');
                        },
                      )
                    : null,
              ),
            ),
          ),

          // Drink List
          Expanded(
            child: drinks.isEmpty
                ? const Center(child: Text('Không tìm thấy đồ uống nào.'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: drinks.length,
                    itemBuilder: (context, index) {
                      final drink = drinks[index];
                      final catName = drinkProvider.getCategoryName(drink.categoryId);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              drink.imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 60,
                                height: 60,
                                color: AppColors.primaryLight,
                                child: const Icon(Icons.local_cafe, color: AppColors.primary),
                              ),
                            ),
                          ),
                          title: Text(
                            drink.name,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                '📁 $catName • ⏱️ ${drink.cookingTimeMinutes}p • 📊 ${drink.difficulty}',
                                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '🧪 ${drink.ingredients.length} nguyên liệu • 📝 ${drink.steps.length} bước',
                                style: const TextStyle(fontSize: 12, color: AppColors.primaryDark),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit_outlined, color: AppColors.info),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => DrinkFormScreen(initialDrink: drink),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: AppColors.error),
                                onPressed: () => _confirmDelete(context, drink),
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
    );
  }
}

