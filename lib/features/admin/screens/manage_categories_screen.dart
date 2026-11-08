import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/validators.dart';
import '../../../data/models/category_model.dart';
import '../../../providers/drink_provider.dart';

class ManageCategoriesScreen extends StatelessWidget {
  const ManageCategoriesScreen({super.key});

  void _showCategoryDialog(BuildContext context, [CategoryModel? existing]) {
    final isEditing = existing != null;
    final nameCtrl = TextEditingController(text: existing?.name ?? '');
    final descCtrl = TextEditingController(text: existing?.description ?? '');
    final imgCtrl = TextEditingController(text: existing?.imageUrl ?? '');
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(isEditing ? 'Sửa Danh Mục' : 'Thêm Danh Mục Mới'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Tên danh mục',
                    hintText: 'Ví dụ: Trà trái cây',
                  ),
                  validator: (val) => Validators.validateRequired(val, 'tên danh mục'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: descCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Mô tả ngắn',
                    hintText: 'Mô tả đặc trưng danh mục...',
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: imgCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Đường dẫn ảnh (URL)',
                    hintText: 'https://images.unsplash.com/...',
                  ),
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
                  description: descCtrl.text.trim(),
                  imageUrl: imgCtrl.text.trim().isNotEmpty ? imgCtrl.text.trim() : null,
                );
                await drinkProvider.updateCategory(updated);
              } else {
                final newCat = CategoryModel(
                  id: 'cat_${DateTime.now().millisecondsSinceEpoch}',
                  name: nameCtrl.text.trim(),
                  description: descCtrl.text.trim(),
                  imageUrl: imgCtrl.text.trim().isNotEmpty ? imgCtrl.text.trim() : null,
                );
                await drinkProvider.addCategory(newCat);
              }
              nav.pop();
            },
            child: Text(isEditing ? 'Cập Nhật' : 'Thêm Mới'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, CategoryModel category) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: Text('Bạn có chắc muốn xóa danh mục "${category.name}" không?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Hủy')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () async {
              Navigator.of(ctx).pop();
              await context.read<DrinkProvider>().deleteCategory(category.id);
            },
            child: const Text('Xóa', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = context.watch<DrinkProvider>().categories;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản Lý Danh Mục'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Thêm Danh Mục', style: TextStyle(color: Colors.white)),
        onPressed: () => _showCategoryDialog(context),
      ),
      body: categories.isEmpty
          ? const Center(child: Text('Chưa có danh mục nào.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(10),
                        image: (cat.imageUrl != null && cat.imageUrl!.isNotEmpty)
                            ? DecorationImage(
                                image: NetworkImage(cat.imageUrl!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: (cat.imageUrl == null || cat.imageUrl!.isEmpty)
                          ? const Icon(Icons.category, color: AppColors.primary)
                          : null,
                    ),
                    title: Text(cat.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      cat.description ?? 'Không có mô tả',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, color: AppColors.info, size: 20),
                          onPressed: () => _showCategoryDialog(context, cat),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: AppColors.error, size: 20),
                          onPressed: () => _confirmDelete(context, cat),
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
