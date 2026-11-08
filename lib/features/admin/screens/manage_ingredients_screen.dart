import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/validators.dart';
import '../../../data/models/ingredient_model.dart';
import '../../../providers/drink_provider.dart';

class ManageIngredientsScreen extends StatelessWidget {
  const ManageIngredientsScreen({super.key});

  void _showIngredientDialog(BuildContext context, [IngredientModel? existing]) {
    final isEditing = existing != null;
    final nameCtrl = TextEditingController(text: existing?.name ?? '');
    final unitCtrl = TextEditingController(text: existing?.unit ?? 'g');
    final descCtrl = TextEditingController(text: existing?.description ?? '');
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(isEditing ? 'Sửa Nguyên Liệu' : 'Thêm Nguyên Liệu'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Tên nguyên liệu',
                    hintText: 'Ví dụ: Sữa đặc Ông Thọ',
                  ),
                  validator: (val) => Validators.validateRequired(val, 'tên nguyên liệu'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: unitCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Đơn vị tính',
                    hintText: 'ml, g, quả, lá, muỗng...',
                  ),
                  validator: (val) => Validators.validateRequired(val, 'đơn vị tính'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: descCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Ghi chú / Mô tả',
                    hintText: 'Đặc tính, cách bảo quản...',
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) return;
              final drinkProvider = context.read<DrinkProvider>();
              final nav = Navigator.of(ctx);
              if (isEditing) {
                final updated = existing.copyWith(
                  name: nameCtrl.text.trim(),
                  unit: unitCtrl.text.trim(),
                  description: descCtrl.text.trim(),
                );
                await drinkProvider.updateIngredient(updated);
              } else {
                final newIng = IngredientModel(
                  id: 'ing_${DateTime.now().millisecondsSinceEpoch}',
                  name: nameCtrl.text.trim(),
                  unit: unitCtrl.text.trim(),
                  description: descCtrl.text.trim(),
                );
                await drinkProvider.addIngredient(newIng);
              }
              nav.pop();
            },
            child: Text(isEditing ? 'Cập Nhật' : 'Thêm Mới'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, IngredientModel ingredient) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: Text('Bạn có chắc muốn xóa nguyên liệu "${ingredient.name}" không?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Hủy')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () async {
              Navigator.of(ctx).pop();
              await context.read<DrinkProvider>().deleteIngredient(ingredient.id);
            },
            child: const Text('Xóa', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ingredients = context.watch<DrinkProvider>().ingredients;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản Lý Nguyên Liệu'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.secondary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Thêm Nguyên Liệu', style: TextStyle(color: Colors.white)),
        onPressed: () => _showIngredientDialog(context),
      ),
      body: ingredients.isEmpty
          ? const Center(child: Text('Chưa có nguyên liệu nào.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                final ing = ingredients[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: AppColors.secondary.withOpacity(0.12),
                      child: const Icon(Icons.kitchen_rounded, color: AppColors.secondary),
                    ),
                    title: Text(ing.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Đơn vị: ${ing.unit} ${ing.description != null ? "• ${ing.description}" : ""}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, color: AppColors.info, size: 20),
                          onPressed: () => _showIngredientDialog(context, ing),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: AppColors.error, size: 20),
                          onPressed: () => _confirmDelete(context, ing),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
